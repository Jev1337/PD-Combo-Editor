Program ComboFilter;
{$MODE DELPHI}
Uses
Wincrt,crt,sysutils;
Var
  noDupe,ComboCombined,P,U,FilterPass,UserPass,password,User,F: TextFile;
  tableau3,tableau4,tableau2,tableau: Array[1..1000000] Of String;
  Count,Info: Integer;
  g,k,j,i: Integer;
  output,path: String;

Procedure CollectUser;
//Retreives Username file
Begin
  Clrscr;
  Write('Please type or drag and drop here User File directory: ');
  Readln(Path);
  While Pos('"', path) <> 0 Do
    Delete(path, Pos('"', path), 1);
  Assign(U, path);
  Reset(U);
  Count := 0;
  While ((Not Eof(U)) And (Count < 1000000)) Do
    Begin
      Readln(U, tableau4[Count + 1]);
      Count := Count + 1;
    End;
End;
Procedure CollectPass;
//Retreives Password File
Begin
  Clrscr;
  Write('Please type or drag and drop here your Pass File directory: ');
  Readln(Path);
  While Pos('"', path) <> 0 Do
    Delete(path, Pos('"', path), 1);
  Assign(P, path);
  Reset(P);
  Count := 0;
  While ((Not Eof(P)) And (Count < 1000000)) Do
    Begin
      Readln(P, tableau3[Count + 1]);
      Count := Count + 1;
    End;
End;
Procedure CollectCombo;
//combines both files with ':' inbetween
Begin
  Clrscr;
  output := getcurrentdir+'\CombinedUserPass.txt';
  AssignFile(ComboCombined,Output);
  Try
    Rewrite(ComboCombined);
    For i:= 1 To Count Do
      Writeln(ComboCombined,tableau4[i]+':'+tableau3[i]);
  Finally
    Close(ComboCombined);
    Writeln('[',TimeToStr(Time), ' Info]: File ', getcurrentdir+'\CombinedUserPass.txt',' Created!')
    ;
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!')
End;
End;
Procedure FilterFile;
//Retreives combo file from windows and
Begin
  //Makes tableau User and Makes tableau Pass
  Clrscr;
  path := getcurrentdir+'\combo.txt';
  Assign(F, path);
  Reset(F);
  Count := 0;
  While ((Not Eof(F)) And (Count < 1000000)) Do
    Begin
      Readln(F, tableau[Count + 1]);
      Count := Count + 1;
    End;
  For i := 1 To Count Do
    Begin
      Insert(' ',tableau[i], Pos(':',tableau[i]));
      Delete(tableau[i], Pos(':', tableau[i]) ,1);
      tableau2[i] := Copy(tableau[i],Pos(' ', tableau[i]), 200);
      Delete(tableau2[i], Pos(' ', tableau2[i]), 1);
      Delete(tableau[i], Pos(' ', tableau[i]), 2000000);
    End;
  Close(F);
End;
Procedure WriteFileUser;
//Username file Output
Begin
  Delete (path, Pos('combo.txt', path), 9);
  output := path+'ResultUser.txt';
  AssignFile(User, Output);
  Try
    Rewrite(User);
    For i:= 1 To Count Do
      Writeln(User,tableau[i]);
  Finally
    Close(User);
    Writeln('[',TimeToStr(Time), ' Info]: File ', path+'ResultUser.txt',' Created!');
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!');
End;
End;
Procedure WriteFilePassword;
//Password file output
Begin
  Delete (path, Pos('combo.txt', path), 9);
  output := path+'\ResultPassword.txt';
  AssignFile(Password,Output);
  Try
    Rewrite(Password);
    For i:= 1 To Count Do
      Writeln(Password,tableau2[i]);
  Finally
    Close(Password);
    Writeln('[',TimeToStr(Time), ' Info]: File ', path+'ResultPassword.txt',' Created!');
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!');
End;
End;
Procedure MailPassUserPass;
//Makes mail combo to user combo, Useful for games such as league
Begin
  Delete (path, Pos('combo.txt', path), 9);
  For i:= 1 To count Do
    Delete(tableau[i],Pos('@', tableau[i]), 20);
  output := path+'\ResultUserPass.txt';
  AssignFile(UserPass,Output);
  Try
    Rewrite(UserPass);
    For i:= 1 To Count Do
      Writeln(UserPass,tableau[i]+':'+tableau2[i]);
  Finally
    Close(UserPass);
    Writeln('[',TimeToStr(Time), ' Info]: File ', path+'ResultUserPass.txt',' Created!');
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!');
End;
End;
Procedure FilterCapture;
//Cleans capture so you can check the files again on a checker
Begin
  Delete (path, Pos('combo.txt', path), 9);
  For i:= 1 To count Do
    Delete(tableau2[i],Pos(' ', tableau2[i]),10000000);
  output := path+'\ResultFilterCapture.txt';
  AssignFile(FilterPass,Output);
  Try
    Rewrite(FilterPass);
    For i:= 1 To Count Do
      Writeln(FilterPass,tableau[i]+':'+tableau2[i]);
  Finally
    Close(FilterPass);
    Writeln('[',TimeToStr(Time), ' Info]: File ', path+'\ResultFilterCapture.txt',' Created!');
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!');
End;
End;
Procedure RemoveDupe;
Begin
  For i:= 1 To count Do
    Begin
      For j:= 1 To count Do
        Begin
          If j<>i Then
            If (tableau[j] = tableau[i]) And (tableau2[J] = tableau2[i]) Then
              Begin
                Delete(tableau[i],1,10000);
                Delete(tableau2[i],1,10000);
              End;
        End;
    End;
  Delete (path, Pos('combo.txt', path), 9);
  output := path+'\NoDuplicate.txt';
  AssignFile(NoDupe,Output);
  Try
    Rewrite(NoDupe);
    g := 0;
    For k:= 1 To Count Do
      Begin
        tableau[k] := tableau[k]+':';
        If tableau[k] = ':' Then
          Begin
            tableau[k] := tableau[k+1];
            G := G+1;
          End;
        Writeln(NoDupe,tableau[k]+tableau2[k]);
      End;
  Finally
    Close(NoDupe);
    Writeln('[',TimeToStr(Time), ' Info]: ', g, ' Duplicates found...');
    Writeln('[',TimeToStr(Time), ' Info]: File ', path+'NoDuplicate.txt',' Created!');
    delay(500);
    Writeln('[',TimeToStr(Time), ' Info]: done!');
End;
End;

{Procedure SplitDuo;
Begin
  Write('Please type how many files you want to make: ');
  Readln(n);
  count2 := count div n;
  For i:= 1 To n Do
	Begin
    Delete (path, Pos('combo.txt', path), 9);
  Str(i, ch);
  output := path+'\Split #'+ch+'.txt';
  AssignFile(Splitter,Output);
  Try
    Rewrite(Splitter);
		if i=1 then
		For k:= 1 To count2*i Do
			Writeln(Splitter,tableau[k]+':'+tableau2[k])
		Else
    For k:= count2*(i-1) to (count2*i) -1 Do
      Writeln(Splitter,tableau[k]+':'+tableau2[k]);
  Finally
    Close(Splitter);
End;
end;
End;

Procedure Split;
Begin
Write('Please type how many files you want to make: ');
  Readln(n);
  count2 := count div n;
  For i:= 1 To n Do
	Begin
    Delete (path, Pos('combo.txt', path), 9);
  Str(i, ch);
  output := path+'\Split #'+ch+'.txt';
  AssignFile(Splitter,Output);
  Try
    Rewrite(Splitter);
		if I <> n then
    For k:= count2*(i-1) +3 to (count2*i) +2 Do
      Writeln(Splitter,tableau[k]+':'+tableau2[k]);
		if I = N Then
		for k:= count2*(i-1) +3  to (count2*i) +3 Do
		Writeln(Splitter,tableau[k]+':'+tableau2[k])
  Finally
    Close(Splitter);
	end;
end;								
end;}
Begin
TextBackground(black);
TextColor(white);
Crt.ClrScr;
  Repeat
  Clrscr;
    If fileexists(getcurrentdir+'\combo.txt') Then
      Writeln('ComboEditor Beta v2.0 - Combo location is ', getcurrentdir+'\combo.txt');
    If (FileExists(getcurrentdir+'\combo.txt')) = False Then
      Writeln('ComboEditor Beta v2.0 - Combo location is ', 'unknown');
    Writeln('       ');
    Writeln('Please Select What You want to do: ');
    Writeln('1) User:Pass -> User.txt + Pass.txt');
    Writeln('2) Mail:Pass -> User:Pass');
    Writeln('3) User/Mail:Pass Capture Filter');
    Writeln('4) Combo Combiner');
    Writeln('5) Duplicate Cleaner');
    Writeln('6) Combo Splitter (Soon)');
    Readln(Info);
    If (info = 1) And (FileExists(getcurrentdir+'\combo.txt')) = True Then
      Begin
        FilterFile;
        writefileuser;
        writefilepassword;
      End;
    If (info = 2) And (FileExists(getcurrentdir+'\combo.txt')) = True Then
      Begin
        FilterFile;
        MailPassUserPass;
      End;
    If (info = 3) And (FileExists(getcurrentdir+'\combo.txt')) = True Then
      Begin
        FilterFile;
        FilterCapture;
      End;
    If (info = 4) And (FileExists(getcurrentdir+'\combo.txt')) = True Then
      Begin
        CollectUser;
        CollectPass;
        CollectCombo;
      End;
    If (info = 5) And (FileExists(getcurrentdir+'\combo.txt')) = True Then
      Begin
        Filterfile;
        removedupe;
      End;
    If info = 1 Then
      If (FileExists(getcurrentdir+'\combo.txt')) = False Then
        Writeln('[',TimeToStr(Time), ']Error: Combo.txt not found');
    If info = 2 Then
      If (FileExists(getcurrentdir+'\combo.txt')) = False Then
        Writeln('[',TimeToStr(Time), ']Error: Combo.txt not found');
    If info = 3 Then
      If (FileExists(getcurrentdir+'\combo.txt')) = False Then
        Writeln('[',TimeToStr(Time), ']Error: Combo.txt not found');
    If info = 4 Then
      If (FileExists(getcurrentdir+'\combo.txt')) = False Then
        Writeln('[',TimeToStr(Time), ']Error: Combo.txt not found');
    If info = 5 Then
      If (FileExists(getcurrentdir+'\combo.txt')) = False Then
        Writeln('[',TimeToStr(Time), '] Error: Combo.txt not found');
  Until info In [1..5];
End.
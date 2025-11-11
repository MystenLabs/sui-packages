module 0x59868cb34f794185b99b9e70bf6e1713a72d0fd8efabf915c34c624ee05a045c::encrypter {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x59868cb34f794185b99b9e70bf6e1713a72d0fd8efabf915c34c624ee05a045c::collectivo::AdminCap, arg2: &0x59868cb34f794185b99b9e70bf6e1713a72d0fd8efabf915c34c624ee05a045c::campaign::Campaign) {
        assert!(0x2::object::id_bytes<0x59868cb34f794185b99b9e70bf6e1713a72d0fd8efabf915c34c624ee05a045c::campaign::Campaign>(arg2) == arg0, 0);
    }

    // decompiled from Move bytecode v6
}


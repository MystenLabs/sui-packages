module 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::seal_policy {
    public fun check_policy(arg0: &vector<u8>, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::License) : bool {
        if (0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::is_desk_id(arg0)) {
            return false
        };
        let v0 = 0x1::string::into_bytes(0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::template_id(arg1));
        let v1 = 0x1::vector::length<u8>(&v0);
        if (0x1::vector::length<u8>(arg0) <= v1) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v2) != *0x1::vector::borrow<u8>(&v0, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<u8>(arg0, v1) == 58
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::License) {
        assert!(check_policy(&arg0, arg1), 1);
    }

    // decompiled from Move bytecode v7
}


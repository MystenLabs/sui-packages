module 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::zkticket {
    public fun check_ticket(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = x"ad613a1eaa8fd4c11b097d14c9693b9b46d8146a753c452debbaf4ff26c66095";
        0x2::ed25519::ed25519_verify(arg0, &v0, arg1)
    }

    // decompiled from Move bytecode v6
}


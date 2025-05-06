module 0x802b66b818117e6ad5e607462bfca115529249127bb4e1d0a9bc06466150f5c0::asdsd {
    struct ASDSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDSD, arg1: &mut 0x2::tx_context::TxContext) {
        0x131d6365002a1c704d63c64df8203f42949d594d52f90e013e2ddac459e36c52::connector_v3::new<ASDSD>(arg0, 948248436, b"ASSS", b"asdsd", b"afsd", b"https://ipfs.io/ipfs/bafybeif34xynyahmdihlim77ww4kieeaiby23adnljmw7gfn37m2r5ktli", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}


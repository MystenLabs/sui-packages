module 0xc602e37ec7da380dee9de371a14bb24fe5600bff854828ddee0f3dce374774b4::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        0xdec18f0fd6e894039fd24a8519d89427ce3912a382d6454949c9d3c4d9c36f01::connector_v3::new<MAMA>(arg0, 725580446, b"MAMA", b"mama", b"mamama", b"https://ipfs.io/ipfs/bafybeif34xynyahmdihlim77ww4kieeaiby23adnljmw7gfn37m2r5ktli", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}


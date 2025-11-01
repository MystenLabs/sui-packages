module 0x4ba05abcadfa8aca2010b785f8ced2794d4ac653d16e663429ad091a85298190::camer {
    struct CAMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMER>(arg0, 9, b"CAMER", b"CAMER", b"the cry of a little, their paths and their despair", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUGmsP9EgTaco21LrG7pXcEdjhbthk17bAvAnd5PcU5GP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAMER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMER>>(v1);
    }

    // decompiled from Move bytecode v6
}


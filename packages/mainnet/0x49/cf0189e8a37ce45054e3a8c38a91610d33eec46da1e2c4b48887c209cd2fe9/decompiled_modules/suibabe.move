module 0x49cf0189e8a37ce45054e3a8c38a91610d33eec46da1e2c4b48887c209cd2fe9::suibabe {
    struct SUIBABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABE>(arg0, 6, b"Suibabe", b"Suianta babe ai", x"735549414e544120624142450a0a735549414e544120624142452069732074686520626f6c642c207374796c6973682066616365206f662063727970746f206f6e207468652053756920626c6f636b636861696e2e204669657263652c20616d626974696f75732c20616e6420756e73746f707061626c652c2073686573206865726520746f20656d706f77657220686f6c6465727320616e64206d616b6520776176657320696e20576562332e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018586_fb04f64e98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABE>>(v1);
    }

    // decompiled from Move bytecode v6
}


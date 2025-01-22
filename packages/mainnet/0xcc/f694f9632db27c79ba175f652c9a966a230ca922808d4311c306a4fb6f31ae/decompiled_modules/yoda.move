module 0xccf694f9632db27c79ba175f652c9a966a230ca922808d4311c306a4fb6f31ae::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"Yoda On Sui", b"YODA, a SUI-based cryptocurrency, is, hmm, inspired by the legendary Jedi Master himself. Wise and strong, our mission is clear: to revolutionize the crypto galaxy, one token at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_175118_149_02090b09da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}


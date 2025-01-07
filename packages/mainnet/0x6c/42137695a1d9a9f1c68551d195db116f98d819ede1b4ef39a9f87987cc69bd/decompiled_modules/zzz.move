module 0x6c42137695a1d9a9f1c68551d195db116f98d819ede1b4ef39a9f87987cc69bd::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"zzz", b"ZZZ all day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_b38ccda7e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


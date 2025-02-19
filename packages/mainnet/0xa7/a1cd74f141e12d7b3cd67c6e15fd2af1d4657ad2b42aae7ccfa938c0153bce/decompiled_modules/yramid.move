module 0xa7a1cd74f141e12d7b3cd67c6e15fd2af1d4657ad2b42aae7ccfa938c0153bce::yramid {
    struct YRAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: YRAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YRAMID>(arg0, 6, b"YRAMID", b"Yramid", b"Yramid on Sui, join the Movement!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038236_b38923438c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YRAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YRAMID>>(v1);
    }

    // decompiled from Move bytecode v6
}


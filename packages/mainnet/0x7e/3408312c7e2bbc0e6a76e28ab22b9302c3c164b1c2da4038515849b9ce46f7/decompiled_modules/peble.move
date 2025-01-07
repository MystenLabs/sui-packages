module 0x7e3408312c7e2bbc0e6a76e28ab22b9302c3c164b1c2da4038515849b9ce46f7::peble {
    struct PEBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBLE>(arg0, 6, b"PEBLE", b"pEbLe", b"pEbLe on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_15_40_50_1bdb88c35d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


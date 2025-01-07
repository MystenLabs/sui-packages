module 0x3cbc3876549a64aaa313e4b718cdf28bdb6ed13766ae4a32413a0a0f4cc8da77::cum {
    struct CUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUM>(arg0, 6, b"CUM", b"CumDog", b"Cummiest of all the dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1e7c0c450a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUM>>(v1);
    }

    // decompiled from Move bytecode v6
}


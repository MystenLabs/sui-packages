module 0x33c94b9d1c327411de76c21c7d2a73b4a0d1ff29edbc48a6d7e527f148abb0f5::trt {
    struct TRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRT>(arg0, 9, b"TRT", b"TAOURIRT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/b/b4/Montagne_44_wali_%28Taourirt%29.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRT>>(v1);
    }

    // decompiled from Move bytecode v6
}


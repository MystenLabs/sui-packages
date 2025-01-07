module 0x1fc0d59fc1d41a3a0f8579c66580153aa41dbd20df22e52f2e991a9513f95eda::seals {
    struct SEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALS>(arg0, 6, b"SEALS", b"SeaSeals", b"MY PERSONAL TOKEN SUIIIIIIIIIII!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_02_00_38_59_3053d43f7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}


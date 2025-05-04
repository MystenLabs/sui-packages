module 0x92c9a6e413453e021a6579ce16fbaae4cb1d12abfcd216ba536dd04831f6a736::w_sui {
    struct W_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: W_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W_SUI>(arg0, 9, b"wSUI", b"Wolf Staked SUI", b"Liquid Wolf Staking Derivative", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/82269a20-0bb1-4d7d-92ac-3355562a8d01/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


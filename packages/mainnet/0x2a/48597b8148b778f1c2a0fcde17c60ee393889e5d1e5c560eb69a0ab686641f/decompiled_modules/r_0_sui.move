module 0x2a48597b8148b778f1c2a0fcde17c60ee393889e5d1e5c560eb69a0ab686641f::r_0_sui {
    struct R_0_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_0_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_0_SUI>(arg0, 9, b"r0SUI", b"random0 Staked SUI", b"random lst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/bbcd2c55-370b-4842-90fe-0827956b725f/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_0_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<R_0_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


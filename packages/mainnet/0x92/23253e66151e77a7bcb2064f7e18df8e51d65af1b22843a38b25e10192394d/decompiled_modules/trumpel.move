module 0x9223253e66151e77a7bcb2064f7e18df8e51d65af1b22843a38b25e10192394d::trumpel {
    struct TRUMPEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPEL>(arg0, 6, b"Trumpel", b"Trump Christmass", b"Season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734704787932.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


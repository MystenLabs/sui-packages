module 0xc408cdf9de65a47fb0300b51fa1d12eedcbda9cce561551b33f27e91f978b49f::wefd {
    struct WEFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEFD>(arg0, 6, b"WEFD", b"wef", b"wefw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEFD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEFD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


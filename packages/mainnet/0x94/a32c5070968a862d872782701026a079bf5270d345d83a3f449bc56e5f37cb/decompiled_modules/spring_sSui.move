module 0x94a32c5070968a862d872782701026a079bf5270d345d83a3f449bc56e5f37cb::spring_sSui {
    struct SPRING_SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRING_SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRING_SSUI>(arg0, 9, b"sysSUI", b"SY Spring Staked SUI", b"SY Spring Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPRING_SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRING_SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


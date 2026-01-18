module 0x8a73eb20c559298b679d139f136f5447920c8fe82b6b4e6c6006ff705bda81ad::b_pawtato_coin_iron_bar {
    struct B_PAWTATO_COIN_IRON_BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_IRON_BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_IRON_BAR>(arg0, 9, b"bIRON_BAR", b"bToken IRON_BAR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_IRON_BAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_IRON_BAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


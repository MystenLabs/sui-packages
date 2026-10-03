module 0xf46591ae3703cd2e858534f6fc214ea663e0289eecd0f192b96cf5ce1327db40::yusdsui {
    struct YUSDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSDSUI>(arg0, 6, b"yUSDSUI", b"Kai Vault USDSUI", b"Kai Vault yield-bearing USDSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUSDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


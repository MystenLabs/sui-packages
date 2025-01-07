module 0x977168f8a483c3d4d646d1d2a5be5366510b30aa28e6d56c08530a7b1ccf66b1::sdaddy {
    struct SDADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDADDY>(arg0, 6, b"SDADDY", b"Suigar Daddy", b"$SDADDY is the Suigar Daddy with a charming appearance and tastes that appeal to desirable women. Suigar Daddy has a lot of money, attracting many women, especially widows. Suigar Daddy is ready to create a new wave in the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_94fe145bdf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8db5886238b61c92fba7b961e80f9ed9cdd231d0c9c07617307a56e09b4a3dae::onix {
    struct ONIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONIX>(arg0, 8, b"ONIX", b"Onix", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONIX>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONIX>>(v1);
    }

    // decompiled from Move bytecode v6
}


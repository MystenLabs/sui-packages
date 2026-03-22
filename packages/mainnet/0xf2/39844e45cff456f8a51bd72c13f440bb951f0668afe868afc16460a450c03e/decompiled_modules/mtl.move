module 0xf239844e45cff456f8a51bd72c13f440bb951f0668afe868afc16460a450c03e::mtl {
    struct MTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTL>(arg0, 6, b"MTL", b"MuskTrumplovers", b"Musk and Trump are secret lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774143112893.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


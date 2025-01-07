module 0x4b2c22df846e2d3b8a12a00a17a5bddb5819d872e5ee3cbc6d21a555d393cf15::ob {
    struct OB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OB>(arg0, 6, b"OB", b"ONLYBEZEL", b"OnlyBezel - because even bears need a side hustle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logooo_79d7192d1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OB>>(v1);
    }

    // decompiled from Move bytecode v6
}


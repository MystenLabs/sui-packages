module 0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb {
    struct HB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HB>(arg0, 9, b"Hb", b"Heartbeats", x"48656172746265617473202848622920e2809420746865204a656e6e79436f207265776172647320746f6b656e206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jennyco.app/heartbeats-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HB>>(0x2::coin::mint<HB>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


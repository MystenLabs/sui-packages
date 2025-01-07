module 0x3a186d43c61c7f5c47afa5cd6fa0ee93ea9ddd2fc495b8bc9fee0d60d0191d90::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 6, b"HH", b"Hamster Homies", b"There's always that one homey ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Fans_e587f5c0e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}


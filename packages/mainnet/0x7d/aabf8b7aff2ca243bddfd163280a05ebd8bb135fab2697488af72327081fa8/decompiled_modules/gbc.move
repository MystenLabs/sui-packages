module 0x7daabf8b7aff2ca243bddfd163280a05ebd8bb135fab2697488af72327081fa8::gbc {
    struct GBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBC>(arg0, 6, b"GBC", b"Green Banana Coin", b"Green Banana Coin is everything about banana zone. If You believe in 2024 Crypto pump You should have some!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Green_Banana_3f907d3388.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBC>>(v1);
    }

    // decompiled from Move bytecode v6
}


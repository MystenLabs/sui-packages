module 0x8f821706d7748bb6cd6f440253ec91a171f0eb7d1e47c583d1240d0fb48b434d::dolans {
    struct DOLANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLANS>(arg0, 6, b"DOLANS", b"First Dolan Duck On Sui", b"First Dolan Duck On Sui.https://dolanducksui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apple_touch_icon_1_c9ee724fc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLANS>>(v1);
    }

    // decompiled from Move bytecode v6
}


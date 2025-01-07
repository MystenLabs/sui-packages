module 0x3666268362cfa259e9e0cbbf544b4666319c5774b797b737d2a78c5ff61c51ad::mcd {
    struct MCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCD>(arg0, 9, b"MCD", b"MCED", b"FARMING ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51f659ec-6cf3-4ee9-aacf-dd595b7d3b6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCD>>(v1);
    }

    // decompiled from Move bytecode v6
}


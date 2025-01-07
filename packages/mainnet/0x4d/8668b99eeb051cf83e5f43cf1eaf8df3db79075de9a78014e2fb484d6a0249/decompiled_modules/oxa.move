module 0x4d8668b99eeb051cf83e5f43cf1eaf8df3db79075de9a78014e2fb484d6a0249::oxa {
    struct OXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXA>(arg0, 9, b"OXA", b"oxalus", b"coin for comunity trader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa900c2f-afd9-47bf-97c8-fb6d8ec3c623.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXA>>(v1);
    }

    // decompiled from Move bytecode v6
}


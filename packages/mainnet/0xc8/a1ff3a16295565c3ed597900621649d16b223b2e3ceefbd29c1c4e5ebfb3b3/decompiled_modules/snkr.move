module 0xc8a1ff3a16295565c3ed597900621649d16b223b2e3ceefbd29c1c4e5ebfb3b3::snkr {
    struct SNKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNKR>(arg0, 9, b"SNKR", b"Snaker", b"Its been a hot cake in fute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/421d25f7-71b4-4f0f-b787-0492368f79f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNKR>>(v1);
    }

    // decompiled from Move bytecode v6
}


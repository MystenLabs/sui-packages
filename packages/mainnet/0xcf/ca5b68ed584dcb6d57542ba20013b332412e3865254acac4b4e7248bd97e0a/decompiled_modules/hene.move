module 0xcfca5b68ed584dcb6d57542ba20013b332412e3865254acac4b4e7248bd97e0a::hene {
    struct HENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENE>(arg0, 9, b"HENE", b"hrnne", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70d3f39c-fc9b-44fc-8acf-f579c2fc09da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HENE>>(v1);
    }

    // decompiled from Move bytecode v6
}


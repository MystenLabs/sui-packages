module 0xc86c6e026eb7428de28da2c4dbfe639c135f661c379ad02b49cbc032fd00fa61::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 9, b"HEHE", b"Huhuhu", b"Abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/307921cf-f243-4726-9226-3b80f7ecd251.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}


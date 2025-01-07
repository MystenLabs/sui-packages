module 0xa3c7db1a6f2005cb4db575313a8fffd249f8dd8409dc6f240456160f71a57dc0::asghar {
    struct ASGHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASGHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASGHAR>(arg0, 9, b"ASGHAR", b"Sumbal", b"This is nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c13dd64-e1a7-4211-9d24-313b1fcc268f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASGHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASGHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc97a301579d7a71f84f425651f6a68a62345d1b1db9e8aaecec8f42d7a07a8e6::tober {
    struct TOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBER>(arg0, 9, b"TOBER", b"Uptober20", x"5570746f6265722020666573746976616c20666f7220737569205473756e616d69206d6f6f6e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f866912-9419-4625-828a-a312a38e0e2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7f94a2b8ea2981e4e924e7600a1405a50c5879e65ebb49b3ddbbaa43cb7f778a::otm {
    struct OTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTM>(arg0, 9, b"OTM", b"Otman", b"Otmtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e656c1b-cd6a-4fc6-a4fb-c436cbaecfd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTM>>(v1);
    }

    // decompiled from Move bytecode v6
}


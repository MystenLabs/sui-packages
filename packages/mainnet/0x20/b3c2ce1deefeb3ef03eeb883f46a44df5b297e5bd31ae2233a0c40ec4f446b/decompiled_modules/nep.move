module 0x20b3c2ce1deefeb3ef03eeb883f46a44df5b297e5bd31ae2233a0c40ec4f446b::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 9, b"NEP", b"NEPTUNE", b"Token for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f449886e-5a19-41e2-8bf3-0af82e05e15a-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}


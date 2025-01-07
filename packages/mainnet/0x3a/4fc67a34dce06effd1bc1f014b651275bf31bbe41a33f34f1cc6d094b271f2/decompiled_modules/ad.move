module 0x3a4fc67a34dce06effd1bc1f014b651275bf31bbe41a33f34f1cc6d094b271f2::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 9, b"AD", b"Aidoge ", b"ELON MUSK TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/703e74ec-7c69-4f54-ab10-431826eea7c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    // decompiled from Move bytecode v6
}


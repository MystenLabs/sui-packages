module 0x27f7f63a1fae7d397f789777cad4a8aa9cbc15544a1e1d1e17624f58a33c5ca7::amu {
    struct AMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMU>(arg0, 9, b"AMU", b"AmongUs ", b"being an imposter of your own self. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39fc358d-f28a-49e1-a62c-8d6b3dd89205.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMU>>(v1);
    }

    // decompiled from Move bytecode v6
}


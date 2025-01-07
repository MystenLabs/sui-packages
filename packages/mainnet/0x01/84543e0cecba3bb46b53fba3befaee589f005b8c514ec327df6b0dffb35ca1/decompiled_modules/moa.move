module 0x184543e0cecba3bb46b53fba3befaee589f005b8c514ec327df6b0dffb35ca1::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOA>(arg0, 9, b"MOA", b"Moai", b"It's just a rock ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43085dc3-536f-4f04-941d-309a1266e16d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOA>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf3854a5e82ddda4ef90746cdaa4e4da2821a7db9896967c1890039cd942bc405::muu {
    struct MUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUU>(arg0, 9, b"MUU", b"Mowa", b"Mowatoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23d4925b-e8f2-42e2-b5db-3ee1bbc456d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUU>>(v1);
    }

    // decompiled from Move bytecode v6
}


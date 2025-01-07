module 0x462002e2721a943d41ce3ca99c145f93370daf816daa14289ab62bf59f8d990b::chi47 {
    struct CHI47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI47>(arg0, 9, b"CHI47", b"Chizzy", b"Simplicity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da0a13a0-b237-4b3b-997d-61dd2f68eb19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHI47>>(v1);
    }

    // decompiled from Move bytecode v6
}


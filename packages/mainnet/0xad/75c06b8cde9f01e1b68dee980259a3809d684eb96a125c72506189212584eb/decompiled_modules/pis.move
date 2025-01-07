module 0xad75c06b8cde9f01e1b68dee980259a3809d684eb96a125c72506189212584eb::pis {
    struct PIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIS>(arg0, 9, b"PIS", b"PISUI", b"This is a future coin you should invest in for the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aee3c8a-0e31-4343-96e5-42214443faf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


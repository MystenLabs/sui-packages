module 0x67f748e5bb26fec2093c917efd08c5b96c88aae6fa7a1c875021f1d15560764a::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 9, b"COW", b"Party cow", b"Party cow every night", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca9088b8-414f-4f03-b553-ec7c78eddfca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    // decompiled from Move bytecode v6
}


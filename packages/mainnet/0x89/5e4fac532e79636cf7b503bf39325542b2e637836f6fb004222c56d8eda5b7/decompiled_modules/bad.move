module 0x895e4fac532e79636cf7b503bf39325542b2e637836f6fb004222c56d8eda5b7::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 9, b"BAD", b"Badbeast", b"Beast is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ad75337-4ae9-4923-a68f-e9413e0ad345.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


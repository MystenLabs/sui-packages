module 0xdf1599f75a24f7f119fa371e403e685d4386c871742d0f61eb134ecb77da8edf::borno {
    struct BORNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORNO>(arg0, 9, b"BORNO", b"Bbb ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8aca2d9-ccc8-4fc1-904c-26a6487d1977.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORNO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1cb07fdc65c8a9532e5dc0f460209edd3e9c9addc268002be91b93a6714daacb::pwr {
    struct PWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWR>(arg0, 9, b"PWR", b"THE power", x"4120706f77657266756c20616e6420696e7669676f726174696e67206469676974616c2063757272656e637920696e73706972656420627920746865206e6174757265206f6620706f77657220616e6420656e657267790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d5a8591-16d2-454d-bfcb-ee64b3087422.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWR>>(v1);
    }

    // decompiled from Move bytecode v6
}


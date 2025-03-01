module 0xa1171df0be3ec5731a5780ab6917fea7b497a5c8615249f66cc56c46cb67dcf6::sfai {
    struct SFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFAI>(arg0, 6, b"SFAI", b"SupportFI AI", x"537570706f72744669204149206973206120437573746f6d657220537570706f727420617320612053657276696365202843536161532920706c6174666f726d207468617420656e61626c657320627573696e657373657320746f2064656c6976657220657863657074696f6e616c20737570706f7274207468726f756768206d756c7469706c6520636f6d6d756e69636174696f6e206368616e6e656c732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740798212431.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


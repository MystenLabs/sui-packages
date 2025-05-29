module 0x8aa2aba5c75553fb3d88c9fd05d820b9e68eafef3350f2188ded2cb739c83586::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 9, b"SOL", b"SOLANA", b"SOLANA COIN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/23bfbcb28e12459ce5630c5a628dc21dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


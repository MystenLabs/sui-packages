module 0x61c68bc5d874a0838efc1b2cbb86289843fead9052a2266279f1193bd42d9567::imoney {
    struct IMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMONEY>(arg0, 9, b"IMONEY", b"Infinite money", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ad420d42d6b6e4175f08f6d68edf228dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMONEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x5607f256d0ca28c77be75d6ca8974ca039c0bd31b703a90d1756a6ed04959be2::monad {
    struct MONAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONAD>(arg0, 9, b"MONAD", b"Verified", b"Trust me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4bb62250729d8524edb64cac75527928blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


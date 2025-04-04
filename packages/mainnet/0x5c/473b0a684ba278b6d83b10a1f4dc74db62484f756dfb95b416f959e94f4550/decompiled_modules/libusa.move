module 0x5c473b0a684ba278b6d83b10a1f4dc74db62484f756dfb95b416f959e94f4550::libusa {
    struct LIBUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBUSA>(arg0, 9, b"LibUSA", b"Libertarian USA", b"A cry, an idea that never dies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3aca3ebd7f21345d1819128bb89aa9e3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIBUSA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBUSA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


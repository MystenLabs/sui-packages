module 0xe8d641da0089cdd99fcac8cddbaf36201bde2746a5540dd2b2a4a9c69c9f03e9::Terminator {
    struct TERMINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINATOR>(arg0, 9, b"TRMNT", b"Terminator", b"pure destroyer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5zts0CEG427RaU-wW1LvlYADfrXwuInoHhA&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMINATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINATOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


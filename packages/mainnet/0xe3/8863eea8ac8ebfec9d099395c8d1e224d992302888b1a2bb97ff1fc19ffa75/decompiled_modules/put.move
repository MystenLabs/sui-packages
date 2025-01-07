module 0xe38863eea8ac8ebfec9d099395c8d1e224d992302888b1a2bb97ff1fc19ffa75::put {
    struct PUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PUT>(arg0, 6, b"PUT", b"PUTIN THE DOG", b"I'm putin the dog i just celebrated christmas. You better ask the right questions cause i'll bite and lick your near ear sweats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/471779890_929413892500142_7690949927628151349_n_2e8aa4ac7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


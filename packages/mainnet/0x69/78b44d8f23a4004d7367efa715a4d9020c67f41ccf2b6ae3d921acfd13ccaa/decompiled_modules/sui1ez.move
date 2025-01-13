module 0x6978b44d8f23a4004d7367efa715a4d9020c67f41ccf2b6ae3d921acfd13ccaa::sui1ez {
    struct SUI1EZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI1EZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI1EZ>(arg0, 6, b"Sui1ez", b"Sui1ez AI", b"SUI network's first anime-based AI project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736785339485.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI1EZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI1EZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


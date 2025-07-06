module 0x320cb50efbc7e8759e724d9f6e3d16e54ddafaf932d199c65b0490c0dab44c9::Repe {
    struct REPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPE>(arg0, 9, b"REPE", b"Repe", b"retarded pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8d5a400b-8be8-4c72-a424-a5f75f22bb5d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


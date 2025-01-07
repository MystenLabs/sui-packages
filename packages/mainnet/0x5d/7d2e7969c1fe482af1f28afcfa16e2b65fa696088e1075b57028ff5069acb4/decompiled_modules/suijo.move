module 0x5d7d2e7969c1fe482af1f28afcfa16e2b65fa696088e1075b57028ff5069acb4::suijo {
    struct SUIJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJO>(arg0, 6, b"SUIJO", b"Suijokoen", b"Suijo is a Japanese Sui Ocean, inside it there is Blub and other Sui Gems yet to be discovered", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wed_2_10_2024_04_37_01_318f2fa9d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJO>>(v1);
    }

    // decompiled from Move bytecode v6
}


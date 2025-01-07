module 0x3eff2a93a0dcc666ca3f630c56c5ee84a43f3a50183db289d1acc5bc8684cfa6::faker {
    struct FAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKER>(arg0, 9, b"FAKER", b"Faker", b"Hide on Bush", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAKER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}


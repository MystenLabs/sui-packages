module 0x6f8261a5f628efa6f58bf3c3be9af3fc0d3460b461aaeee356a261c24c0e3f4c::wape {
    struct WAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPE>(arg0, 6, b"WAPE", b"WAPE on SUI", x"4f776e2024574150452c2061636869657665206162736f6c7574656c79206e6f7468696e67200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1_45b398097c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


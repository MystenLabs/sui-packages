module 0x62def143756644f135ea30bcd1bf83887ff5f0dcc00c32188acf9afb5ef76c06::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 6, b"DGS", b"Doggyonsui", b"doggyonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/untitled_2_20240820042118_t9wex_b889d6bb98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x41e9ea88bb6a9535878949ed54c6fcaf75ff1f5a67db28848ece0a3f4602535e::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Sui Pepe Whale", x"44696420796f75206d69737320504550453f204e6f20776f7272792120486572652069732050455045205748414c4520696e2053554920666f7220796f752e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_c9d744fb2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}


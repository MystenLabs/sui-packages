module 0xfb391a9c2d0026b334bcd49ea88e3d4949a5b0e5bc14143cc344c7ad03945c26::pepris {
    struct PEPRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPRIS>(arg0, 6, b"PEPRIS", b"PEPRIS SUI", x"5045505249532067616d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_24e2801557.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


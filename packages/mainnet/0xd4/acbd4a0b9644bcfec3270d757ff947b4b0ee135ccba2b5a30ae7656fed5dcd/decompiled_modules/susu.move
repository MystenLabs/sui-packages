module 0xd4acbd4a0b9644bcfec3270d757ff947b4b0ee135ccba2b5a30ae7656fed5dcd::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 6, b"SUSU", b"Sui The Bull", b"Susu, Sui the bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUSU_100_7bba8a6aaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}


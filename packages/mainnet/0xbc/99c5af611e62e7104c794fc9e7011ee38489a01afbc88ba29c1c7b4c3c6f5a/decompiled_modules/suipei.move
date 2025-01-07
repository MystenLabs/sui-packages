module 0xbc99c5af611e62e7104c794fc9e7011ee38489a01afbc88ba29c1c7b4c3c6f5a::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"Suipei", b"SUIPEI", b"Meet Suipei the feline warrior raised in a small ancient village in China by his elderly master PeiPei, an expert in the ancient art of \"Feline Krypto Fu.\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a9_RO_248_Z_400x400_45e3bd7e3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x61d36ba3a17e0e2149f7623bbaa47ec8ac17e9bcced9c3d230b19d2d17f4c05d::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 6, b"GENGAR", b"GENGAR ON SUI", b"GENGAR ON SUI CHAIN WILL TOP 1 MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8e60dc40d25565867da4e0cd9c55411043f14c19_3810e4fddc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x5ae18dcd50fe18ef7e0a2c6080972838c01923918c551c5624a0a369175e0a70::icg {
    struct ICG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICG>(arg0, 6, b"ICG", b"Iceberg", b"The meme coin which have real world utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_6c7a4966b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICG>>(v1);
    }

    // decompiled from Move bytecode v6
}


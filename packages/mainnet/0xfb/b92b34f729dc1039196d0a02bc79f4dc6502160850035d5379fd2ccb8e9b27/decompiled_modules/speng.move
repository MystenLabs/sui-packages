module 0xfbb92b34f729dc1039196d0a02bc79f4dc6502160850035d5379fd2ccb8e9b27::speng {
    struct SPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENG>(arg0, 6, b"SPENG", b"Suipeng Sui", b"the coolest token to waddle its way onto the Sui Network! Just", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_000620_789df2ca5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}


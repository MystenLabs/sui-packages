module 0x23ad9590e755520194afc5334afff54cec149bbbfeacb74f2e260165f4d13923::suiball {
    struct SUIBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBALL>(arg0, 6, b"Suiball", b"Suiball Red", x"56657273696f6e3a20526564200a7652", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000801_3ec5224482.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}


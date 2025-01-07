module 0x1f8b42862ddca030b8465007f7720fba6a629fdd4529342bb218b9ae7eb65496::suipx6900 {
    struct SUIPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPX6900>(arg0, 6, b"SUIPX6900", b"SUI SPX6900", b"6,900 Traders storm the NYSE trading floor to proclaim that 6900 is better than 500.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/250x250_6722d2cc95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}


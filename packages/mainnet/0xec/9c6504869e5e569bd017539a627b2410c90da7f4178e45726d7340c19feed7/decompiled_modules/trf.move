module 0xec9c6504869e5e569bd017539a627b2410c90da7f4178e45726d7340c19feed7::trf {
    struct TRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRF>(arg0, 6, b"TRF", b"TRUMPFRIES", b"Sui Trumpfries to the moon !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004350_bd16c60644.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRF>>(v1);
    }

    // decompiled from Move bytecode v6
}


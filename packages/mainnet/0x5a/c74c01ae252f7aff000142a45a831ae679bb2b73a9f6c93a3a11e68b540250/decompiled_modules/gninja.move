module 0x5ac74c01ae252f7aff000142a45a831ae679bb2b73a9f6c93a3a11e68b540250::gninja {
    struct GNINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNINJA>(arg0, 6, b"GNINJA", b"GRENINJA", b"Unlock the power of the ocean with $GRENINJA, the premier cryptocurrency on the Sui Chain designed for both seasoned investors and passionate Pokemon fans. Inspired by the most beloved Water-type Pokemon, $GRENINJA combines cutting-edge blockchain technology with a vibrant community spirit to offer unparalleled opportunities for growth and engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GREN_1fa0020352.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}


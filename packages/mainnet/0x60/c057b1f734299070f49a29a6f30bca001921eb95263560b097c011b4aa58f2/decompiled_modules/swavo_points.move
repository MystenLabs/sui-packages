module 0x60c057b1f734299070f49a29a6f30bca001921eb95263560b097c011b4aa58f2::swavo_points {
    struct SWAVO_POINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAVO_POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAVO_POINTS>(arg0, 2, b"Swavo Points", b"SVP", b"Trading Points on Swavo.fi Platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Cetus_fd3e9a7dbd.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAVO_POINTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAVO_POINTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun points(arg0: &mut 0x2::coin::TreasuryCap<SWAVO_POINTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWAVO_POINTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


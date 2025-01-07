module 0xa67e029bb32d5d80a5a512d3e4e7e168159ab95f7270d002d8b8e3b2f7b7305::food {
    struct FOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOD>(arg0, 6, b"Food", b"Food Test", b"Food testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052811_64d8cc55d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


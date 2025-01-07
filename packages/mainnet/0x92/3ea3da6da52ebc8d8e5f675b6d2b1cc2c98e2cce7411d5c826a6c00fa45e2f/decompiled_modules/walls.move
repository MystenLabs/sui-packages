module 0x923ea3da6da52ebc8d8e5f675b6d2b1cc2c98e2cce7411d5c826a6c00fa45e2f::walls {
    struct WALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLS>(arg0, 6, b"WALLS", b"Wall sui Boys ", b"Wall street wolfs live ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991630599.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


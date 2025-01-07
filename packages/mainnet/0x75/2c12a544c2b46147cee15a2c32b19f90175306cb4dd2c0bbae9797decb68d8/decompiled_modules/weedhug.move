module 0x752c12a544c2b46147cee15a2c32b19f90175306cb4dd2c0bbae9797decb68d8::weedhug {
    struct WEEDHUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEDHUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEDHUG>(arg0, 6, b"WEEDHUG", b"WeedHug on SUI", b"Smokin' Success, One spliff at a Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hog_18a7c7bccd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEDHUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEEDHUG>>(v1);
    }

    // decompiled from Move bytecode v6
}


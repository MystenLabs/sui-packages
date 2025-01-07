module 0x95af45b854bd0a0e20ad2565401159a1912b140e994e3ab0f88f681d671d167f::booble {
    struct BOOBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBLE>(arg0, 6, b"BOOBLE", b"Sui Booble", b"Original memes on sui network - BOOBLE is sugar momma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013423_b62a4e3245.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


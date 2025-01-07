module 0xa060f8e6a3537f13e06ad7a49eae748c0c0afdf11db8f256587ba7d8888e143c::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"Burger", b"Burger coin is a crucial part of the Nincompoops brand and a daily dose of nutritious goodness for all nincompoops. It's delicious, it's tasty, and it's the perfect snack for anyone who's part of the burger-loving community. Enjoy the savory $BURGER token as part of your digital diet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixel_burger_1e2f05265e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}


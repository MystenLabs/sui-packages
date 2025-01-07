module 0x61fcb1a80ab4ea4281b7f24e91308ec3bd44c2b84c79bad5b743e5fc1cca2c98::bbdog {
    struct BBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBDOG>(arg0, 9, b"BBDOG", b"BabyBunnydog", b"Sui's best dog! Always hungry for hotdogs. More than just a coin, it's the dawg of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843434409917030400/e92t01aU_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


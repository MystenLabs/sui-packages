module 0x34929d4d02490686bbd20f21ec18dcb53dede5ae7b9982aa25e72da10c833124::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HOPDOG>(arg0, 9, b"HOPDOG", b"HOPDOG", b"Sui&#39;s and Hop&#39;s best dog! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https:&#x2F;&#x2F;pbs.twimg.com&#x2F;profile_images&#x2F;1843434409917030400&#x2F;e92t01aU_400x400.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HOPDOG>(&mut v3, 18446744072999999488, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HOPDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOPDOG>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDOG>>(v2);
    }

    // decompiled from Move bytecode v6
}


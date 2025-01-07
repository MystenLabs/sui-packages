module 0xd3fa78ac297b00db14afc1dd08086aa5e6278a1044cc9bc3750690c8d595575e::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"Cool Cats", b"Sui Cool Cat Cool Community Cool To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1839201780283973632/KWMAsHLh_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


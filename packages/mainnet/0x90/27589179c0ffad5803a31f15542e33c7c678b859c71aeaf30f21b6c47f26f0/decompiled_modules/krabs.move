module 0x9027589179c0ffad5803a31f15542e33c7c678b859c71aeaf30f21b6c47f26f0::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 9, b"KRABS", b"Mr Krabs", b"Mr Krabs , meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845114782824939520/oe1qFYAD.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRABS>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}


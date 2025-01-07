module 0x9a2cd2b780278d7c7ab17c473a7737231206d5a64c147c600e3a98701b87e473::babysasha {
    struct BABYSASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSASHA>(arg0, 9, b"BABYSASHA", b"Baby Sasha", b"Len Sassaman Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842460260591689728/3dzc7ETP_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSASHA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSASHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}


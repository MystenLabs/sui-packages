module 0x6190af85aa75ac352b6a339a416a79e7f32c987627b48162eb7167e5c98a831d::BOB {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"Bob Coin", b"Bob", b"Just a friendly guy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/98307348-2c91-4ff7-8ef5-59c886809942")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, @0xa5f11852c66d81fe289b74600041f13ea29d3b43ebf53db4a5ac2d934effd6b9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}


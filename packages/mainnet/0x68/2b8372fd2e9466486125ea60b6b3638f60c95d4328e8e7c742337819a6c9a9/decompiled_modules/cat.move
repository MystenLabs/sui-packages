module 0x682b8372fd2e9466486125ea60b6b3638f60c95d4328e8e7c742337819a6c9a9::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"cat", b"CAT COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.nationalgeographic.com%2Fanimals%2Fmammals%2Ffacts%2Fdomestic-cat&psig=AOvVaw1nYDQhlI32tiC0ggOdsUw3&ust=1709977477866000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCJidjNOw5IQDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


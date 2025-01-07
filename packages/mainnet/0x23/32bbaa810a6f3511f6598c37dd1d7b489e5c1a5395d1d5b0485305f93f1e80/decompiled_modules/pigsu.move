module 0x2332bbaa810a6f3511f6598c37dd1d7b489e5c1a5395d1d5b0485305f93f1e80::pigsu {
    struct PIGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGSU>(arg0, 6, b"PIGSU", b"Piggy Sui", b"PIGSU pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fheloiizpoge%2F&psig=AOvVaw0VMLVNO9fptApxT4TyPoov&ust=1729160499581000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIj84OjckokDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGSU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}


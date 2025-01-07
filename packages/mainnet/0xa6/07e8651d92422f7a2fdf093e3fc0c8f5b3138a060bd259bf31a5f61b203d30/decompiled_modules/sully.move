module 0xa607e8651d92422f7a2fdf093e3fc0c8f5b3138a060bd259bf31a5f61b203d30::sully {
    struct SULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULLY>(arg0, 9, b"SULLY", b"Baby Sully", b"Meet the king of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841579959342473216/KNsTrIZ5_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SULLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4eeca56fd3d2806469a492698f92c1e2e0a28efda656f06626ed58bd83a12061::suider {
    struct SUIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDER>(arg0, 6, b"SUIDER", b"SUIDER Coin", b"Here you will find the best memes from movepump.com!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfs_2_d694a2ac16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}


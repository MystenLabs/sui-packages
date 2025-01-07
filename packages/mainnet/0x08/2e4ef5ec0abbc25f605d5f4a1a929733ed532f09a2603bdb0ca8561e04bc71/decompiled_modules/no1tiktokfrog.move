module 0x82e4ef5ec0abbc25f605d5f4a1a929733ed532f09a2603bdb0ca8561e04bc71::no1tiktokfrog {
    struct NO1TIKTOKFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO1TIKTOKFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO1TIKTOKFROG>(arg0, 6, b"No1tiktokfrog", b"Omochi", b"No1 tiktok frog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032774_bc05843b24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO1TIKTOKFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO1TIKTOKFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xba0d40e883fb96885b053b1982b53b7586fc4916bd885d99e9947f84ee842655::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 9, b"FLY", b"SuiFly", b"SuiFly (FLY) is a high-speed, efficient token on the Sui blockchain, optimized for fast transactions and minimal fees in decentralized applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1833453841775239169/F4zzuhMJ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLY>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}


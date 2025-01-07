module 0xda41e41529daac19a39d15cdece1f966443a94ef164cd594b51860f109b4960a::boli {
    struct BOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLI>(arg0, 9, b"BOLI", b"Sui Boli", b"the cuteset boli on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPLQx9rtsttdoh8TZa9BVry6VWHzjXDZXeBLrVwV18Pvc?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOLI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1b42bdc9cd9bbd1807bc06d3da2e0e0144152fd79e1b21a07a198efcae05ddd3::cuddly {
    struct CUDDLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUDDLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUDDLY>(arg0, 9, b"CUDDLY", b"CuddlyInu", b"Community Coin For Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/7tVodPY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CUDDLY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUDDLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUDDLY>>(v1);
    }

    // decompiled from Move bytecode v6
}


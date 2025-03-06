module 0xd86462d4a47e4a339154cea9ef35c689abda34c5bdfaca41e465fc5ca314a435::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"HAPPY", b"HAPPYHAPPYHAPPYHAPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/49f02dce774f97ebe5f14c0c8ae533d07db134f5969cf132d324106295c77ac3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAPPY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v2, @0xf55443938e7ecdc1181f60d605c77013d29a4fcf1362658e6fda627cd25cfc2c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


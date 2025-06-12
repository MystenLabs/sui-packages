module 0x7541b0ebfd9d56cda3894d34513ceb4ee48ebfa364799b0efcc3ba66cf1f6c84::lets {
    struct LETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LETS>(arg0, 6, b"LETS", b"letsgo", b"letsgo baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4eboreugwzz44r4vdsttfizpokykop2x6n3kyp4iaoktc6whpr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LETS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


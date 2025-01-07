module 0xa4c559a2afea9165ad43aca58c0a49109700481127376aa44ee05408f8274a81::BucketReward {
    struct BUCKETREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<BUCKETREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<BUCKETREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: BUCKETREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKETREWARD>(arg0, 9, b"$ buckfi.cc - Bucket Reward Token", b"buckfi.cc", b"You're rewarded $10,000 Bucks for empowering Bucket Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/bucket/bucket_token_icon.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKETREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKETREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


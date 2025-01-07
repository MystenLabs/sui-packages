module 0xceb64bd045e425dc0c3775bb64008c637fe2595af6bd0692183d34aa703acdef::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 6, b"BUT", b"BUCKET PROTOCOL", b"The leading decentralized stablecoin protocol on @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bucket_fd83db7b57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}


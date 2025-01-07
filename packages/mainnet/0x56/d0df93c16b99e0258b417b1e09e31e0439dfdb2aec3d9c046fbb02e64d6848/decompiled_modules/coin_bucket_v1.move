module 0x56d0df93c16b99e0258b417b1e09e31e0439dfdb2aec3d9c046fbb02e64d6848::coin_bucket_v1 {
    struct COIN_BUCKET_V1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_BUCKET_V1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_BUCKET_V1>(arg0, 9, b"fcBUCKv1", b"fatchoi Bucket v1", b"fatchoi Bucket v1 strategy token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_BUCKET_V1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_BUCKET_V1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


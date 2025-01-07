module 0x9212d07d11d5b97a8887661197cd9200e256a00e1d8126ff7f43ba36bfc39a4c::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"test102", b"test102", b"description1", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v2, 1000000000000000, arg1), @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
    }

    // decompiled from Move bytecode v6
}


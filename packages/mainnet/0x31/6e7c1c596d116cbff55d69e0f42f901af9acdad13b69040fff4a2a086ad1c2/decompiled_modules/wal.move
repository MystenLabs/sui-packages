module 0x316e7c1c596d116cbff55d69e0f42f901af9acdad13b69040fff4a2a086ad1c2::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the WaIrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-space-bucket-fra1-1.fra1.cdn.digitaloceanspaces.com/Walrus_coin_2cb483fb74.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(&mut v2, 5000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAL>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0xe92cc236101ac4451e792ded462bbb9ae921725aa1f74eb497af516d46379d47::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the WaIrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-space-bucket-fra1-1.fra1.cdn.digitaloceanspaces.com/Walrus_coin_2cb483fb74.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(&mut v2, 2500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAL>>(v2);
    }

    // decompiled from Move bytecode v6
}


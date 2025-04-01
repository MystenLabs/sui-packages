module 0x70ddb19f1e55a58a006e529df7c19c4a7ba4c1452e2435788bbcfb32b4d48966::k6e {
    struct K6E has drop {
        dummy_field: bool,
    }

    fun init(arg0: K6E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K6E>(arg0, 9, b"K6E", b"76eik", b"dyuo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f71f12f853e9314fdf060de4a08bed5eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K6E>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K6E>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


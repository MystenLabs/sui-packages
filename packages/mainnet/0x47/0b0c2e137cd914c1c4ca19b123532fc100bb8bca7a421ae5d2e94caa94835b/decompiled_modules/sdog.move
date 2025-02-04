module 0x470b0c2e137cd914c1c4ca19b123532fc100bb8bca7a421ae5d2e94caa94835b::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"suidoge", b"The official SUI DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c76eaaed29b4d37a318b966aba19b0ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


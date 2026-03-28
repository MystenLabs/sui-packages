module 0x5489130e723ae3ae9b70f728ed3327519f722cb41a8de4c1ad53acf88140b00b::foiled {
    struct FOILED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOILED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOILED>(arg0, 9, b"FOILED", b"FOILED", b"FOILED token deployed with vanity package ID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FOILED>>(0x2::coin::mint<FOILED>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOILED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOILED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


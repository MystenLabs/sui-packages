module 0x61cbf93e216fa4ff42f66e50d4d6ed10d5b5b871fa1281bb7462a3bf54a3d326::visa {
    struct VISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISA>(arg0, 9, b"VISA", b"VISA", b"TURNING WHAT'S NEXT INTO WHAT'S TRUSTED.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihtz4sk5swlyetnh7valnxcs6eqen6vvonxtcgpsmvhxfejdxvro4")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VISA>>(0x2::coin::mint<VISA>(&mut v2, 9000000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISA>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISA>>(v1);
    }

    // decompiled from Move bytecode v7
}


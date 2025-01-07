module 0x87f6cc77bd34cc94f6fd2d217e12b015bc8875c843b624eab7086deca29ce12::suiamese {
    struct SUIAMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMESE>(arg0, 6, b"SUIAMESE", b"SIAMESE CAT ON SUI", x"4d65657420746865206b696e67206361742c20546865205355492d70657273746172206f662053554920436861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0491_754be4680b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMESE>>(v1);
    }

    // decompiled from Move bytecode v6
}


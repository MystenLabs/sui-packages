module 0xa6ddbed4693e8d2caa6cc7658bf7d091370d49a496b02aed529b3f8a4a0eb177::jaspe {
    struct JASPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASPE>(arg0, 9, b"Jaspe", b"Axie Infinity Dog", b"Jasper - The Official Dog of Axie Infinity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZTdB1wVpqtsbenbAqiccQTyJacSphwA7vi3eNd6W3zb4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JASPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JASPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


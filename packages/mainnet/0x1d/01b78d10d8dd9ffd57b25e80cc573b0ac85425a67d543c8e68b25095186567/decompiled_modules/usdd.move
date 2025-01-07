module 0x1d01b78d10d8dd9ffd57b25e80cc573b0ac85425a67d543c8e68b25095186567::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 8, b"USDD", b"USDD", b"DECENTRALIZED USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/KvQmJ_D5CvI7AdsWwthGqsKgpX2SosG_pSahpzXH0xA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDD>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v2, @0x15462a7cc618bd1e747a7b14269329ce93d2d13dc209d78444e465025a3d755e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v1);
    }

    // decompiled from Move bytecode v6
}


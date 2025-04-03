module 0x97001e581c4fd7b590d886e1d7abd92671a818864050f4de6a0994f769bdfd2a::non {
    struct NON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NON>(arg0, 6, b"NON", b"NON", b"Nonnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreic6twnzazbv4epjmk2ee7jrm4cjs24it57xszrrk3rwpmagf5emeu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NON>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON>>(v2, @0xfe65cf3f401586ad76108d97b4a49fa382c3b16235f36e0fc972035b25414e9e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NON>>(v1);
    }

    // decompiled from Move bytecode v6
}


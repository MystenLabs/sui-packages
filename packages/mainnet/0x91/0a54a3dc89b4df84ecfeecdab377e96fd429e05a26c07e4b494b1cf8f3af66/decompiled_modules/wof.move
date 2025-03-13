module 0x910a54a3dc89b4df84ecfeecdab377e96fd429e05a26c07e4b494b1cf8f3af66::wof {
    struct WOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOF>(arg0, 9, b"WOF", b"DOG WOF", b"Dog Wof Autism ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPqLCPpK1rbinDTs73vuaBooKwWY6YG8vqKjTSCrSTS5L")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x81ff647e7da91e6ec9970735901a53fe1e9ca6d26b147af0082c048254071a53::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"teets", b"last one, promise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmbdeyntotrzlxnouvvm73hcn5fp2pnmfobwu4aarp4prk3ruvpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


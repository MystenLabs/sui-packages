module 0x34a39c56b5235133d89af51ee85929c8fd08ff6532a5c304787649cf42e0f99c::emog {
    struct EMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOG>(arg0, 6, b"EMOG", b"Emogla", b"EMOGs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffshbob3n3hxnxccsxfj5za4sai2ji2ftyamjy7lx57wyltbrtta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EMOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


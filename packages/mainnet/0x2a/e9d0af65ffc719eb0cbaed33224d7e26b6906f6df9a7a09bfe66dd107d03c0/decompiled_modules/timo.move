module 0x2ae9d0af65ffc719eb0cbaed33224d7e26b6906f6df9a7a09bfe66dd107d03c0::timo {
    struct TIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMO>(arg0, 9, b"TIMO", b"Timo", b"Isaac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiavesxxsvkjkxd3nb2hkdybg7iiwj4lmwddvs4ky5zy7a5l26t6zm")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


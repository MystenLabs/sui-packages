module 0xb79b68831361c91f9c853396762b9c02fdc84f43a74dd78d683f4dc1e9e97f2b::nftgated {
    struct NFTGATED has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NFTGATED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NFTGATED>>(0x2::coin::mint<NFTGATED>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: NFTGATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTGATED>(arg0, 9, b"NFTGATED", b"nftgate", b"nft gated yk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://127.0.0.1:54321/storage/v1/object/public/drop-images/7c9e59f0-5f64-4d1e-9813-2c4637e0aed1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NFTGATED>>(0x2::coin::mint<NFTGATED>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFTGATED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTGATED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


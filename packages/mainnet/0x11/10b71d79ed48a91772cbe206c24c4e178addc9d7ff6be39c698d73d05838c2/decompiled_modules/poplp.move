module 0x1110b71d79ed48a91772cbe206c24c4e178addc9d7ff6be39c698d73d05838c2::poplp {
    struct POPLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPLP>(arg0, 6, b"POPLP", b"popp", b"nomad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicaddkxdcwdu3skwj6zzsynevsgsnpkyjrmypgfkfowvk6o42uyli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPLP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


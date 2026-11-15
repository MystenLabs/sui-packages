module 0xbf06b6e6c20bc17ada81fdaa1a4e3fa7edc499f94b3da13435a0291e9184ab9e::bnp {
    struct BNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNP>(arg0, 9, b"BNP", b"BNP COIN BD", b"Bangladesh National Party (BNP) is a community-driven meme token on the Sui network, created for fun, engagement, and supporters. Join our journey to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfXgUMuJWoH3uXTLQrtLLNeQo4qN2P4aSk8pRwHANHQYT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BNP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNP>>(v1);
    }

    // decompiled from Move bytecode v6
}


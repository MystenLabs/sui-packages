module 0xfd4f486c646f36ae75a9f09af82e5e8684ce7b4bb8232b58466986f083c6b08d::hlo {
    struct HLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLO>(arg0, 6, b"HLO", b"HLO", b"hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreihjvbwvwzzqyquy5crl5kj4udf637gnwlnwh6c6voa3ks2g7jgoei")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HLO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLO>>(v2, @0x384b4f03fd3fccec0a9f0d26595e4e2b1ab289efb9213668b2f41bceb4ecd524);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLO>>(v1);
    }

    // decompiled from Move bytecode v6
}


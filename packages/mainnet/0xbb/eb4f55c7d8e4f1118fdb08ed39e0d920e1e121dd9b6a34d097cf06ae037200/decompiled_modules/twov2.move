module 0xbbeb4f55c7d8e4f1118fdb08ed39e0d920e1e121dd9b6a34d097cf06ae037200::twov2 {
    struct TWOV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWOV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWOV2>(arg0, 6, b"TwoV2", b"Mew Two v2", b"MewTwo v2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2vjqyqdfbch5wlfskoss6yil7s3c2n2mslpmftd6dxiclvi5uru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWOV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWOV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


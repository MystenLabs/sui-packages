module 0x5bf251207542eea0cfaf45a174f8e819ebc6505ec182eae58d52a50cd71ee4f4::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 9, b"BTS", b"Bitcoin Sea ", b"The sea is for everyone, his treasure and his food. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbFMuLpSxwvWFeGQ2Yq2gkQnipCJ24xT3jzHzUxgAYDtT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTS>(&mut v2, 210000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}


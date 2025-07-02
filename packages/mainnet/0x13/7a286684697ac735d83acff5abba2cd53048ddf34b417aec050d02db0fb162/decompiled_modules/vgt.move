module 0x137a286684697ac735d83acff5abba2cd53048ddf34b417aec050d02db0fb162::vgt {
    struct VGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGT>(arg0, 6, b"VGT", b"Vegeta", b"vegeta < kakarot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp26l6ozeu3hxyfneun4nxuegvt3nw3dxjwbd5zgbcdoe3d7idm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VGT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


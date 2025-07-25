module 0x2c0805ef2c8d651e3cbd0bb56536e0d006ed1b41e9c78f00c615981c843d053f::im {
    struct IM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IM>(arg0, 6, b"IM", b"ICE MONSTER", b"Ice monster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifq2sjwfvk6v57zc53xim5fm5elcwy7fycbxkdi2gephwoloiehbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


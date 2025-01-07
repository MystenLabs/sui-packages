module 0xd7f5bf9f16d307a26efe92ebb7a4c947e2d25be4736049b907c92ef4f23a02c0::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 6, b"KAMALA", b"kamala", b"This is Kamala token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRsJ9hkpuui3PBw28RXxip6Ns75NEuu2FFYVCCtLffPXa/3.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAMALA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}


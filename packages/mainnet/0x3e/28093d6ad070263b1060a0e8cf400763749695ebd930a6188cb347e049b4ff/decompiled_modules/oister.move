module 0x3e28093d6ad070263b1060a0e8cf400763749695ebd930a6188cb347e049b4ff::oister {
    struct OISTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OISTER>(arg0, 6, b"Oister", b"Oister on Sui", b"$OISTER innovative ecosystem offers a 3D NFT Metaverse,DeFi utilities a crypto education platform, NFTs,a merchandise store,and more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036138_a5732ecc1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OISTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OISTER>>(v1);
    }

    // decompiled from Move bytecode v6
}


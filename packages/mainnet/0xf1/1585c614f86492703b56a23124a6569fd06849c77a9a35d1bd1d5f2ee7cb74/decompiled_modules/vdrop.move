module 0xf11585c614f86492703b56a23124a6569fd06849c77a9a35d1bd1d5f2ee7cb74::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"VDROP ON SUI", b"VDROP /Enables users to easily craft their exclusive NFT collections and implement dynamic campaign tactics for distributing NFTs. $VDROP is live on movepump. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/venomdrop_0f6f7219f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}


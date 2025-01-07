module 0x8e71c95ab52e0904cebff0da3a46e156e7f1fccdbf4cfa916db5108af85d6ad::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"SUIDROP", b"SUIDROP enables users to easily craft their exclusive NFT collections and implement dynamic campaign tactics for distributing NFTs. $VDROP is Live on Bluemove. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/venomdrop1_71a3a3c480.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x67ea03213ffc9978fdcc64488c58e46c5d841bf8588a629b64f113bb1925ac58::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"VDROP ON SUI", b"Vdrop On Sui is NFT Airdrop Platform, enables users to easily craft their exclusive collections and implement dynamic campaign tactics for distributing NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_29_22_15_52_0777d5b420.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}


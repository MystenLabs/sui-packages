module 0x6188777e13a54b25d160794d4c3d50b91bf1c6a5a46d882ded8f74d64b3fcb0f::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 6, b"BABYPENGU", b"Baby Pengu", b"BabyPengu is here to spread good vibes on Sui.Hold $BABYPENGU tokens and qualify for a free BABYPENGU NFT airdrop! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_4a70223096.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}


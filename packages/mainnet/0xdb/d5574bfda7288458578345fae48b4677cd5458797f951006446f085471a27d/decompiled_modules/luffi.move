module 0xdbd5574bfda7288458578345fae48b4677cd5458797f951006446f085471a27d::luffi {
    struct LUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFI>(arg0, 6, b"Luffi", b"SuiOnePiece", b"This token aims to provide users with benefits like staking rewards, community-driven events, and access to exclusive content. With a focus on building a vibrant, dedicated community, SuiOnePiece blends blockchain technology with a shared vision of e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731708368088.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


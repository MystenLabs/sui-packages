module 0xcad76ecfb1c6b4f472ac64dcaa940fbbfad4acd52c0d34d393571fe923d2b0da::suifugu {
    struct SUIFUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUGU>(arg0, 6, b"SUIFUGU", b"Sui Fugu", b"The more you HODL, the puffier your portfolio gets. And rumor has it, when the tide's just right, Fugu airdrops a blow-out surprise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nhbds0_W_400x400_2c61744830.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}


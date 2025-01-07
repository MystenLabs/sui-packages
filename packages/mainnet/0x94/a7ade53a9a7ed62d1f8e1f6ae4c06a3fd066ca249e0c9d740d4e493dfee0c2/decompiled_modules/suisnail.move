module 0x94a7ade53a9a7ed62d1f8e1f6ae4c06a3fd066ca249e0c9d740d4e493dfee0c2::suisnail {
    struct SUISNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISNAIL>(arg0, 6, b"SUISNAIL", b"Smoking Sui Snail", b"The quest to get higher and higher has begun. First realest snail on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rk_U9n_M_X_400x400_886fde8a9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}


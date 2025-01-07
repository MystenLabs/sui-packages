module 0x5f5ad6af41af19490897be3ec0864a04db0a2134e6fba5531f360326904a13f3::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"SNEK SUI", b"Looks like your having trading problemsss, let me take a looksss. Meet $snek will help out with the marketssss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_53_51_814d70492c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}


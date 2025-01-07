module 0xe7d2c1c7931b39b6d18583da5ecf4a867411ddb48e8b39e2295b4271d919b61d::artisticcat {
    struct ARTISTICCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTISTICCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTISTICCAT>(arg0, 6, b"ArtisticCat", b"Artistic Cat", b"A little cat playing guitar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SZO_0s_Y_Tb_400x400_e32d4f0688.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTISTICCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTISTICCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


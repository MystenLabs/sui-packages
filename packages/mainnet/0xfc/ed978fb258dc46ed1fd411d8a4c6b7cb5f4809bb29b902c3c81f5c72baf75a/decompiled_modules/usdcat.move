module 0xfced978fb258dc46ed1fd411d8a4c6b7cb5f4809bb29b902c3c81f5c72baf75a::usdcat {
    struct USDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCAT>(arg0, 6, b"USDCAT", b"Upside Down Cat", b"The stable meme on the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Hbb_E_Yr_Y_400x400_2fa3ce322f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


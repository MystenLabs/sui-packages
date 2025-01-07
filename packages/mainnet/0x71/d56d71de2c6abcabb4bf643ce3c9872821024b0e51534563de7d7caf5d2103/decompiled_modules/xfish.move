module 0x71d56d71de2c6abcabb4bf643ce3c9872821024b0e51534563de7d7caf5d2103::xfish {
    struct XFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XFISH>(arg0, 6, b"XFISH", b"XFish Sui", b"\"XFISH The Crypto Dish You Dont Want to Miss!\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_12_20_at_4_58_59_PM_5de836cd4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf01e3fa49f73db478d4cc6ba1d36a63e7b3c1c9bb561bc18c1f331ec5b4c6adb::sharkpepe {
    struct SHARKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKPEPE>(arg0, 6, b"SHARKPEPE", b"Shark Pepe", b"dun dun.. dun dun... dun dun dun dun dun dun doooweee woo . doooweee woo. Dex paid. Socials to be posted below.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_7_Hk8p_WIA_Ag_Wdk_2fad046b56.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


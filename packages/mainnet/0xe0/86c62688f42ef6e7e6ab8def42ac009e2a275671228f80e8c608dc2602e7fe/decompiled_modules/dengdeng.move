module 0xe086c62688f42ef6e7e6ab8def42ac009e2a275671228f80e8c608dc2602e7fe::dengdeng {
    struct DENGDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGDENG>(arg0, 6, b"DENGDENG", b"Deng Deng", b"Deng Deng is a spicy and flavorful meme coin inspired by the iconic Moo Deng  Deng Deng aims to spice up your crypto portfolio with a delicious blend of fun, community spirit, and moon-worthy potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_removebg_preview_36439d0f68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}


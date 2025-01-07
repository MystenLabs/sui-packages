module 0x7e017cdb5442e1a5165cecd8b4b2c13ed90d5d92859c924cddb493415b4e20cb::neirosui {
    struct NEIROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROSUI>(arg0, 6, b"Neirosui", b"Neiro sui", b"Neiro sui is a meme coin that follow the momentum of Neiro ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kitty_cat_kitten_pet_45201_06b23924e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


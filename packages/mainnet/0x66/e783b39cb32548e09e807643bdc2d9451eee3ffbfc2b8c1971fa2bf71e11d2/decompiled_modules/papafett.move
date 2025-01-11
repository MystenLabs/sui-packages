module 0x66e783b39cb32548e09e807643bdc2d9451eee3ffbfc2b8c1971fa2bf71e11d2::papafett {
    struct PAPAFETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPAFETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPAFETT>(arg0, 6, b"Papafett", b"Pope Fetterman", b"Send his Holey Pantsness your blessings for his ascension to the throne as The Pope of Greenland!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736558366429.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPAFETT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPAFETT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


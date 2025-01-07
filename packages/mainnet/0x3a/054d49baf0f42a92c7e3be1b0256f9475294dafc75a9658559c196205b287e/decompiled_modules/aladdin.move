module 0x3a054d49baf0f42a92c7e3be1b0256f9475294dafc75a9658559c196205b287e::aladdin {
    struct ALADDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALADDIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALADDIN>(arg0, 9, b"ALADDIN", b"The Tale of Aladdin", b"Aladdin is a Middle Eastern folktale. It is one of the best-known tales associated with the medieval collection One Thousand and One Nights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JYWYo6Q.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ALADDIN>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALADDIN>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALADDIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


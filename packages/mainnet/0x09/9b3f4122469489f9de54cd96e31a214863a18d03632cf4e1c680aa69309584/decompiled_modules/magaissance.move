module 0x99b3f4122469489f9de54cd96e31a214863a18d03632cf4e1c680aa69309584::magaissance {
    struct MAGAISSANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAISSANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAISSANCE>(arg0, 6, b"MAGAissance", b"The MAGAissance", b"A blend of MAGA and Renaissance, hinting at a revival period in line with Trumps slogan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6158846063398732971_y_b90496b7b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAISSANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAISSANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}


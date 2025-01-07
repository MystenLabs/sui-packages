module 0x95ed8064be929c2c7744620d536b2b666827880b38fcd42c401be6b6f7b76242::suy {
    struct SUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUY>(arg0, 6, b"SUY", b"Suy The Sui", b"SUY ZE FUTURE OF SUI MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_SUY_64da0acdb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


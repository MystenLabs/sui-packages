module 0x208e37fb0ccd9a5b0a11ebd0559a73d10b055e7e88ec01e49f451456573bd767::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"Slerf", b"SlerfSui", b"Slerf sui network again start", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5515_6186fcb626.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}


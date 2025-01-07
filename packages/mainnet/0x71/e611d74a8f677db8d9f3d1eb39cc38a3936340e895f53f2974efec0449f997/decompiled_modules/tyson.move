module 0x71e611d74a8f677db8d9f3d1eb39cc38a3936340e895f53f2974efec0449f997::tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 6, b"Tyson", b"Mike Tyson", b"Everyone has a plan 'till they get punched in the mouth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Getty_Images_1762174831_d180d9e185.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}


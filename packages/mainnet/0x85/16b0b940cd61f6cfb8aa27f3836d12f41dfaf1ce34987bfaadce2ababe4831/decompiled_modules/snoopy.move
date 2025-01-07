module 0x8516b0b940cd61f6cfb8aa27f3836d12f41dfaf1ce34987bfaadce2ababe4831::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 6, b"SNOOPY", b"Snoopy", b"Snoopy Goofy is the hotteat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004310_53fe5f3e87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


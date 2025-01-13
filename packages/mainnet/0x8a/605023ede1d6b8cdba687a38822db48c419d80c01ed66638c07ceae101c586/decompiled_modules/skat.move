module 0x8a605023ede1d6b8cdba687a38822db48c419d80c01ed66638c07ceae101c586::skat {
    struct SKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKAT>(arg0, 6, b"SKAT", b"SKATING CAT", b"SKAT IS SKATING TO THE MOON, KEEP SHREDING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ab9decfc_184e_4f9d_bbb3_9a3132c8ed81_79c31ac0b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


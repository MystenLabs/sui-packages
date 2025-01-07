module 0x983e7873cee4b031dd4a9f7b280c17bb3cecb3db405831d0fb1ab96ec973cfe5::okayeg {
    struct OKAYEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAYEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAYEG>(arg0, 6, b"OKAYEG", b"OKAYEG SUI", b"respekte teh eg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r9_Pon_Enr_400x400_1ede0a7983.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAYEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAYEG>>(v1);
    }

    // decompiled from Move bytecode v6
}


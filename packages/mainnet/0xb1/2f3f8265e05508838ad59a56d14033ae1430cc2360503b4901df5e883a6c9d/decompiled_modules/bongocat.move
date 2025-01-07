module 0xb12f3f8265e05508838ad59a56d14033ae1430cc2360503b4901df5e883a6c9d::bongocat {
    struct BONGOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGOCAT>(arg0, 6, b"BONGOCAT", b"BONGO CAT ON SUI", b"Hit the SUI likeBongo Cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_20_06_19_98bc08510b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


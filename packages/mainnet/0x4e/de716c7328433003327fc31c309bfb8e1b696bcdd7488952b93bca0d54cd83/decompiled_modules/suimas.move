module 0x4ede716c7328433003327fc31c309bfb8e1b696bcdd7488952b93bca0d54cd83::suimas {
    struct SUIMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAS>(arg0, 6, b"SUIMAS", b"Sui Christmas", x"4861707079204368726973746d617320416c6c0a4d65727279204368726973746d617320746f205375694e6574776f726b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055013_b121630c59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


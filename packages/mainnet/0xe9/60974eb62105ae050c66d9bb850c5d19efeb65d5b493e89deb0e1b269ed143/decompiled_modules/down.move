module 0xe960974eb62105ae050c66d9bb850c5d19efeb65d5b493e89deb0e1b269ed143::down {
    struct DOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWN>(arg0, 6, b"DOWN", b"pOsEiDoWn", b"iMmA tHe KiNg Of ThE sEa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b22d58ea9b284515874fcbd3a91c8b31_24a77e0aae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}


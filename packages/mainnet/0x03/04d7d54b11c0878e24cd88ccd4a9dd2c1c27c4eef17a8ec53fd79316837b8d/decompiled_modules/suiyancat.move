module 0x304d7d54b11c0878e24cd88ccd4a9dd2c1c27c4eef17a8ec53fd79316837b8d::suiyancat {
    struct SUIYANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANCAT>(arg0, 6, b"SuiyanCat", b"Suiyan Cat on SUI", b"the most annoying cat on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiyan_b86c082dda_275f427052.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


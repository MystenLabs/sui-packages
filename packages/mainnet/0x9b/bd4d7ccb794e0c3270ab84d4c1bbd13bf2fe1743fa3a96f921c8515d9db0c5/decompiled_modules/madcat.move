module 0x9bbd4d7ccb794e0c3270ab84d4c1bbd13bf2fe1743fa3a96f921c8515d9db0c5::madcat {
    struct MADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADCAT>(arg0, 6, b"MADCAT", b"Mad Cat", b"Cat is mad. Fuck rugs! No dev (2%). Pure community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1299_7db60d0a90.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


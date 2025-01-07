module 0x236be5b1e9384ac876d6348b9ee88e17c86c7b65f22c22977b67d02e14ef9524::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 6, b"JOYCAT", b"JOYCAT ON SUI", b"Your own Mascot on SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_joycat_65279f90d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


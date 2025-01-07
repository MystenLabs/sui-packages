module 0x635a31e6c5a481bf619f27056925c40a8b067c1d988cb9c5783267baf2ab7c82::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"capybara", b"Just a Capybara chillin' on SUI. No Drama, Just Vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capy_logo_200_fd0d759beb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


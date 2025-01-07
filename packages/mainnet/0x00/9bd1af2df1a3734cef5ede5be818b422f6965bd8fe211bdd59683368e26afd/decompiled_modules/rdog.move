module 0x9bd1af2df1a3734cef5ede5be818b422f6965bd8fe211bdd59683368e26afd::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"RDOG", b"Repost Dog on SUI", b"Lets flip RDOG on Sol ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RDOG_fffaed6784.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


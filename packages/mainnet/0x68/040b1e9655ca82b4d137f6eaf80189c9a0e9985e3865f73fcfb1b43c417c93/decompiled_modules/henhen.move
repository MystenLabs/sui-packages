module 0x68040b1e9655ca82b4d137f6eaf80189c9a0e9985e3865f73fcfb1b43c417c93::henhen {
    struct HENHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENHEN>(arg0, 6, b"HenHen", b"Hen", b"meme of lady", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0968_1f907a16ff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENHEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENHEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


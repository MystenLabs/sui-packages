module 0x1b9b0382e0a728763a6d45721f3eff1d74fc40ad98cd4de584ef9428916c9d89::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"CAPY SUI", b"CAPY SUI AND FRENS IS THE NEW MEME ON SUI. CHECK IT OUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x57184d3106ea793e09506453ef61559fa74f34ea8d1b9db4d3b47c980a053f94_capys_capys_6003e61b8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


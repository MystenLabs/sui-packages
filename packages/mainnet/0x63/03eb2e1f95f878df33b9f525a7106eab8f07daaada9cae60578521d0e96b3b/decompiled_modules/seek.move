module 0x6303eb2e1f95f878df33b9f525a7106eab8f07daaada9cae60578521d0e96b3b::seek {
    struct SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEK>(arg0, 6, b"SEEK", b"Seek the Cow", b"$SEEK is a cow and is part of Matt Furie's Boy's Club. Join Seek on Telegram!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_N_1_cb94150d92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}


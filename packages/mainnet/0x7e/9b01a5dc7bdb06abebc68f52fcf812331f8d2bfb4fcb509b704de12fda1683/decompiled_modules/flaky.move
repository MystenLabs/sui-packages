module 0x7e9b01a5dc7bdb06abebc68f52fcf812331f8d2bfb4fcb509b704de12fda1683::flaky {
    struct FLAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAKY>(arg0, 6, b"FLAKY", b"Flaky the Sui Feline", b"Flaky the Sui Feline is a curious and humorous cat living in a colorful, magical world of Sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4d_Bkey6_Q6u_Zv883c4_Jrfphiebincxb2_Z_Nn_Hr5_W_Ain_F_Nt_a36f372c42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}


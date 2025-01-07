module 0x36ead7378018aa01aed4d148235e0996b521e89ffcd2d0a11d9cc8b0a18fd87a::bragon {
    struct BRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAGON>(arg0, 6, b"BRAGON", b"BITCOIN DRAGON ON SUI", b"BITCOIN DRAGON ON SUIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zjh_gxa_AA_Ae_J0w_2ade7c239c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x44f9353ad1d352feecca159b94fb70cf965a4e0c934574c784da0c5a70b08c60::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"SUI-Perman", b"Get super returns with SUI-Perman hero of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b5713a22_70be_4bd0_be28_7026de7d5f6b_e4b51ac1ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x69b7daa6d42c38bf41f9b63d61a981ef139e1db4e83032abd9a7f02c57457579::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"SUIEET", b"Suieet", b"The Sweetest  Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_C6n_L3m_400x400_c705d970ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEET>>(v1);
    }

    // decompiled from Move bytecode v6
}


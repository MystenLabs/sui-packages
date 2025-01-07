module 0x7f28f643bbfa8dc2fabfe61b80824e5780c79da1a228c880e6da4b54b8557a7a::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 6, b"POLA", b"POLA SUI", x"49276d2074686520636f6c646573742c206368696c6c6573742c20616e642066756e6e69657374206265617220696e2074686520417263746963210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Ox_Lm_Bh_A_400x400_b7ed256507.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


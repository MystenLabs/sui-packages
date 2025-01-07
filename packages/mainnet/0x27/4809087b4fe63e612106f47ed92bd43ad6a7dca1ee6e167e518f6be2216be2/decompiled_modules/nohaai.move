module 0x274809087b4fe63e612106f47ed92bd43ad6a7dca1ee6e167e518f6be2216be2::nohaai {
    struct NOHAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOHAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOHAAI>(arg0, 6, b"NOHAAI", b"Noah Quant AI", b"with our NOHA AI newest mechanism that lets you increase your income using machine learning and deep learning algorithms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/444555_c2f64fcccc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOHAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOHAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


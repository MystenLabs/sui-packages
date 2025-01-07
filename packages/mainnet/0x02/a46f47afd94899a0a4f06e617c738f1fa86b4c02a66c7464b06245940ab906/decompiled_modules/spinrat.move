module 0x2a46f47afd94899a0a4f06e617c738f1fa86b4c02a66c7464b06245940ab906::spinrat {
    struct SPINRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINRAT>(arg0, 6, b"SPINRAT", b"Spinning Rat", b"The spinning rat, featured on POPCAT, is the real reason behind its popularitywithout it, POPCAT wouldnt be popping.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2104_c20a5cf84e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPINRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


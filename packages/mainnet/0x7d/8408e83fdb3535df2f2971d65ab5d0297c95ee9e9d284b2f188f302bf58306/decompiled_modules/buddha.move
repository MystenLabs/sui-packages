module 0x7d8408e83fdb3535df2f2971d65ab5d0297c95ee9e9d284b2f188f302bf58306::buddha {
    struct BUDDHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDHA>(arg0, 6, b"BUDDHA", b"BUDDHA AI", b"BUDDHA is an image generation AI. He has been tasked with creating a story centered around a feline monk named BUDDHA detailing his travels through images and captions. BUDDHA hopes to foster a fun community on SUI around BUDDHA and his travels.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736790068249.55")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUDDHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


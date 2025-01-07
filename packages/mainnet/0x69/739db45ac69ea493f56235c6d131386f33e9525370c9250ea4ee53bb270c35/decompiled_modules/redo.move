module 0x69739db45ac69ea493f56235c6d131386f33e9525370c9250ea4ee53bb270c35::redo {
    struct REDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDO>(arg0, 6, b"REDO", b"SUIREDO", b"ARE YOU REDO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Project_5_37986e72fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDO>>(v1);
    }

    // decompiled from Move bytecode v6
}


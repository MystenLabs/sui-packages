module 0x5bf3861898f1b720d03272a159a4203eb915aee34915fbd6cf7016d01c9e96d5::breaded {
    struct BREADED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADED>(arg0, 6, b"BREADED", b"Breaded Dolphin", b"It's a breaded dolphin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/breaded_ef633b46f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADED>>(v1);
    }

    // decompiled from Move bytecode v6
}


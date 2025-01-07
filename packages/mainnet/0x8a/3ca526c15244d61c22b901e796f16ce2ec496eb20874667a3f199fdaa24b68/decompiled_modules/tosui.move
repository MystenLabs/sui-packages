module 0x8a3ca526c15244d61c22b901e796f16ce2ec496eb20874667a3f199fdaa24b68::tosui {
    struct TOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSUI>(arg0, 6, b"TOSUI", b"Tosui", b"TOSUI is the coolest cat of Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_4aafcbb7a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


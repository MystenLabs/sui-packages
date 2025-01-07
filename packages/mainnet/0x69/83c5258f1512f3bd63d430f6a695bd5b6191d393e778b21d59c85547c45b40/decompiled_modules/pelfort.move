module 0x6983c5258f1512f3bd63d430f6a695bd5b6191d393e778b21d59c85547c45b40::pelfort {
    struct PELFORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELFORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELFORT>(arg0, 6, b"PELFORT", b"The Wolf of Sui", b"First The Wolf of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_87783348f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELFORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELFORT>>(v1);
    }

    // decompiled from Move bytecode v6
}


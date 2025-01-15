module 0x8a6300c97449d26a2b12297790b5b32713ef9a0c069fb86c9cdbf9d878211075::supea {
    struct SUPEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPEA>(arg0, 6, b"SUPEA", b"Supea", b"MAKE SUI TOKENS GREAT AGAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_16_54_24_ffb8a505cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPEA>>(v1);
    }

    // decompiled from Move bytecode v6
}


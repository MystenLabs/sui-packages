module 0x3c7e3f90ed3fff2cdb3ff732b5bd7dd4bb5d5c5633fb304c59df33c3cb8168eb::rasta {
    struct RASTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASTA>(arg0, 6, b"Rasta", b"Rasta Mon", b"The iriemon Rasta is here. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730573608542.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RASTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


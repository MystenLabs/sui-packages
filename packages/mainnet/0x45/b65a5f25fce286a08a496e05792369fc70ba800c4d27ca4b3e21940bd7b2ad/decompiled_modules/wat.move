module 0x45b65a5f25fce286a08a496e05792369fc70ba800c4d27ca4b3e21940bd7b2ad::wat {
    struct WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAT>(arg0, 6, b"WAT", b"FIRST WAT ON SUI", b"Wat - Matt Furie's pet rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_25_c27fb4fe51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


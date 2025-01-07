module 0xafa8d2b0c517a33b93994473baf0b5854b0208b4d5e3c450915cfb5b323e03cb::suidwog {
    struct SUIDWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDWOG>(arg0, 6, b"SUIDWOG", b"DWOG", x"46495253542064776f67206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3526_e8b55c6182.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


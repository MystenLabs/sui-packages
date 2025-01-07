module 0x27cfdfad9cece33082af36c8ce0dbeaa3b4bc0b70e6ef3103f2c830ee42dbcf::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"Suilion", b"A colony of suilions is now on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilion_d3a2423365_61e2e53d18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x254d200aac978a274ffa6e48b4a40ab51111e8931f3705867795d4bbe80ae64a::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 6, b"KONG", b"SUI KONG", b"After exploring jungle, Kong is ready to sail to explore the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_n_K6i_AXIAAA_70m_58babeedb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONG>>(v1);
    }

    // decompiled from Move bytecode v6
}


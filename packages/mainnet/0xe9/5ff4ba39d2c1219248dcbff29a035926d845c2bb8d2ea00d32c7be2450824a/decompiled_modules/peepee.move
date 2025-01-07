module 0xe95ff4ba39d2c1219248dcbff29a035926d845c2bb8d2ea00d32c7be2450824a::peepee {
    struct PEEPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPEE>(arg0, 6, b"PEEPEE", b"Peepee", x"247065657065650a4d414b45204d454d45434f494e5320475245415420414741494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_21_at_11_11_42a_am_5cb9690ee9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb2755dddaff42995acc51a81178a0b27f1e12e633d3526ebcd8ee019f68b0602::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 6, b"PIGU", b"PIGU ON SUI", b"Navigating PIGU's world on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pigu_a9feaa79d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd8af9ae5f23d95b149676c956721aba79c2fd27b87e62e95fcbed7a987f32ae2::reyo {
    struct REYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REYO>(arg0, 6, b"REYO", b"Resistance Yoda", b"Welcome to MITTENS Telegrams Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IAGTBF_Gd_400x400_5793adac02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REYO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xee900230e98f0f3e86798e776526ebe3e7a6b700dda7922048baf1b8aab36dde::flight5 {
    struct FLIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT5>(arg0, 6, b"Flight5", b"Flight 5", b" Flight5 flies into space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KX_4d2j_XG_400x400_9167627276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}


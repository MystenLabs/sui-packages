module 0x9822f3c1e577d7af41ff4dcf39ba1db447133f7013e8fcf877101b4abcd82618::sln {
    struct SLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLN>(arg0, 6, b"SLN", b"Suilion", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUILION_bb5ba31c3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLN>>(v1);
    }

    // decompiled from Move bytecode v6
}


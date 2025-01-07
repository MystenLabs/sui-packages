module 0x7df8ef0e0b80b850ffd0bfdec1b215d2a48419f9dee2e4bc3d717e7e5af7d21c::sber {
    struct SBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBER>(arg0, 6, b"SBER", b"SUICTOBER", b"you knoz the ioncojbnovbzbfoboubobojlf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suictober_7ea0e9b70e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBER>>(v1);
    }

    // decompiled from Move bytecode v6
}


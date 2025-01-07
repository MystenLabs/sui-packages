module 0xb9c3f1fc6a3cbf89c3a38fc2d136e463520e48ad209ca74b3e11a2d1543fb59f::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"BRAIN OF SUI", b"The token for the thinkers and innovators on Sui! Representing the intelligence and insight of each holder, $BRAIN is here to power smart moves and sharp strategies in crypto. Remember: Dont overthink it, just buy it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaa_37419174e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


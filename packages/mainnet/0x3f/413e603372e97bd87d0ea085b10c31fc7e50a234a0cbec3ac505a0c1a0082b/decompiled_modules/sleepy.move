module 0x3f413e603372e97bd87d0ea085b10c31fc7e50a234a0cbec3ac505a0c1a0082b::sleepy {
    struct SLEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEPY>(arg0, 6, b"SLEEPY", b"Sleepy Kitty", b"The sleepy cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018240_45a659ac15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


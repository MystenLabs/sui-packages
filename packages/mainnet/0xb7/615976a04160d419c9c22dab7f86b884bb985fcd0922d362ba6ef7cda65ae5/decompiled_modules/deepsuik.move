module 0xb7615976a04160d419c9c22dab7f86b884bb985fcd0922d362ba6ef7cda65ae5::deepsuik {
    struct DEEPSUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSUIK>(arg0, 6, b"DEEPSUIK", b"DeepSUIseek", b"No socials. MADE IN CHINA. I'm here to dethrone the American AI. 100M is the goal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055013_ecd79cd467.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSUIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPSUIK>>(v1);
    }

    // decompiled from Move bytecode v6
}


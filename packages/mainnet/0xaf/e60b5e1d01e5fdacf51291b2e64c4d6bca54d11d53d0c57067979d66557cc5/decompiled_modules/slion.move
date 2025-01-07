module 0xafe60b5e1d01e5fdacf51291b2e64c4d6bca54d11d53d0c57067979d66557cc5::slion {
    struct SLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLION>(arg0, 6, b"SLION", b"SUILION", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x56d0ea7fd120f8c18eff0fd92d81c4f86cbe976dbcb1c04a7e8f325a7604ba07_slion_slion_e76423b95a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLION>>(v1);
    }

    // decompiled from Move bytecode v6
}


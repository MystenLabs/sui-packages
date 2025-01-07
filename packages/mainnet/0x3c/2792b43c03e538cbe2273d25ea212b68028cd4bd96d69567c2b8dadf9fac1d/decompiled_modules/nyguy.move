module 0x3c2792b43c03e538cbe2273d25ea212b68028cd4bd96d69567c2b8dadf9fac1d::nyguy {
    struct NYGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYGUY>(arg0, 6, b"NYGUY", b"NEWYEARGUY", b"Wishing a happy new year for everyone! Join tg and lets vibe into the new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eng412w_A_400x400_e014bff2e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7915c8764e121c61142a5eb599747ea09cc9f8a418d79ce668e79d8093d1f54e::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"MICHI", b"MICHI SUI", b"I'm your MICHI, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TY_1m_H4_400x400_059a6ce580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


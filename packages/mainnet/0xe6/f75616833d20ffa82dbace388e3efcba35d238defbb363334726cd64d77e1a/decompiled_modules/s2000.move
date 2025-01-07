module 0xe6f75616833d20ffa82dbace388e3efcba35d238defbb363334726cd64d77e1a::s2000 {
    struct S2000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S2000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S2000>(arg0, 6, b"S2000", b"spc 1000", b"son. by", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_1c7c81ff3b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S2000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S2000>>(v1);
    }

    // decompiled from Move bytecode v6
}


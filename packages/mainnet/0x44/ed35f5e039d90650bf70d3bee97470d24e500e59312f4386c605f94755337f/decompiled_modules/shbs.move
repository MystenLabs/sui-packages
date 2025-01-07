module 0x44ed35f5e039d90650bf70d3bee97470d24e500e59312f4386c605f94755337f::shbs {
    struct SHBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHBS>(arg0, 6, b"SHBS", b"Shiba Inu on SUI", b"Thanks to the SUI blockchain, we now have the fastest, safest, and most efficient Shiba Inu token possible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fc0lrj_Cs_400x400_86edb22ca9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHBS>>(v1);
    }

    // decompiled from Move bytecode v6
}


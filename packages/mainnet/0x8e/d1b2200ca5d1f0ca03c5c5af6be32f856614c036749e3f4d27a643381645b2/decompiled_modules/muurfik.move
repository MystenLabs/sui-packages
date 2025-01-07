module 0x8ed1b2200ca5d1f0ca03c5c5af6be32f856614c036749e3f4d27a643381645b2::muurfik {
    struct MUURFIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUURFIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUURFIK>(arg0, 6, b"MUURFIK", b"MUURFIK ON SUI", b"MUURFIK IS THE FEARLESS SUI'S PET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8m_DG_Dwl_V_400x400_bb1a004e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUURFIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUURFIK>>(v1);
    }

    // decompiled from Move bytecode v6
}


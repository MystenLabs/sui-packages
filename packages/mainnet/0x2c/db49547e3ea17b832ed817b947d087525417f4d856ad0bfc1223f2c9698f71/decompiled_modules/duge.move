module 0x2cdb49547e3ea17b832ed817b947d087525417f4d856ad0bfc1223f2c9698f71::duge {
    struct DUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUGE>(arg0, 6, b"DUGE", b"DUGE SUI", b"DOPEST DUGE EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_WJ_Omar_P_400x400_3a81896f34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


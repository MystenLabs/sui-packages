module 0x485052afdb4e938fafac0c981173f358474095f79582528aa92c7d3badf11ab5::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shibasso on SUI", b"Enter the Shibasso doghouse!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fo_QH_Bo_CG_400x400_7d977e6789.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}


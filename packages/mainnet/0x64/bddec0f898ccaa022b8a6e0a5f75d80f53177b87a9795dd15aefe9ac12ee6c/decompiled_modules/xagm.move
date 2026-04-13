module 0x64bddec0f898ccaa022b8a6e0a5f75d80f53177b87a9795dd15aefe9ac12ee6c::xagm {
    struct XAGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAGM, arg1: &mut 0x2::tx_context::TxContext) {
        0x4fffa6fa7410f28aee62153a61f18c53e478365604f9ee4f70c558a742eabf2f::mtoken::create_coin<XAGM>(arg0, 9, b"XAGM", b"Matrixdock Silver", b"Matrixdock Silver (XAGm) is a standardized token on blockchains, where 1 token initially represents one fine troy ounce of 99.9% purity LBMA-accredited Good Delivery silver. This representation will decrease slightly over time as custody fees accrue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xagm/xagm-100x100-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v7
}


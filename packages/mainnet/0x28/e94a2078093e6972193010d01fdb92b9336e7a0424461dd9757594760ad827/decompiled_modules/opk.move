module 0x28e94a2078093e6972193010d01fdb92b9336e7a0424461dd9757594760ad827::opk {
    struct OPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPK>(arg0, 6, b"OPK", b"Obi PNut Kenobi", x"e2809c496620796f7520737472696b65206d6520646f776e2c20492077696c6c206265636f6d65206d6f726520706f77657266756c207468616e20796f7520636f756c6420706f737369626c7920696d6167696e65e2809d204f626920504e7574204b656e6f6269", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731557205233.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


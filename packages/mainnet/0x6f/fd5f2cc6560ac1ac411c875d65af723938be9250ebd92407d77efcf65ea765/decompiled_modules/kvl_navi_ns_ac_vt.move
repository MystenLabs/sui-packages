module 0x6ffd5f2cc6560ac1ac411c875d65af723938be9250ebd92407d77efcf65ea765::kvl_navi_ns_ac_vt {
    struct KVL_NAVI_NS_AC_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KVL_NAVI_NS_AC_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KVL_NAVI_NS_AC_VT>(arg0, 6, b"KVL_NAVI_NS_AC_VT", b"KVL_NAVI_NS_AC_VT", b"Vault token representing 1 unit of ownership in Kriya's Auto-Compounding Strategy on top of Navi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/kvl_navi_ns_ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KVL_NAVI_NS_AC_VT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KVL_NAVI_NS_AC_VT>>(v1);
    }

    // decompiled from Move bytecode v6
}


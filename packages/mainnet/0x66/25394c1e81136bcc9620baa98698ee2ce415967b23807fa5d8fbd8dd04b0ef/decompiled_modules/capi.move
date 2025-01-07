module 0x6625394c1e81136bcc9620baa98698ee2ce415967b23807fa5d8fbd8dd04b0ef::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 6, b"CAPI", b"CAPIBARNIA", x"49276d20746865207065616b206f662065766f6c7574696f6e20796f7520617265206a757374206120434150494241524e49410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAP_TJ_Wt_BN_u_P_Ijoy_MN_9_VM_9_518bd178c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}


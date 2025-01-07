module 0x32f6e36d28f2a00f0765dcaf3a963ed04fde382d527a26b81e98deb421bcc5b9::dufi {
    struct DUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUFI>(arg0, 6, b"DUFI", b"Duckie Fishie on Sui", b"We are best friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_1g1cl_WM_Ac8_Z_Ct_7a1ab44e59.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}


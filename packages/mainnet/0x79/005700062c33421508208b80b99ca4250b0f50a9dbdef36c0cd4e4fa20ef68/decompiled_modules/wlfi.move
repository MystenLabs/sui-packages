module 0x79005700062c33421508208b80b99ca4250b0f50a9dbdef36c0cd4e4fa20ef68::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty financial", x"53686170652061204e657720457261206f662046696e616e63650a42652044654669616e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WLFI_fbf76d5a45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}


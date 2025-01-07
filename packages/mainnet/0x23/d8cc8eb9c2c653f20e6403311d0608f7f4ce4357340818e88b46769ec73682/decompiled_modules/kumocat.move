module 0x23d8cc8eb9c2c653f20e6403311d0608f7f4ce4357340818e88b46769ec73682::kumocat {
    struct KUMOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMOCAT>(arg0, 6, b"KUMOCAT", b"KumoTheCat", x"4120636c756d7379206361742068617320656e74657265642074686520636861740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_6nm_Cq_XYAAZ_Qjr_0975b1e188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


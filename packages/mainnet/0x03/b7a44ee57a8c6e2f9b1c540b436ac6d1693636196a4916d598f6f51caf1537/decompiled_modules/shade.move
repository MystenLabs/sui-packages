module 0x3b7a44ee57a8c6e2f9b1c540b436ac6d1693636196a4916d598f6f51caf1537::shade {
    struct SHADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADE>(arg0, 6, b"Shade", b"Sui Shade", b"Do you also want to be Shade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xs_VM_0ak_A_Qa_Xv9_0504c39f12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHADE>>(v1);
    }

    // decompiled from Move bytecode v6
}


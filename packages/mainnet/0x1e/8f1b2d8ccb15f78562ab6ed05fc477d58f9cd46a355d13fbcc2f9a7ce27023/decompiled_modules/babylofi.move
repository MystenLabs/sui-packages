module 0x1e8f1b2d8ccb15f78562ab6ed05fc477d58f9cd46a355d13fbcc2f9a7ce27023::babylofi {
    struct BABYLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLOFI>(arg0, 6, b"BabyLofi", b"BabyLOFI", x"4d79206e616d652069732042414259204c4f46490a4c6f6669206973206d79206461642c207765207761732066726f7a656e20666f722063656e7475726965732c20627574207765277665206177616b656e656420616e642069276d20726561647920746f206275696c642061206272696768746572206675747572652e0a4a6f696e206d6520616e64206d7920594554492046414d2e20546f6765746865722c2077656c6c207368617065207468652066757475726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YETI_MODIF_1_c1eb3b470e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYLOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}


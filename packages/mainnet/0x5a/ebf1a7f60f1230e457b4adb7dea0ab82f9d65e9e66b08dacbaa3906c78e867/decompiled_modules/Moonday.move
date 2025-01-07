module 0x5aebf1a7f60f1230e457b4adb7dea0ab82f9d65e9e66b08dacbaa3906c78e867::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/45cdea8d-36f7-4680-960a-a5fe60c25bcd/aicoin.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/45cdea8d-36f7-4680-960a-a5fe60c25bcd/aicoin.webp"))
        };
        let v1 = b"aGOTT";
        let v2 = b"bLie Terminal";
        let v3 = b"cThe terminal of lies - AI powered";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}


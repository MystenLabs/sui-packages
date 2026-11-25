module 0x75e8f3ffddf3278ee99936524264f227882ac5e1b06d38d4a31ec5c3a2bf1f10::gtfreccesx {
    struct GTFRECCESX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFRECCESX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFRECCESX>(arg0, 9, 0x1::string::utf8(b"GTFRECCESX"), 0x1::string::utf8(x"e999bde8bc9d456c65616e6f7220535549"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Dk1f7Ye0jPxOWv9-POAWB9CtqTfjsB-qRv0T11k0ZRMD9CuBLCBNktwrlRsuCbeinnnUFXrrFmsIB1pmO47XvONQzj1EZzM5o-IekEFaUz5dXoaIDZ9daeQoI1phxWw0mE8OtCMvKW90uBsyN5nYPQLwZo0cdcS90HnF0IkX_Ry9LUsMeHgH0tVFv_HpJpqyKcnCJ2BA-vkgXWio9_NZ_R765MVKenkTeXZoMxHgIfXiM3-FXQ_DbcgXkDByrNiqZi1chXufj5C-TR7jC6PlxT8p5061VvRMCvjdY_93FN4rSYxDJQy3hflt7nVh27c42OxUgfLQtX-lCf5F_VgLDQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFRECCESX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFRECCESX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


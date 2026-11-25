module 0x620b504247b0977208e6ea292281f420faec5268429fa9c931cf1932ad9f15c0::gtmedikade {
    struct GTMEDIKADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMEDIKADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMEDIKADE>(arg0, 9, 0x1::string::utf8(b"GTMEDIKADE"), 0x1::string::utf8(b"Adegboye Oluwatobiloba"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/e55kzQAH-TIO3nq9Fsj4vSEz_tIIFTn10epwCaQlQvMBfIMulRiyYWIzTuwJwV6L_1PoYSo_zT0KijdmUbkfRbw3qM5Bpm-XCFOfW5SmSSFPNUST7zQRC2AALX8YefCYtHs9jScki-YeisP2Dw97h3L_kMcA4CGAUwX-B0nxiVe86M1ru66nepI9EXovNzDdHSfeIhGZ3U-4acjWrxfeHxin75qzMypNZEOz4vDq-BIH-Iwyeeny7zazy40IxT3Ere1K0v-O2mo1eNEQzXvnD_X43RcuKKqDB8B2q8p-P01YgJ5vzb_rDkrh7-vwYevN3Cak6uGUzt7mvs5oqGAACA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMEDIKADE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMEDIKADE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


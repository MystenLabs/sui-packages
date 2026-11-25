module 0x114895ff6c0a7226be98a966943b5e37c8b5bbb4b024ec51f2e8def95b85909f::gtablenkkk {
    struct GTABLENKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTABLENKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTABLENKKK>(arg0, 9, 0x1::string::utf8(b"GTABLENKKK"), 0x1::string::utf8(b"Ablenkkk"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/a-PRuH9UmmLsUPXmSqnq_qnTPEnIXajc-lE3-tIkNhmKU2ZeCPX3pjNZEtGpinCr__fZ8LbBUy3a8pkPvjPLe7yXx9d9PzKBxrM3xVFodLCH8fSDc22eLp1gBjXbbQtpFD946HYvW5GYnWEFPvk8r0rL7TNJV4gvkTJJSm2PHynJjFHqRDAcVa71bB2Sj0vWf3uURyZCmDHdw8krANt6w_FD_Cb7114Qs9yhSwzQUstej8WqdSTBudaVMFoARZHSwI0whFZa3ax4DrcdEmlgPgbAwHWOA1lL9mdCMhzWj3yyyhozOSDnL-qslJMfFcHqZxBupbxP__gBw8NzbkiUsw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTABLENKKK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTABLENKKK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0x6cb3c61eb17a66b96653afc1db8d5caef12accc32768aba8f1348be022a7b536::gtxeezoxee {
    struct GTXEEZOXEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXEEZOXEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXEEZOXEE>(arg0, 9, 0x1::string::utf8(b"GTXEEZOXEE"), 0x1::string::utf8(b"xeezoxee.base.eth"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/KRdisH6sEhss2KaANeGdpueQuSAJSMveLl8dziuNg_U8Ej_vUlmJXO4sm5B0J5a--luQsKWu62-JuPKSApg0m8rS1EVAAjq_SXsixynCvFsiuEXlFsN058wFhHDsYeJEmJQKb1p3GylXvN2CrGZm2-B_L0rHL_kWu2uHhxnKpK59v0kSXO9TFJG3S9CKHiFArZ8G2gCPZmBw2dtpPBulFl431Lpztsd7laITEoRYa1T8N5uBeSN_N6rJU1SSrqKA3TCcI6EUa7SMlXQ0yATpAOTZoFYzNca0Ygcw_5WE108Ic-IMhPODA1NPy9gqNdcGWb6B6EzZxf1YE4EQ1mUqcQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXEEZOXEE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXEEZOXEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


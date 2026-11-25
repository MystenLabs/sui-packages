module 0x5ddad4384994f32a234a2fa0d185b180e56a1b83534051ffa1edfeff81bd0338::gtrootardi {
    struct GTROOTARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTROOTARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTROOTARDI>(arg0, 9, 0x1::string::utf8(b"GTROOTARDI"), 0x1::string::utf8(b"Rootardio"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/TNt-Fb_q7DtX8khAkWy_Cgb9cwOmHyPNT6a5P_Ni10Mi2-DJ9Rq02waNK_K8j8yAsH_3RmDV4tFq9I6gJTo5sU_40aZ8rK0tUpLIZFCBaB6CD9hwkUmdM3OO-F772_nCDcElx6x6P5BMI3PkNQOK-WivS2ze58HuBdjESK0qrCLoKctIGibLJGq59-VJR59XLJ0L7zXpCZd-Ho-k56AK6bFRMlkP_LsO1sp9aFbDtq9pJh5dy-3te-ogu9gsXLNFbxWovjXKz1uMSQrKNUQTcprZB87f6U6W02CsiTVCNQxJDqdspEwkVVMaBDjKepUgOyjHdzIiwuN6PykYE7otYA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTROOTARDI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTROOTARDI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


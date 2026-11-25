module 0x4075e7a9db7f538491aa41d84435730deac954927d13a15dc739a3dfd8f50d52::gtjoykiin {
    struct GTJOYKIIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJOYKIIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJOYKIIN>(arg0, 9, 0x1::string::utf8(b"GTJOYKIIN"), 0x1::string::utf8(b"Joykiin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/FbnfXaAEsVf59lXSfVAkX6HOPqxWRN9xJcGF0rUr-vA2eWcsBt4Zyp3lHUxzYxLzOYrhf6GSEpa4oKAIrTu27LmRLinIUo6qpH_3pEuJRYzXWDEG9rBNhStFFGMvZz9tsmJK48BpPSF2pDwzqTQQ_j2znXEd5a5PhmVN--2qv-aSDxgAt3opi80L5BfsnGEEhqr6ipl_NksR0SfAiksMxejoqh0GoDg_0e2edjBXa8S5bkkqoBAh4-TJwFy_BlGkzqyR8NC_wqw2yH95bBKzcd1iyGkkigkyjXNOAY6J_PVpbpDG7NUhTfBQM0NSx6R9qFTr4AL43kGx_CB_Jj6tjA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJOYKIIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJOYKIIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


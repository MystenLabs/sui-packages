module 0x7afa6298bd48ff557d19094207b371d6e4858be9c9bec6ad15af5a64d0a18760::gtthaspace {
    struct GTTHASPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTHASPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTHASPACE>(arg0, 9, 0x1::string::utf8(b"GTTHASPACE"), 0x1::string::utf8(b"Space"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/VLlyL0wkliD2jxURbWWxf_5KTYPFoDTroCNTbq9-vVbtm_B_dQsy1kwzcRHAt5UxplEDpZ0peECSgqMbY3NcmbKz_5RmL4Tzhzo9CrPvJ1qZFj29VBxot7p2zKS1IDuBBIJhtuzoNb-pfLl2qfLPooZjcg4_e_9euapGmzawOeRZKnnHOKbM_kNB7SQQFo2PR8ppvu1SBw9IXIAP5daQ6cxidj6czmObSfZZKmc0AbD8ESdD8tTzxzZ3yUcrxTh6Qrs4_iWi5IdPXu04JW37cM29ae7JRbd7bSek1y-wd5idEHe4E95DUDGtcJnYMtVLXvITujNkfOb-L2KQJsh8AQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTHASPACE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTHASPACE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


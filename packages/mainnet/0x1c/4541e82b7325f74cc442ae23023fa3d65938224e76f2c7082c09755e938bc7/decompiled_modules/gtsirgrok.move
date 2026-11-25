module 0x1c4541e82b7325f74cc442ae23023fa3d65938224e76f2c7082c09755e938bc7::gtsirgrok {
    struct GTSIRGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSIRGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSIRGROK>(arg0, 9, 0x1::string::utf8(b"GTSIRGROK"), 0x1::string::utf8(b"Grok ($BAG)"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/XbZyxPpUDhu73gafCPuScZOffafDZL-8Xmu50Ilwg2KKTODIrSwo5Dkk-FAETfxu7g8K297gztkhdWTg2HX9ESkLS7RMbJS0YjS02Aoz-FomcOBe03YQMH3qwaag-Irnp2LlCbw00CmOnby9B8hgllfxH8fvSHLiD4z9qdN6Jz-SEJ7ol5rsSDlHPb_wJsxsKc8rpC1GWeuKn5yE9SouzVF7v8qkGH3qk4QF1JKtuSakPtfgCYRw0M7zh99wgzGn8lo9pa9wajqnpxuJW0HALIVg8iN41130G-UA9MN95TKQ1mI8p5wtrRAa43kfFMlF3qNTUuPkDW6tUMdTrssRAw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSIRGROK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSIRGROK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


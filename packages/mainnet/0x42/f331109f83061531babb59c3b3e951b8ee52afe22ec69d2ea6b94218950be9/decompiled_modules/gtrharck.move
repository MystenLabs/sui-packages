module 0x42f331109f83061531babb59c3b3e951b8ee52afe22ec69d2ea6b94218950be9::gtrharck {
    struct GTRHARCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRHARCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRHARCK>(arg0, 9, 0x1::string::utf8(b"GTRHARCK"), 0x1::string::utf8(b"RH. Arc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/apsONbzKZ37ebuNpm1grVkBTeKEFSD4Ma7UPw5BlT86yc6kWVwQoatgQ62QlKSvIUQ5dakKw1-w9cEaGEh61MH9ougxkBtj_rcafmHQ2PBLxzodM_euurlHO3AJ5kX99gsiBA7LqCzhXZ7T35qqU7xsg6zXZDzYeqKVw1ehKrnVFTaXoWS9diO0iG3Hmj0LDILOtpBbQAI7BbyFoZL14ySxFsCZPBUr5XP2-KFDietqozvY8RvaBqqXGs_30V-2Cg8dXahTSmOAZfDgTVJon0pxuT15VDcIfEpIEABQwQq5WT6ID9BmcqaHfwd3pzhJaHLApWhHt4SEfBXjgzEmq3w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRHARCK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRHARCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


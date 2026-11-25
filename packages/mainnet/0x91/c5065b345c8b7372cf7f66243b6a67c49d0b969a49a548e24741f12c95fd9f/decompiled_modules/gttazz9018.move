module 0x91c5065b345c8b7372cf7f66243b6a67c49d0b969a49a548e24741f12c95fd9f::gttazz9018 {
    struct GTTAZZ9018 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTAZZ9018, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTAZZ9018>(arg0, 9, 0x1::string::utf8(b"GTTAZZ9018"), 0x1::string::utf8(b"Hugo Jesus"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/rxTFcordCLh6GkuNMKFsKaycKyxTc9Z4EDcj10Fl05igEPK3LoQWYf3Onp_KKqYR6h-uguXimWJWdU08ldJTbOwlOZfP_7rDG6sM7PlQMynvW2YiG7FPo2Lx85G-ZiMkuNlpW2M9fvhmy4UxqXxaZCuak9UxxwjxCb3fNXBAXzMdHr9-2Rcoo8eosJ3w-2MrMco8FUKMafYiJFsUBpolyCg7UGbu8FNkUt_xtVK2VgGckneLxbNZAA9q8VD5fGbQpqPMm2RISAvWQLrynq1kwI3e2wWnSEhB1nuhV1rzewi641kN_bnWKm9qlGvvGXXiRMTKj5X2rZfu2rXwB2WdmQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTAZZ9018>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTAZZ9018>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


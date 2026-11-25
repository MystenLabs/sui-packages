module 0x47b304f9fba3c9dbf0add5d31212e7295cc34a924488352a49a376344adf1dcf::gtxrichely {
    struct GTXRICHELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXRICHELY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXRICHELY>(arg0, 9, 0x1::string::utf8(b"GTXRICHELY"), 0x1::string::utf8(b"R XRICHELYSS"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/YQmUr_HU1LUmJcp_9bUB_VG8pVULSLZBPfzYRPard1tHNA56aF5vF_4W-O3TUKTJcNZFSG4QcN5KvDTWGlf70aZ6B15bx2V-HeKyR8gdKJxJuMBiaQWoC0YQpmT0XeZzkXGMBrRz1CCwUP3y-95hLwLTewNxepK7OcIjVrETrfjZUm-9Wg2mYZaBlOrVCq_3mUBBD_LMYatBBcPBxmIrX8LoMGJaoXuUX-St_pUXsjpzWhAyEtpYRKNrhmvOl6EfgK6JzkQa3vmybI4t1JzWmV_a30C6X_Gj3ouDbyjwwQuz8mXfob3JkgSS8gfEOLWHsStttVfmODDlwE5sFTntDg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXRICHELY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXRICHELY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


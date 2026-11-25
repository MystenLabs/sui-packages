module 0xee66390ce71b693c143fa21e231eca0dad04bde85216971282fc65b7a5190100::gtconfiden {
    struct GTCONFIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCONFIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCONFIDEN>(arg0, 9, 0x1::string::utf8(b"GTCONFIDEN"), 0x1::string::utf8(b"Confidence"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iA1yqyUc5QOWD-z9OVgcvfDRagOj6Ll-_i-Duuv_NCrxvSyb6_1D2FKzq0OmpGT9xUEur2TU8D3HIHW8yTTPeSyzgzQ9u2vnzMVQ9eutoL1KpiAWcJ_QO0Dsh_u31mL3z71z_22OPFN3R5wpSnhY0niymkCFxhQVKS3xHTu9sXN95SPtY-IikDU9X6DSl9CGVMGWFmSbo3OMeLHIMnTfn5ITtJh_2yTobpvzg-7L0SI6RV8O7p09lVWrqiiEi0Q-xcewBJrVeBGSMul9_EiSjrQgpFILuxoqFGAM7lMdWh49xHI1BsPKu9SGmKduDJwwyouSf5JsUSrf8PxXmgLSdw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCONFIDEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCONFIDEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


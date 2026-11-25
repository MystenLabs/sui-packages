module 0x4e07890fe29dab9f9fb5f397dae0e743f8092db91923449a6b8f3b231267a9d2::gtk4rbon {
    struct GTK4RBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTK4RBON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTK4RBON>(arg0, 9, 0x1::string::utf8(b"GTK4RBON"), 0x1::string::utf8(b"Robert Caniago"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/XubuLK7PAHULxr0iuxv13iU9KYf7oJgcmCo_Nz2g4rTdLuOf0aSYZooISoZHO6I1kT71MIvd5NbV5WRkNfu7iVjBMz-99kjQd_WFL8F22xPAiBgBelNRs1JBbmJQuULEahuAeRaEMY2OOzkkEnIgyuM7teRY1KS8cE2wzSSPGDZanROXY7TdQfFA61GBvkVc8uu2OkaJXJ_LINMsJYVA3YI59GVfl6b0ssFm-a0Qc1Zkyd5UHxDzM-vxTgEd5VQrKbq7HbB7N-bXADCePy866EOvB6ssvMexonoYEemMtgdJl-UP-vVXFLCCkThwRvPqhxxQDXIuo_lLcLKuFr-ToA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTK4RBON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTK4RBON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


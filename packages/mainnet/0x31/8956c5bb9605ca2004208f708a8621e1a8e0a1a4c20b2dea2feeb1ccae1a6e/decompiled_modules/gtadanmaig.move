module 0x318956c5bb9605ca2004208f708a8621e1a8e0a1a4c20b2dea2feeb1ccae1a6e::gtadanmaig {
    struct GTADANMAIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTADANMAIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTADANMAIG>(arg0, 9, 0x1::string::utf8(b"GTADANMAIG"), 0x1::string::utf8(b"Danmaigoro"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/vDr4SB3O6s10nyJ3jA-dGzt2Cv8xLElLco_oKn4Y0ht9QCJjFR-mSDV7zsDCKZkI0Zed3MxDIW8A81ZMWig1i1VB7jJ69eA93XhXmjkHpkvFW_bdE8olIcgMY71tWa8nml0paZY1PzAjS79HBDvQ9ElwazMlSRH___FL4D2_Owd_sH21UQKy4I1e70wjgG3SSpR947QJwaF_LGDSi3-knj1TLWTZgBcUEqM56Ub2XIxOITr4BPq5HIHOReddUL9R_vD20lOFyiMpOAD2pYh1qL0NN7DjH6RJ7QB0HO5Jdd1NbKmHOBbS0NjX3mTQ9MTQRmuK87vSsndtk_dlTiP3AA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTADANMAIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTADANMAIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


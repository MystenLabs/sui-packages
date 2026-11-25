module 0xab42772bfb2971b6fe0c1550d77c50aeca5d78ae011adcbcce2bc138125dd0e0::gtprofess2 {
    struct GTPROFESS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPROFESS2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPROFESS2>(arg0, 9, 0x1::string::utf8(b"GTPROFESS2"), 0x1::string::utf8(b"ProfessorOfWeb3"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KFqdbiEkDYGMRWYPwmt320YULo9nGvl0SHUY9b2M0UzZtGIboiT9KUd1rYB0UYpgOhe0lQ1yFdczHylsVUr4_O5CmAdFPNMaMYub_dXG6ZzUzGIbB_AUXj7lt9eZHUGFc1CASZmxcfA2vcI9kgyuNg58ZIQJQ_cbFiIrWu_l6pdq096hpDVk2PZ8w2YoDBxZuAnp12BULamvHUNnXMaSEknYi03eEedJmOi2A_1hdQ5vwofz7hapRXp_C5O-HxpKv9Kcu4w5jpI2kzYAHoHpxt_Gck0MHJ4DpfVy8NNIJWGtHpWMdboOzbfOGtLPV1tiZ48-EMemrOFY-VWA4yq-5Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPROFESS2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPROFESS2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


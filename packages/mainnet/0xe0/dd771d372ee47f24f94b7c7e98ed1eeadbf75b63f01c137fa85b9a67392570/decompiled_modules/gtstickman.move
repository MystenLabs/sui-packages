module 0xe0dd771d372ee47f24f94b7c7e98ed1eeadbf75b63f01c137fa85b9a67392570::gtstickman {
    struct GTSTICKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTICKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTICKMAN>(arg0, 9, 0x1::string::utf8(b"GTSTICKMAN"), 0x1::string::utf8(b"0x7b.sat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/N5mFoon5vvkH_KJXwWIjfAY_S6fHkdk56CV-OEJiY-v4LngnqiFg99GzahEKXrB4tP3qsLXo-awB3AL0Rv3Y0_AkCgK4VMKY9jvusTPD3KRMtoLfwRDy2jSuWImB5--z4VoOtY1GRTFf4fNE2JOjeqPmR4gKVOYJU5kzchTJq-GggZHk59REbrgGv_-97mYxWU522gSE21--aaCcnIB_zSUtFEcm_TrsXq9Tk0q0LH_6Qmo7iL9LUi54bF3BTA1L2TLQ_R27rHnEfpNuYYiI6QmG71wsPXEXXEuOL2SwIM-IcGn5vZPIVg3b64qXJwOFPIP3ATRMxxP5j2lkcEvuTg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTICKMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTICKMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


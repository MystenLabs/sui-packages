module 0x9ebcb49c7952529c4632ea1bbacc359c63361008e287be6ef06a4a1cd5e81f70::gtalvtz {
    struct GTALVTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTALVTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTALVTZ>(arg0, 9, 0x1::string::utf8(b"GTALVTZ"), 0x1::string::utf8(b"Alvys"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/BiLKT6lG4UkFmVyjdM_2mgvup36QgbiWmpRpemhtaSj25CFCqlt9q3kYhDhzs-Ch_W1Wir4LlExiYFaPNKLm2iarIwKou1ufqu6WIhyyZuSrpriASJotqa3QW9Mh31s8ejqiPTfnoO3lW2Ph_zCwmB-FvIoJhHJQ6gY_Hdb485NrPNJ20NXnyW6SQxAHVMWXiUv_C4ms30aLa0SStOc3pakbh7pp8uAqypTUn3NaAL8k1fedDBji1vFQvfL2hF3v_l1CI5MaPNyZHE7rAdPicbFcySf1JRNb5rb3L5t6UdLaoKSdmLJbGpCTu8gqv0q2_qN3NJYPve3yAdbE_xR1vA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTALVTZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTALVTZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


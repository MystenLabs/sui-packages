module 0xb3e7f6d8129332aaa891429fd9905a0a5ec0db076165488fe1a65c78cdd48805::gtcyrilx {
    struct GTCYRILX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCYRILX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCYRILX>(arg0, 9, 0x1::string::utf8(b"GTCYRILX"), 0x1::string::utf8(b"Cyril"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Rq2UrW35MvkgnpjaAanR_fapdRbQHaFpgrmI2fFTp5XGzA5gIvPxsAXKyqRMGroO_kZe9TjNd8_xRlHv7SeggvFY5RoatsAt25lk1UOaEZVfKKt6D7SmXkPcNO6BWtlz88SqTjbx8XnlrtUMLmnYeHCdzxuEEHvkPn1cb2hyuKyD8B1ccX8zrifzECstQZiROdE7o_fSCE-2M_cO_1DNeICnyp3hLx8T0O0p4pQWyj8EW2MC_dR7KmY2BW-iwtV9a8LtfyZI_308n8Y6lGpKNoT574LzTm684ZQZm8Q2P62b5MgsLz5MTLp060nSHx2gFAXNRKYGI1QaYUk0faPUkQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCYRILX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCYRILX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


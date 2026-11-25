module 0x38cfb0a4b0ed4c2d96f380a911d2cdb0cc72a76c9855728a46529616ce9329a1::gtendorphi {
    struct GTENDORPHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTENDORPHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTENDORPHI>(arg0, 9, 0x1::string::utf8(b"GTENDORPHI"), 0x1::string::utf8(b"Moony"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/MHTxjkSKPwdJlcjPPlttp5mmGpzZkJMpNjHnK6qRqodHhua8c0dsrgKlap4ZhlHj5a2mZLZdL9SEP0xHIrNayS9hG8N4U74tXwAsi5I1DWYFjj5po1la1_LIbiyXocOd6EKkzj1Ldh6OggJySnpRv9WftWq9WKZtz1lWqxLZxdjTM7oRieooH6gPLbD0eMgjYNEPlbyAezodiYGgUFTttJsriTxxyXRmxuZrTwHZDJJ7CH06h1aIQ18bIksZsOcfU2ETD4FIlrt62OcxQ8QNhoKGuCHSGZjx66Yew2mu665UlDrp7ZhGTi1VwFqGaFYjdrd7K7UU-4olRDe9sYDOuQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTENDORPHI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTENDORPHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0xb87534b35d45c49ab8d7e47ed82b12ed894c92003dbbf586819c4676e520231::gtnafastra {
    struct GTNAFASTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNAFASTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNAFASTRA>(arg0, 9, 0x1::string::utf8(b"GTNAFASTRA"), 0x1::string::utf8(b"Nafas"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/gUVl-SpjtfpwbCK6hbPokr_TOmqF-aEEt3H-Q24BK8C31BBKo08znp0JEHLQ9CarK9uAOz4SwNF8GkRYzkKQv2tPA7Eo-9wgyebdvdBwe-xO9oZceDM_kc4B4hwZ9BlCUntAgJO4P_TuXFkcq1EQaPcZTzH3BdAkE4b63aLbssYRy4pv1oFZNZCjt62zYGFPmOlXLFCf_Y0mTbYwi9ftXzXqjmipiYrSL51xs9lV_DuTjucnEe5kapwXZisLMNNHmPQ_tx2gh1ZgZacrUpaJ-wnYGcjvPTAEca5gSGev8z--W9qn-YPnfI488pC9S4zSccrUTHg1lf2UbeRpfzmX0g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNAFASTRA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNAFASTRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


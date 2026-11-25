module 0xc538838cb668860d8d4aea2a581745e57c021c688711b48e24936ea0adfb6943::gtxthreesh {
    struct GTXTHREESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXTHREESH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXTHREESH>(arg0, 9, 0x1::string::utf8(b"GTXTHREESH"), 0x1::string::utf8(b"ThreeShoes"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/L0gULcjcYKHz2cZVXlHEKEmTRl2U8wtvH0eCNQh-l1ZzuH9jnqiueCtTbpkCfcqJ4Z5SpOiIkx_HIyTF8OYcVoeAeb9xbhlWS0aYtcGPwaoxlroDNmO2pYhx4huJoJyR9o-6vmdKKAoh0buk-SbTXuemp1OS0DNqjxhqvx2LDfD9xillbC2pQ8ju18UPqQfnpWTURRAK_DA1TC9k8s49GoZWBQK-0fwQAw2hBqzlmWKTajkIgWfBV3rzL7Bs8AcBiE-3b5lS-SFo-kaVzC8zwOzYpiP_YbpFLWFRujhXDQOzf0EKWhkaoviaL5Tr4fKFaddkAuhHPSzF5E4_7AUr0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXTHREESH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXTHREESH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


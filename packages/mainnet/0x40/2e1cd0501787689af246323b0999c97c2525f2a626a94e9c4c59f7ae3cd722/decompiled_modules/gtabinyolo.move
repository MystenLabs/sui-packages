module 0x402e1cd0501787689af246323b0999c97c2525f2a626a94e9c4c59f7ae3cd722::gtabinyolo {
    struct GTABINYOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTABINYOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTABINYOLO>(arg0, 9, 0x1::string::utf8(b"GTABINYOLO"), 0x1::string::utf8(b"abin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/XE5hc-6f2-nG-vp7vxk_7cfnumJRTE3QlG0Q070EHcUWJENxdzdwEs2NSw0sZ34lAdcaGdb9n14qFgyHAqS4q5h8WduIlXzZM-OXLoVmcPw4eg-gyyaGGmrbxIbFevsMo7-JB4UD9JubcIli7Js-rezVoNrUmEKe2rWOklW_xdn-R5pxnbzKB3mT83xGpEfxdrbAvvMSdytcRLpRfb3WwqwJFDfX92kIQ6tL4U5oK6J0AprMy2hS7bwcatX4YrZrLSDDk-5fHDvSujwi8cF33mzg0VyHaJTf4hVdmPQBqZyzY5_V6Oyy55ETfZqSI26nsorqsDa8OBPFNkoALp9GCw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTABINYOLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTABINYOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0x9d2f36d0ae1c4ce888226ea74f136d7da2b83ef9be296009cb30f14ef9b617bc::gtrthemage {
    struct GTRTHEMAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRTHEMAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRTHEMAGE>(arg0, 9, 0x1::string::utf8(b"GTRTHEMAGE"), 0x1::string::utf8(b"R. Talk"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/dNbnhRJEqNulDIi4zqVJyufgbKZds8eZEUqb53HRYCcYFo70omx0xN6aTR6In-WlW3CoK8rF1q29eXco74uFejaUqlndeUQzOfDOf-lpfaNlkknbRDOyX66W67aBmdXnF5sB7Dgjga5OKjUD9Oew1u1oKgnghhqvN2MpqakGUyFd8Y8AXUfT4ocCIS3OUBryhq_8L5vMVcJ3KHJHpy3T-9_d0Zh_j33Qar-gYdHbezm2ErMBazAnNDVR5PsMcyEBFC75aBvMu3Y8WtNiPMB_QHYQ6Uq0mGpYrBEaWist4F-YyMNCCVUbFDdLSYUUjVV5nShnFEAE1mylObN5jir7mg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRTHEMAGE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRTHEMAGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


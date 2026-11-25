module 0xce79abde719615a46d70fa91072971307672e0ec933638c570bd34ff20aeadd0::gtmentalis {
    struct GTMENTALIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMENTALIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMENTALIS>(arg0, 9, 0x1::string::utf8(b"GTMENTALIS"), 0x1::string::utf8(b"mentalist"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/IsowmJ8jm_M3p5pqpBDBePOfYJ3GwnFhIw79RVe4IDuqMCLKGPf25-CejE84DCC4kCWWBkfMAnSxBxoqOZF4YoK9VbXYP7EY0ibullK9tKna5uW0lWenC3Ty-wFQwix4ywf42BNumZpnCin1t6Jqfk4wwXSqDre0v9A7h3DzcFZbpV6vURUIMmqwvIIZ6Ei6YCeYTorV6D9aLw33W54Go-BMUolQ_dxU8rLMuw9Pi0UBYuetzknfZ1sjMaZHWo3Zn1kEjHxeVSmBHJUvmDVTLrV1WkZhXNO_aMf1fO_m0rmiwQ9mjcM1GRiez6OQtVf3n6Pieppl4P-RVde16c1VPw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMENTALIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMENTALIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


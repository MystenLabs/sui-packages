module 0xdb6eb989fbaef1dbd64a471a2e2edd0d8ff0cbab1c640c967db45724e4b7060e::gtecstasyx {
    struct GTECSTASYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTECSTASYX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTECSTASYX>(arg0, 9, 0x1::string::utf8(b"GTECSTASYX"), 0x1::string::utf8(b"ecstasyXBT"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/UeP4NEuxYOqCbbyC5rjF0KIX-P7hmXSNhrasJei5ZVT6bLQc5GJ7C70CoRCWT6QZJBmD8gP1vx7bpmTSzoaI0wMLtQC50g973ps5a2H4oaVkeh6lphN-fVYS1Ny6rX-dQLOTYhU-FAYKbSVk-PINgHbXRCEveBPr2oeVyt2KkHv34ElOFkzdcR1sCZorNZtQHX0ivrTDTVv3Sp96yCDYLf9WGL7hKVzJ2dXioW6AQ8rVa5iakv3TioDMjmDwMXJ2vJ6ZlfHOeNHvBLiY0kmBOiP4HhVeE8mH31pWhj3YumvMuHy-jKS3RTDrLuYL9fYQCzY0O-VJJ1MJbw8ojLu71w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTECSTASYX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTECSTASYX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


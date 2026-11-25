module 0x2a9a1153b5cc3c9e0fd325fd8c1732c312f8c1b3918178b1f053bf715f22df92::gtericson3 {
    struct GTERICSON3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTERICSON3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTERICSON3>(arg0, 9, 0x1::string::utf8(b"GTERICSON3"), 0x1::string::utf8(b"ERICSON"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/CH2HLeWeIkqXholPU4c7Lak9JvgSTR_wlysmU2QDjMjpYm2lD3sjpXwQjstfvMuyPOuq5tnTfdGiGLPZOxV5jzYElHK5WBdO5lSA38x8o-UY0QUsCsEXh2MZ--aYScpqw4DPztk7AYfTCi74w55NVRXUyzJIROseXudA9PDnkKAipswJ3r1x0yDLTFKRHH5XkO02POulmUnuUz6W5ONV_mU3SS9ILzrQsEER3I5eDY_fKkk4WQtB-NNK4ypoA9GSENL1_MbOW-PZFCyJWgFl8tp4kkSjlylTqXNSQGqhzkRG3ARGY4l3wImGjx5T0RqJ9Co6JCR3pKIF8nwm5rkxQA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTERICSON3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTERICSON3>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


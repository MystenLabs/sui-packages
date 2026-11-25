module 0x67f2aff2a9670fec6228d58c696d098db90bf5887a32dc1658c02c1d981976::gtseventho {
    struct GTSEVENTHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSEVENTHO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSEVENTHO>(arg0, 9, 0x1::string::utf8(b"GTSEVENTHO"), 0x1::string::utf8(b"Sele Odigie"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iA6w1y50IFFdDrfkfLg7A6YB9FLZJyekm9BFvxCov5r0g8_2HMKK4h0P6tG0V-LwmtRfYD99rBXMhKEJ_SSzFHCZ9-JehqM-sL9s4RXsp0iMSTbAO3JQYR8qKj5aajtxQ7_91JuhLClxtFH0UKCMHjeuB_phR73K-YUXs3QEnrWMJHmTD49lI6pefpv5a9MqP20JUHEdJbif56m9OSjYZWXyOWa1Qc6Jx3j_R2L3WYlGy1kHbOX_HhLHR_Zj9FWSnp1ZBQp3pV4gN0i16mIquovpgigPzxviDcm32nIJEapN-9f6eTNLFYdWbBqcaXaun1yK9tl3_-WXm4QCJVcOVQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSEVENTHO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSEVENTHO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


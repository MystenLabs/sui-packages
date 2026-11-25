module 0x251e800076a827d77fbf20ddfae3a785456e5e0bcbb8113ae968850513bf99f4::gtblastjos {
    struct GTBLASTJOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBLASTJOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBLASTJOS>(arg0, 9, 0x1::string::utf8(b"GTBLASTJOS"), 0x1::string::utf8(b"Jose"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/DhszopvPGZ0Ftgt6o0w4Rm6elStfHWxHTM4RZ11RYDzHxXez8ZoJmqFAWlnPACvLGRqcIqpYaKVeI1QK8jvMObodWGxENEf5xpGxu3408xoa9byhqQj_Mm34VbiTedgDLndXsakJ6NtUlXJP_jGWvRvtMbWUQER-I7dj2jJsGG8Xdow0ZZyxbbynHSB6MYq5aHMOAYqR-kWi3INRVy5C8RXNycKdvWoeoAQ_OhHcD9-3wV1FURG2mvYjiN7CGeRPY3fKf_xE3-ze4l3cdT7MGaj9iDILnFhmlOvc-kaiLgDP5-Io53I-2qAIOcPMYICDGkF95okWUCL7GQPwM81IaA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBLASTJOS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBLASTJOS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


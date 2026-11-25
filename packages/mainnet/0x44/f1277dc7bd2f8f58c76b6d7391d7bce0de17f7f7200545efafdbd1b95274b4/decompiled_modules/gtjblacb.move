module 0x44f1277dc7bd2f8f58c76b6d7391d7bce0de17f7f7200545efafdbd1b95274b4::gtjblacb {
    struct GTJBLACB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJBLACB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJBLACB>(arg0, 9, 0x1::string::utf8(b"GTJBLACB"), 0x1::string::utf8(b"J JBLACB"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/gTwcQ1gUTmhnCGpmFhX9Qe-W7lL5iyCN4lSWWBXKQaP-eyLq0wvbwGlHux9xeucp2W4mqDJt_spWTmuQExnJARDsRru9vgfWtizmklSKIvuhGtNvTU1-lrfpLsNUonLKqH5w3g5GJIhvJYSzNyp60fxkfbet2UeagHUQNhHaPCm0gSguI-jAvNfyuXjk-oLz0oMUNsgSyechFkADc0qoKqoGahlvyO3Eu8wb_DJ6EHm5YQs-TE4oR5w2PFQCP8bpYKRN1mut6Ua6wzQKcArzEXa56KJam117PEXALLscrWZy0cK3UbNqe-seZv630uFRVg7joKwx7SrUvmTfUE_mjA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJBLACB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJBLACB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0x5b15e54cd7fe8545ce8e222afc5756765c946673a4e30cfde59267d4de1e7570::gtsuidevv {
    struct GTSUIDEVV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUIDEVV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUIDEVV>(arg0, 9, 0x1::string::utf8(b"GTSUIDEVV"), 0x1::string::utf8(b"null"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/EJAN1ILI2ZopxXjsrhTbCsmWt0bi2DcTDTeZYOAdbzOUyjfOyRUqoxkiwbVip9aQyCU3-5iRSQiGA8eIm4SbS8gPOarYGH9QUF-eelagPztMP5AtAlgg0npY3OPr2YZIUJ6s-2R7Jf7cppwuVkUFhgCkR0wRU0oyWmW8EInbDyFFydf4DFXICXX5kQ87pEj_rU7H3xvhu6-9Z6HNwEIsv1FIW2Knfi8jdKv-FETvisMX9W3albKo5JTFlmmVykTzNZJhFMOq258hXGnRz4_225TLna0hbcbKjnuXx5GHqrDh2vmPY7ZqWn5EE7mwx5k6i-3H33Mn_9BXglJHkTi5LQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUIDEVV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUIDEVV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


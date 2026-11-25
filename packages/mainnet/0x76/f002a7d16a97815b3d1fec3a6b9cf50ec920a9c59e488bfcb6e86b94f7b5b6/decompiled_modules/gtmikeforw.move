module 0x76f002a7d16a97815b3d1fec3a6b9cf50ec920a9c59e488bfcb6e86b94f7b5b6::gtmikeforw {
    struct GTMIKEFORW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMIKEFORW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMIKEFORW>(arg0, 9, 0x1::string::utf8(b"GTMIKEFORW"), 0x1::string::utf8(b"Mike"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/JOp29vhRY9f_WK4tbtMeu7lIm6rN52wL3m6jf2duxZo-lHZTCQH5g4ClZboYP7ZkL_FXIwV77pwZAdlCooSzz0Fw8sxWa7rUKYNZ17zYhq1pKlvVWj4DrFBlKP46WFvQbWDVs0w8jUVjEUEmLJJ_ORTK9IfP_D9zqHub2sykn7yBvD-ANjX6KRUm2iGs3VG1jNMnWfEq-YL3fm6DSID8pjYQ9lu0ZZ7Gn2Bs9_-nOUJH1lNaqt1nCmVZSdqe2O4xKLcQIfZz4uxX0vOwPChIn2cYx0kJkOJgtEerCz7Sn0oTKU2NZuqBNqV8hjaZfZcy__arBmDcV95CR3MbPc6U4w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMIKEFORW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMIKEFORW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


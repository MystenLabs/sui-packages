module 0x558a5f7b2642ee82ac2c939ed86d969625162e3d563faed9e00d47ac24875965::gtblockave {
    struct GTBLOCKAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBLOCKAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBLOCKAVE>(arg0, 9, 0x1::string::utf8(b"GTBLOCKAVE"), 0x1::string::utf8(b"Second"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/hR9zg9u1iSW1gpmrviKY2y7dCQ3o0buVEqGtGFSsZ9YIzPhqQeIwrw9LFk8Gm-CFXLgTXMdmKGasN5UAaGHdWC72TRCRQ3mz8rsfPsIYMXheCaBx7atvdMxrnR2ILZfAse9OOH0PK5xYohtgChKPF2vrCafYT4sgkIqMVItiVwbZPDGdVD52KoyTZ2NPl3kwC9_3ovihYpxNgxy3OUZ-oOOyg1JfXrBlaAABdm6pYFcF8IWBZ12y4HP83DkzN8J8gkc-MV89tOWvbR1HzFGZt5HFvFXhr61puZC2id3TuSZ6Xh-HoK2vOvpobHXOnrsVRwGaT-nZTMMUgFbFu0ABiw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBLOCKAVE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBLOCKAVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


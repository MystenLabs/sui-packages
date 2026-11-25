module 0x32a1eaf1363e2c2bc1429fe8e3b7437116283713096ce4ab21db6bb36d53af5f::gtbrightsz {
    struct GTBRIGHTSZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBRIGHTSZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBRIGHTSZ>(arg0, 9, 0x1::string::utf8(b"GTBRIGHTSZ"), 0x1::string::utf8(b"BRIGHT"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/bvvGxrq2oNlrVobUuLRY7Mh9r2VnTlTS3UOOLXCkxNcybv5P6hPOEvlF4Xqow5w4VxaX37iQrLjJ3KTRRL4aomV9yqrybxNv-ThotGRcu8JqrJvXy5DLz8OXmWmSeFYQzS7lssYowfGaxmkq5ywpTe_PiF_vPhy4cm_xkns7CXLPSPb9WZwMiNJmD3r7rpiyz1pWldx7K1_QdsXA5fP3IYwAH9h-yawyqHm99YYsGrKbasNE2Dqjz5f3MbIiXs9MA1x3AFsBhsTh1YWWBRJaL1_4ZCcXKSVc6mRcwng4vwux8fKWoznfa6b_XZIBC1DHWGCPOZtDqPLJ9l0dGxnoig.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBRIGHTSZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBRIGHTSZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


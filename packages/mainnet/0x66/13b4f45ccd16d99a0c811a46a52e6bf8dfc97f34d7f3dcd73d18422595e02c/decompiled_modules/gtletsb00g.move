module 0x6613b4f45ccd16d99a0c811a46a52e6bf8dfc97f34d7f3dcd73d18422595e02c::gtletsb00g {
    struct GTLETSB00G has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLETSB00G, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLETSB00G>(arg0, 9, 0x1::string::utf8(b"GTLETSB00G"), 0x1::string::utf8(b"Boogie"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/os4sZG-ZvYuC1Bfo5L4vcrQR7I_y64WG8QSNf9Ts-Ea9iIhKzDcTVf3PHpAzrOEc-mPc0ZFxyz8QNScfh25UOBXZqHLmOxftfgjD9YSza0-PzJIq_rcJlK7tJEYBelw2QwNtTnUuiZa2I3XD2G5VotYUoHDohsKDPvjHD-WAQDoVpuMZUit1zpNVhL6wYDj96tJbcyavo7kZndQ--QJhdaSmYFNYEE5SGDoMHdmbpKq2SKKGEHZRZiIBfPqEk-HyEhVGZD4LOVJgS8GHyFghs-xTgsYgZYE9Ol1PbeS2sZC0PyZdf18MuuvwxC04Ww3e2Wi6YLpLmAozRlv-ARVuPA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLETSB00G>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLETSB00G>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


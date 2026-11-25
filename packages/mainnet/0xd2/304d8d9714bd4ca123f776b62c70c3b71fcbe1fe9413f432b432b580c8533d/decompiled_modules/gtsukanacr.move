module 0xd2304d8d9714bd4ca123f776b62c70c3b71fcbe1fe9413f432b432b580c8533d::gtsukanacr {
    struct GTSUKANACR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUKANACR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUKANACR>(arg0, 9, 0x1::string::utf8(b"GTSUKANACR"), 0x1::string::utf8(b"Sukana"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/pCThs2kAJS-xNcnhzwIAY2BvgyXtbShXIb6KtagFQkkUQFgFYnxzd9YuVOWI1d8DaHNYqtaXK0MBhj6vjoaD7J-5hxfm8z3hX8sf3qmK1MFhlTMiz7ocSOmXntByk5Unj5ssBjxHOiAgHQAQleAxX9nKfrsdUWNVZ6tERwt8PHX3RRdJPdzEEzPWMl8di-63M9rDelnhRoj8HT9ak6ufl2va5iL42y3hJm4rN7-CcI8TZgm0pZXcDFWJQhWvhDjniszc5vikcnYzOTeszaXwLFYtvxNgYCvQ6HEIDirjphaME8sNxhQa54L9r-wnInFeON1KhakELfV5H2mjWVNfDQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUKANACR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUKANACR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


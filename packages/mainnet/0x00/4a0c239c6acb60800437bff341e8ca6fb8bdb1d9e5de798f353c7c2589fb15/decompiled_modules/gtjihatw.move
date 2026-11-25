module 0x4a0c239c6acb60800437bff341e8ca6fb8bdb1d9e5de798f353c7c2589fb15::gtjihatw {
    struct GTJIHATW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJIHATW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJIHATW>(arg0, 9, 0x1::string::utf8(b"GTJIHATW"), 0x1::string::utf8(b"jihatw"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/RfU1Kqpl7-0oObVDfvTYYWAvSXvESdYyaD7HJmae16s8ndaHqVYiQVLAZJ4Aa8fulvVe1IaNzy9hb3aPoNhOGgciwUD5uWP-dfIGxnrmxgYEdaQUtS8--A4QatFUqbdQOjgSg1NjY8zUoRoqqiMbUDyhQ3ghgB3yYNRHsWk8gQASz5Iuj2-v8-5hHXTTdjErbsJPZ9i3SJdJp3YFVGQbHDvY67xKdoMKhywQOvJX0IVluHgW05XETWD9XDz3A3rBXxQssfUMJhfMc03oCk0c9rq8oB5wdPdAkQW4zoGwjr6lKuiwoDtD7HIaemxN4_WPtdXswvCRmITyoMqs6HseMQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJIHATW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJIHATW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


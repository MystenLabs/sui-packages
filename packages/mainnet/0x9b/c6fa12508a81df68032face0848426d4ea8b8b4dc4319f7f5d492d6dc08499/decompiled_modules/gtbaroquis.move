module 0x9bc6fa12508a81df68032face0848426d4ea8b8b4dc4319f7f5d492d6dc08499::gtbaroquis {
    struct GTBAROQUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBAROQUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBAROQUIS>(arg0, 9, 0x1::string::utf8(b"GTBAROQUIS"), 0x1::string::utf8(b"Baroquist"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/V6frULlnrSReEt0DKMltCBEgvtfEWw2lYutnGvnuk0TDNowyhSk57R9WqmFkCV0gf-ji0COocfM2Sxyq_e34_WjOOzhCyS1N9fvOnjHzobZfDo0eBPg63PaQcdj1O5RYIlklYIsBJWg9K5pKfCkGTo1nAc6ZGOW4vLWQIH9Lf53jd0ZzhLuUfUaKD-1EZtt3AcB7OZE7d2-vlopS29uENcHXY540THI0gfQs71-sUiPEhcO37Y7WlaPTzw7ANPqKk82hTwZBqYOYZy9R_AOztcP8jNBpMRDmrC63bE6EjA67fvuv9tQUKqdUjwJHUxn9_7yYQ8eFAgVRuQjNUb81Tw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBAROQUIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBAROQUIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


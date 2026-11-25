module 0xbc8dcef461ad5ff44f660ec88806f8256920884e0879920b187a03c1dd72e761::gtvaldomer {
    struct GTVALDOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVALDOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVALDOMER>(arg0, 9, 0x1::string::utf8(b"GTVALDOMER"), 0x1::string::utf8(b"Valdomero"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/SygGgJyiBl-TM_P5XfvlIQGOX8HSdfVUwT3ZKHAsJSpQ4Tf9OhgQpGx0Q1PGAUXcp9UJ302FzT5w1XjnS57Dlsl47-OZip8TkrktTMLP7WesC0QK926kZjN6KjY5s4Cwy6RhNAO7dikr62pMVNcZ2N8vAmKdi16zNybFpODAUmsWUZBmlOynWpmt1bolnsBihNs8Ma_oeIzxAhdklp8Ius0_9ZQbjWpdOlhOaXVxHud6j85KyBySY6orwehgdtZckvue5-HA4DSge0pug1OZVt8dWvsVLFTAZ4zyHgcx7LuNadWBlgW5kAUJVV2Zd8hhiBsHqLqwVEX-Vpf2ssnD-g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVALDOMER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVALDOMER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


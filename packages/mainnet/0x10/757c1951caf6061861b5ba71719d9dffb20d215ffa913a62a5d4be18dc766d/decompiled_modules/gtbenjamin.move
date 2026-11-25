module 0x10757c1951caf6061861b5ba71719d9dffb20d215ffa913a62a5d4be18dc766d::gtbenjamin {
    struct GTBENJAMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBENJAMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBENJAMIN>(arg0, 9, 0x1::string::utf8(b"GTBENJAMIN"), 0x1::string::utf8(b"Benjamin Kaka"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/EVin7S2PoU5x8KeixArlZNJ-B5HofEe-RAcY4_iV-EUEzdr3epA3pHuGSHVnHqSGBeEbwmzrPcSLNTdLUXzlJIwvBBUcGafrGIkbWoWFPATnF6e4mINEpdwp8lpu6qulVnIwZPCbBpPE_qJziCj5Pvh_f2MqXkcLo-eTQ1CzY0R-1FyTURvy-lMoUqjJsIt12xQgxiFEawsJm8qWGKbGX1y-CxeLKit5l6fLiacDGGJy6Hq-WRKuLaJ9kggnVBiL93Wbw5t3nYE_gbgCEd8llzlf3TP_Cy2oQGQgfojSjRi1-7Wl9S0p4IqzO7AarWJKP8qz2YSS6UxCpYYur4wqjA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBENJAMIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBENJAMIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


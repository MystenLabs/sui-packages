module 0xa68168c2b4950820f8b4fc0b59d50e3d52df6408c1a8745255da08ee1af88851::gtcybire1 {
    struct GTCYBIRE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCYBIRE1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCYBIRE1>(arg0, 9, 0x1::string::utf8(b"GTCYBIRE1"), 0x1::string::utf8(b"Cyber"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/DJ0Hd9DKc26qR6i6fjr1Dzibo92b5B6tBo1Do-xcgjsML1f5NoT_ZH9AdNYBLh__T2kVJl2li-0GzMj_jlnuyjfrt9qMTqnLXGJl7T4SGMfeELgKq7nRQooNLZPBZPYesCwMv4rgTZP10-mQHn0zVbPO32APEmtl4RMyoWAicH-PbwaCvSmgfaiD5GQOHWJEelQ9Ghay-wdvfTvazCJzAqyHn7RSUKVvBS9kqEgAsuvLCpWXN9Oqu_rWyHvOLqpEHGkUaEhwaJwrylR3igo51YjXCF49elq57Zi9OwZOc-Ml3pDvIBSKsHuXdtfa-ubyZjnAnILEih3ryu37UnHfbg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCYBIRE1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCYBIRE1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


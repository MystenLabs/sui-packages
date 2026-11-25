module 0x92f38474076e2c6e4a2b6e5a89c9606a97c89661bbf95b03175072e152d8d759::gtbieldweb {
    struct GTBIELDWEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBIELDWEB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBIELDWEB>(arg0, 9, 0x1::string::utf8(b"GTBIELDWEB"), 0x1::string::utf8(b"GD"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/L4qWfCN1oLpYKLIh5hq63irWhczRrUH1_2jggejFMOCceO-17_OvJbl0oqiQt8FAI_h8IAWJRxnzXVANPSpR6NTfUw_qFMcHwju6e71FsCpxsYz6zHb_Zf-ytHSbVuJDBQ9AhoiZu8Zn6O3XAeSL8wAYjMfj8wz6Bgv4MnoAzC4fqz4Z4hbZoYIKkmf2F3jFY551ijcctcqF4L0u-793EXqKuxlYFcWmasXxh1S-w5G6UGEeJYDgwqEf13VqSDOsrUzSHUMpBbodrn871bCXLSvtrA4FC4EmCXz5UUgaxwvWC4Mzpfa0eF5YA9Axz_rQThVd03_dQBP3a5GEPnN-7w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBIELDWEB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBIELDWEB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


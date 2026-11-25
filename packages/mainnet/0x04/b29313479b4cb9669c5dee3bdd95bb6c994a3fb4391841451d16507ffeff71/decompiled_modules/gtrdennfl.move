module 0x4b29313479b4cb9669c5dee3bdd95bb6c994a3fb4391841451d16507ffeff71::gtrdennfl {
    struct GTRDENNFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRDENNFL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRDENNFL>(arg0, 9, 0x1::string::utf8(b"GTRDENNFL"), 0x1::string::utf8(b"Raden"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/RH-vKym0I25b_-6qVMxbxOpF1V5Q5lCqjNml_R5mtOLn0P3muEdKEcY1wookgP2vhcWZxiGkaSK2sKUSlao2aAwVE0MIAxYH6Zto67zoVD0oI22d_FpqNlcIK5idinybuASvrkNXZYLvlfwJUxvlx8X5sqccNhjyruYDgniemg_W4JQZz9DbFDebU3jGwEXOdpU9Y-LA0zwccHfat8kJwRp3jYxhSqdQpWUsNAGLLlxe9OBriYfwfiedyyObcp79z7VWArxqn13Wvmoqnmoi5JHwHNn-Btp5yquSrSnB6kA_Nd0m2UVI5YvoH5pa9RkQfg3CA8ETzPav0la82-dGYg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRDENNFL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRDENNFL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


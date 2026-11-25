module 0x8b08a652d88b1f883ce85be4cb056439e9c071276392acd276e0997736a016bd::gtwisehair {
    struct GTWISEHAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWISEHAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWISEHAIR>(arg0, 9, 0x1::string::utf8(b"GTWISEHAIR"), 0x1::string::utf8(b"Dawn"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/qYEKVigwL3Urt4pXVMG2_24ttspyz94MTu4R7u44BFIxavxgtndf3n3oiZSxqtXkm0Nf9RD_NVqD_nHvaWVbbeLNjgEPRSus5dFLEo8TFJqFomSwYTACkoY1nuXj0vFuvs3zpI73YrAEmJEvi4WB2rkFpLTG-SWJ-ZUGcK6Ar0J6MlUVLXTF_cm-8-CeJglt-ItlYS7Qn6UjugoGwxMlzRCtOzvdd1J269lwar8fB0CKBiAQAYFNxVkT2j6A_oQbf0lAiNOXipfbOi67c71DLmaFOmigjzWHyrdsV6QbhAegYe9gT25uBxez16X-Ww5YM69IStvDbDql_t40xVriNA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWISEHAIR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWISEHAIR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


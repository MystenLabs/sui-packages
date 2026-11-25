module 0x5d5eb6df37b58625ff4b5199f35fa9d43013946c03936b2ec4e86309c1af7ddb::gtnovahalo {
    struct GTNOVAHALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNOVAHALO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNOVAHALO>(arg0, 9, 0x1::string::utf8(b"GTNOVAHALO"), 0x1::string::utf8(b"Angelo"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/U3w-sXZn5ryi4RPv50-O94JgE3C7rWTmk9S0iruAa3nwHTXrMMM4t2deDWKkxMtssthYwqdFvVZAp0uc_8-SehrK1CCcD5F-Kdbp8RlJMPFpXAMKEJjfQHAPWGDluAn9zf8o8TQwU2ZjTkAjB8ZJ_j36sNdw9yksECcjwHq5zFTbZ1ymCouVnhNOwzcHIYXqLPqVALXGZawHHpCp9YfgJbZmBCVhEXwdf6-ZgwOHza9JMT4tyXS8lZ8nY0UUaBcSg6x4bCQAImb__qSKZKx9N7raiRsa1UbMQncLPaghmeoIkvet3p_AWnlKbvIBESuD6IBwRskTKsFiEbrtK-f7aw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNOVAHALO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNOVAHALO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


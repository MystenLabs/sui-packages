module 0x350ff70931c7c3aa491e72b6934a39f156b4cd0bf23f166c06b9dcd4dfb1917f::gtgostcybe {
    struct GTGOSTCYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGOSTCYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGOSTCYBE>(arg0, 9, 0x1::string::utf8(b"GTGOSTCYBE"), 0x1::string::utf8(b"Hantu bazernas panjaitan"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/p3kpODuwJi6mxrNfgE7MWrj6k4u2FihzFfHamsw0YHzEJ11CBZvq7r877--bHtRbqoQzWqwxzddJYB2fZ8tbWhgmIIGc6sazDJygVQAsbQZT0nDYMrOYYLuRJGmwmhNsz2vma_X8Vum6XYrOiuFDu_mku1XsXynVeidJzPE35DDchWqvIC8hf0WDcyXBcEH97IKxD8A6GkNs9eAdeh0I4kIxXyl8nqPbBfdbP9sEanfeRuDZlYwxU6HLA_I0bYErqLrPnPBfNpo9OK_sLD870TsGdpSGzot1QYz8o9sqYaPgboC1Z3DBei3W2_-UJW5-E18WmrKAalI2xpI89oOMGQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGOSTCYBE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGOSTCYBE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


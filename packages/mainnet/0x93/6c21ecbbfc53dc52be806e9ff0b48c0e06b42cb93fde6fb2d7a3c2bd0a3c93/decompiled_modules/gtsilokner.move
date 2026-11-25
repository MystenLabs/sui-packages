module 0x936c21ecbbfc53dc52be806e9ff0b48c0e06b42cb93fde6fb2d7a3c2bd0a3c93::gtsilokner {
    struct GTSILOKNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSILOKNER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSILOKNER>(arg0, 9, 0x1::string::utf8(b"GTSILOKNER"), 0x1::string::utf8(b"Silok"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/LbCSQaS-T7oEwM7TxWQF4lgAfLxEXc8YbMNyxzYL8_hdkCn7mN0Gexf5_bqNOJUvOTGi9aJkR23UpdwJ8fgzDcnTat8S8zXM6ayg08Zm2S7bNUSWrJma6ykaEvnr1yJBhUOoj_6hbBavt1yXPk1PqVt6fbfDzM3d9PmiDftyoDaWfueXoinHdWnH0Q-80dRA-xZ3uNfSOS1DPzjNvA872b-yY1-PLLrKSiVWR0tIATbfAqvwxZWBBhowrNZBdM9_EKFq8zhJzCrmTz8CYOPEEVrdhu2Uh0MKK6YgL8CeFpIFuYV5Y7ohmzCu52oYOQ9AYATMn8f5LzsIIGrRRLkGgg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSILOKNER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSILOKNER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


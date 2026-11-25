module 0xb4cfd0531ab29e274e65976ba6dfefa9a24fbc762f3cfd3ca572eb38b03a45ae::gthikari0x {
    struct GTHIKARI0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHIKARI0X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHIKARI0X>(arg0, 9, 0x1::string::utf8(b"GTHIKARI0X"), 0x1::string::utf8(b"HIKARI"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Mulk-whSjklehF-Toyzd2TDsURMsDVCNJJ18xs2iuw8XkAz6LzLMWT05b3qws174ZFGBJ15GDUs7YbW5u86YaYIS5LplygY8QZcn4q-Z0laa75Shv3_PUe4dn4XMHQnIj-Cye054fdvtej1PDo8HYv93iU8vpuZdZsxZEYWvwB70vc9ZkC9m47X6jnn-U267EsZWcrvyISIJdlolHG3SY7P914UIG04GBsUwTTwmkorc1tAAMTyQMfjBytn5SZPx0I4dlnJbgyvZacrf7U9jRfuPgaoUzz_COwwp7y4yFGbFI8cokQeVYczHmeip3KuCM60ydYP8t5XGjLH0JGtP4Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHIKARI0X>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHIKARI0X>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


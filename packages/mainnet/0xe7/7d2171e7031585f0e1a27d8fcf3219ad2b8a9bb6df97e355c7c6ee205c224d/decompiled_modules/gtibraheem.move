module 0xe77d2171e7031585f0e1a27d8fcf3219ad2b8a9bb6df97e355c7c6ee205c224d::gtibraheem {
    struct GTIBRAHEEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIBRAHEEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIBRAHEEM>(arg0, 9, 0x1::string::utf8(b"GTIBRAHEEM"), 0x1::string::utf8(b"Ibraheem"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/IARG550gxwF34WYyWi-lDkyU2HcXnWy_zFrthm1BsnICu7eLUtI9MH4m7KAp26ed0ZQoEhPhv0eUhWNKeoltl7pWYjjVrktibLrxVNl1rR_61DGZGZxQ-ZYsMMj5Fi4e8t5Cf2icfBbN89zW9n9SSECCYIz0Obtjl7KuRAB00wl0dOfMqGHRdyI3YamyKB1FNkGNJcR6PpeUU1sCaY6PkXi3PZCdEKVNQiUCK-4_-xebaf0mp8SF5kQcOohV0w_8plf1m338bBgN3iJtYBREm-0PkywyBXxXOyFugQgKttVBNg052IW-AqjskZVFgrFsCNyqBjBz5CFHilFO-5qa-w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIBRAHEEM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIBRAHEEM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


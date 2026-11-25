module 0x37894c87b75bf6ded09e18c74f9c82fea18a6caaed1c46e6443f230501ab8ff6::gtvosssui {
    struct GTVOSSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVOSSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVOSSSUI>(arg0, 9, 0x1::string::utf8(b"GTVOSSSUI"), 0x1::string::utf8(b"Voss.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/RKM4qLudOAIwc0EzE72v9sdWUl-heiEDIOEKU3h88CnoWe7FkwiJZapuURyC3Z4mryHzlFyShosDd6OzxlGWxG42_v4e4Cys2cFy6ZyGGLFZxYjXAsC_vo14GYcJb0si8ip_hLZgLDBShoFXc8mRG1JwgXV9P_8KTxM0kc36_IRd0m0caGukWcQ5gFqGAUuii2oszwESx581je2MKOcnZxxGD3a9aIQn_zrwJfGvSN-wWfCpR94AAP5e7R60of3HFhRTfaCs5NoamHTEAnF6_g1wxZNE3aHxn0KX1Ss2QZmaog3kfBODJr8R0rXG7XccLKUTUN5upCkNOZhJL8BX4g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVOSSSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVOSSSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


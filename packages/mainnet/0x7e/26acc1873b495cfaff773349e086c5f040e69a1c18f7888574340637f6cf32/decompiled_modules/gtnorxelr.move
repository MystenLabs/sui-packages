module 0x7e26acc1873b495cfaff773349e086c5f040e69a1c18f7888574340637f6cf32::gtnorxelr {
    struct GTNORXELR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNORXELR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNORXELR>(arg0, 9, 0x1::string::utf8(b"GTNORXELR"), 0x1::string::utf8(b"Norxel"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/sbErf-J72-kq9xYN-4kxHymmVGuipWzq4H0aVY5MtXwWKosQ-tGcGA8vMKXVNyrPd42vzIIU40a1BjOG18KAzCeDsAd7Ignc9-c86hz35np8y-YrlLl3fdeiX65Vuyk0DfsyztKIlwnvV_M5blNlUrBy9bQ-tL77nz0ayaiCK_o0kAthfS2m30UtjkROSkgDngWgXE_M-RSkEFq2za5Jn1OrUNlhQaMhH2XuPe-4ICySVPCATGmAn6r-jMBIVNl5jaaBvPbvrD8fgH8eKXh0dj6AT0flJ6RvxcHDT2igVmZL508kxZSuuKf8hobg3nXthg6WKcfIVpZwfVvyS732cA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNORXELR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNORXELR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


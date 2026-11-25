module 0x2ecc862fc2f318b0335432989cb55c3d789ab3a55eb7f4d14dc10066498fa282::gtashwin19 {
    struct GTASHWIN19 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTASHWIN19, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTASHWIN19>(arg0, 9, 0x1::string::utf8(b"GTASHWIN19"), 0x1::string::utf8(b"A ASHWIN1990"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/gF8yoRQ1xczU_a3hvrM2oy29F9tQnl8iLnF38IQ9HJS-Lh0jnHcFhBXu85mwMtNZOU5fZpnCfoPU2ftUmadaomiCWqvnDHz8H--JyxnlXLYG5fqOsHpsjZoNePD4d74BMQz5Nx4jZ3P_QOZ_rYE0TFTaI8KLtmQq39E5F3RsuqM_4S5Wu2y844AJQcCkjVxdMsveIWmw2CkY1_KYfEihJLhQg-vh7VERBNpupGuJrgXTFDfBWBc4n-TkathpLVwONLXDwGijRsbStQ7AOR52C_0wXD8rIhdhKn-I9HXa68zzn_PaZIYFKXgYVMkAdpQJS9VdHT3T_j3pgeX42GC8yg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTASHWIN19>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTASHWIN19>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


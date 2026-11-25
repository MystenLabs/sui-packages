module 0x87f604eb0e9f6d202c02fc15979047dbf53d7cd88db71c6aca482e04585995da::gtvaldera {
    struct GTVALDERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVALDERA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVALDERA>(arg0, 9, 0x1::string::utf8(b"GTVALDERA"), 0x1::string::utf8(b"Valdemar"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/YsgWlLWuOqeWlsAWXuffdh_fM2NMQPbRbwIzk2oNW8iEWnd3oenTZ9s0wNRhG2gC_fQrMRj5W4ohZN3-Vu-7lAum2xMAdeIZh0BdO3mF2QniVRV890mtuI1b4vrtK753dYeuJ4GP0JHDqr87wpUUWKXVuZR1dan9KhfPZ1kb-fSoiDXN9XMExXzuDm0xDUcmSa699GU2URtLmiXEBBsGdhVsFvQ0dPN1ulX5B-X8M0D1uZAS7MiIWXQ1sFw4Qw0wvop3ES-3VNNP_Q-aAWDqJuEf5c4POFvJTiWVcSRQWmiFFh2lOLPZsO7pX961lyHroMIurameLYkXSt1dfYj43Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVALDERA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVALDERA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


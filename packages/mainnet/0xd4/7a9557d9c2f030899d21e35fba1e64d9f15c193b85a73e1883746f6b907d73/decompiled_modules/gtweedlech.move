module 0xd47a9557d9c2f030899d21e35fba1e64d9f15c193b85a73e1883746f6b907d73::gtweedlech {
    struct GTWEEDLECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWEEDLECH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWEEDLECH>(arg0, 9, 0x1::string::utf8(b"GTWEEDLECH"), 0x1::string::utf8(b"WeedleChamp"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/vf3PFm31zORPjc0nJ_x4lZOZd00LF1STuqW7AuLrvo1dK0zx3LKocF2P_bC2PEL7prLmOZxaLaZu79cZlPKSJxIvdE7ZvnWDdsz-kVEU1JbMV8oGaqKcpsg5vPAEpeFkLxndnKOcUZ_4PC380GpcRiiT0QW4-nEkYTYriHJ5vKQE04HJG-gnPAKkK6yj8onMnsgkk3gv6KvNx969WHvLkt09qxvL4c-1PK5Y3PJOlWh9Vckje1axPI-dhtMq7g-ZmFTt4spEwRBqtsEvfBvYKJ86MtQGZIlOF54cQIJ-lsfebqDGP0zs4yx5ur9x2qkBV_KPNoQqNpBF3zSMmIE8AA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWEEDLECH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWEEDLECH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


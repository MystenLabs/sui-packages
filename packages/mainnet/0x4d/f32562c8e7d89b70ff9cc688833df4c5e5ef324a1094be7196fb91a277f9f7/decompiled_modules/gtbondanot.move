module 0x4df32562c8e7d89b70ff9cc688833df4c5e5ef324a1094be7196fb91a277f9f7::gtbondanot {
    struct GTBONDANOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBONDANOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBONDANOT>(arg0, 9, 0x1::string::utf8(b"GTBONDANOT"), 0x1::string::utf8(b"Bondan"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/fmznuRoKCgW9aViZ3_NFrlDy-X61dOApLj50-F1P3lFS4PjLaUeyzrOYGK_6IQDQV8pLCc5o_x3NqzCdfNaA53yGVEihkwe6rMqNeiihnuj-3UdDyE72X5gr3fI5eA2AOxEG8FS6oYOaU5EET7-CL1roAN4NpzC2Zt0r_70Z4V2uVXtewMzTPoQ3aZ5zZDBX_4NCoemWOTfiObkiER4-QT68zGBC0pyGea3ZvOzqAyQH52NRpuOjAaEZ249GpO2Ntr6-_vtaDrbhHPmqJOS1Z9iUHbnPkkIe828rMQ18lTn9jFGPOK6HRMFPX9e32gnC0PaBMQhQgrUGXYDdAVmflA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBONDANOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBONDANOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


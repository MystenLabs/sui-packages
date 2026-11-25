module 0x8b50fd2665a27344d5befe2557aee002d84239c4fafc5efcfbd4990214707212::gtfcksndy {
    struct GTFCKSNDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFCKSNDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFCKSNDY>(arg0, 9, 0x1::string::utf8(b"GTFCKSNDY"), 0x1::string::utf8(b"Fcksndy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/fy5647nEDMQ11Gi8hfzIrMIlNiGOUIzN7W6OGbHWSwIueIlPFwGUPf6fSZC_b4XcFGNUjqOwQ7jWi84d6gUpOB8OMl0-L3sBZSV9Kgy_uUUAgOAGnXhd7QGjIJK2nR5nFwiLos7CIWfwuUOuF3DklS2wRz-01HU8k8BhOtI8CaKmvLevWG8_78QMwnNm_tBV17sk-tzlZZVFgyawAxepEw82HvXCsJzAf4_n4u4TMvQV0qEwYR0zr_V429SxQ68_OgsntvhJvLJeQDLsIqvdfkHsTqfYr3AHCoBeWKfKFm0icsQojEvKI1WyM-e2FdTrZD9ctGH9Nw6GkXAC75uFRw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFCKSNDY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFCKSNDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


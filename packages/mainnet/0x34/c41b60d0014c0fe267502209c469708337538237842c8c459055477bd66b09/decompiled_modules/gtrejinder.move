module 0x34c41b60d0014c0fe267502209c469708337538237842c8c459055477bd66b09::gtrejinder {
    struct GTREJINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTREJINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTREJINDER>(arg0, 9, 0x1::string::utf8(b"GTREJINDER"), 0x1::string::utf8(b"Rejinderi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/J707Ca-wqXKjQdNv97byq3FlwtiNY-Z-MtN9NWyDGcS6mN4gro_XByYZOdyg7Tae2XitPU8dSqIe80zgvt7rY5zXd37tWfl02Ea7L4n0PwCBZhft-yB-Z4tDuoRJQJWScwzKsq-MtYBg3CHBIAXpuC5miP1PpjqWTS1LGz4ThSf6qZURhMLGlB4UMMXSxoByXDHEi0jJKRls3ZVkhrrggUiGur6UAxAsG1FdRgEL4tabNoFI-fsMBu4PSC3ka2zCfhc9FI5inSCXZybdjIJDnxq4eCxIOcM8jtL7WEJpkVrjihOugi7FNs549zi7jxixkAZqxyTByB57mu0CCJpFdg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTREJINDER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTREJINDER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


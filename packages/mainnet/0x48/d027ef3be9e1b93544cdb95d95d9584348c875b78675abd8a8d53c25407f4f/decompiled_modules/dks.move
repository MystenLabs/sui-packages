module 0x48d027ef3be9e1b93544cdb95d95d9584348c875b78675abd8a8d53c25407f4f::dks {
    struct DKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"480f4247cd2569a0ee22b28bc5880e8514e4f1f27c290f16e8e4ed8a70a5b63e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"480f4247cd2569a0ee22b28bc5880e8514e4f1f27c290f16e8e4ed8a70a5b63e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DKS>(arg0, 9, 0x1::string::utf8(b"DKS"), 0x1::string::utf8(b"DARKsui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d5538c111a07dd421b68bb97ba4d45dae7808fe92e8287f1006836ec37d0188e.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DKS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DKS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0x4c542cf00376f183e3d3adfdd49f017d21db8c5685420a0161488c7e56e97abb::swo {
    struct SWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5c9a38eceeab10d24bc063f6ccfc294730b14043aab4c7e0388d42d1f98ca732")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5c9a38eceeab10d24bc063f6ccfc294730b14043aab4c7e0388d42d1f98ca732"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SWO>(arg0, 9, 0x1::string::utf8(b"SWO"), 0x1::string::utf8(b"Suimillios"), 0x1::string::utf8(b"Suimilio world order"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/478c7f23c9c2b62a6f00cc5dab8c2e755e47cc058b6e6f906bf640159b75a2b3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SWO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SWO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


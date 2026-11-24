module 0xf7a9e9a1a28d7a427cbe370f3618e0593591cd83fe2a45d2b2e4318b0a28c280::raise {
    struct RAISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3c453e6463ea91b37f56f8a101266413131b9bc6fdabe09ec5e04f00edf100ae")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3c453e6463ea91b37f56f8a101266413131b9bc6fdabe09ec5e04f00edf100ae"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<RAISE>(arg0, 9, 0x1::string::utf8(b"RAISE"), 0x1::string::utf8(b"RAISE"), 0x1::string::utf8(b"RAISE THE ROOF"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/469bf00bdd43542b464363658cbc5764936ab6a337154516a5b81c8efa0b0e82.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<RAISE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<RAISE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


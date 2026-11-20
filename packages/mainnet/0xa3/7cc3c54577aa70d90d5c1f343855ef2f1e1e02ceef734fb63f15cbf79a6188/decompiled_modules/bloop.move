module 0xa37cc3c54577aa70d90d5c1f343855ef2f1e1e02ceef734fb63f15cbf79a6188::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a0a0fa961552e971f89a745fddc4c386639ce4d8ab546d8ba74eb0ffc1b5eea3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a0a0fa961552e971f89a745fddc4c386639ce4d8ab546d8ba74eb0ffc1b5eea3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLOOP>(arg0, 9, 0x1::string::utf8(b"BLOOP"), 0x1::string::utf8(b"blast loop"), 0x1::string::utf8(b"blast loop new meme on blast fun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/15d29306e1203ffb2a33a5fb2ee2c78ae678dc7fbc29c87e970e5ee1829d5abc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLOOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLOOP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0x3480af1c2b54c5edf624f1063916ea3d06d7d0919005d6f4d0b41a972fcbe8cb::madteo {
    struct MADTEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADTEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a5fc22a348421b9160f896da2b07ff20915d4d8d44209f0a5bce4ccbdb8aa013")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a5fc22a348421b9160f896da2b07ff20915d4d8d44209f0a5bce4ccbdb8aa013"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MADTEO>(arg0, 9, 0x1::string::utf8(b"MADTEO"), 0x1::string::utf8(b"MadTeo"), 0x1::string::utf8(x"49276d206d61642e0a0a4920626f75676874205355492061742024302e373020616e642033207965617273206c6174657220697427732061742024302e36392e0a492068656c642057414c20746f207a65726f2e0a492068656c64204150544f5320746f207a65726f2e0a492068656c64204d4f4e414420746f207a65726f2e0a0a492062757920657665727920746f702e20492073656c6c20657665727920626f74746f6d2e0a0a244d414454454f2e204e6f20726f61646d61702e204e6f207574696c6974792e204e6f2066696e616e6369616c206164766963652e204a757374206d61642e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/60f81604901b858f21a787987fab9bb70c39cf87bcce7489cbe75b401739484e.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MADTEO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MADTEO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


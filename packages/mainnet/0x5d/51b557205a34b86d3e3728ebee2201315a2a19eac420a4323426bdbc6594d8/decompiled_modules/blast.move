module 0x5d51b557205a34b86d3e3728ebee2201315a2a19eac420a4323426bdbc6594d8::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"Blast"), 0x1::string::utf8(x"4120636f6d6d756e6974792d64726976656e206d656d652070726f6a656374206272696e67696e6720676f6f642076696265732c20636f6f6c20636174732c20616e642066756e20746f2074686520426c6173742065636f73797374656d2e20f09f9088e2808de2ac9b"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/fa51584a35554deb50a16467fdc94520228e439a47f4cd8f6cad9d2856d9c369.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


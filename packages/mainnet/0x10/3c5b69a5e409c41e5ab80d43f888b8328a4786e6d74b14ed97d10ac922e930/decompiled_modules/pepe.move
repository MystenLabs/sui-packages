module 0x103c5b69a5e409c41e5ab80d43f888b8328a4786e6d74b14ed97d10ac922e930::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1409b7db4782a88ef2b5483f1ca175716a1f0bdfa0f52ddca8b1111591b9bebe")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1409b7db4782a88ef2b5483f1ca175716a1f0bdfa0f52ddca8b1111591b9bebe"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PEPE>(arg0, 9, 0x1::string::utf8(b"PEPE"), 0x1::string::utf8(b"Motor Pepe"), 0x1::string::utf8(x"4d6f746f72205065706520e280942066756c6c207468726f74746c652c20677265656e20666f72657665722e20f09f8f8defb88ff09f90b8"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/81be7198f3f6a55caf381144a910a3d669c197e850f7750710ede8db6722313e.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PEPE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


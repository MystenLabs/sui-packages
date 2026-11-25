module 0xe6c7834af4919f528686bd991dded8f3976a16c90b47141b1c2d76eae10796b5::gjew {
    struct GJEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GJEW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5c9a38eceeab10d24bc063f6ccfc294730b14043aab4c7e0388d42d1f98ca732")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5c9a38eceeab10d24bc063f6ccfc294730b14043aab4c7e0388d42d1f98ca732"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GJEW>(arg0, 9, 0x1::string::utf8(b"GJEW"), 0x1::string::utf8(b"Gjew"), 0x1::string::utf8(b"Gjew"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/77229ac5a3edd34b3482d862158fbb438f18571227ad6c34e4dd8fd853962e10.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GJEW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GJEW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


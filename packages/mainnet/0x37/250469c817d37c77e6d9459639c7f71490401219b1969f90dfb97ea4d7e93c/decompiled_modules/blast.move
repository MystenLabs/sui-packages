module 0x37250469c817d37c77e6d9459639c7f71490401219b1969f90dfb97ea4d7e93c::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1deb0e8142c64ab9c142126dc461e8e6036443aa712fd1f694d9e97ad722cac6")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1deb0e8142c64ab9c142126dc461e8e6036443aa712fd1f694d9e97ad722cac6"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"blastdotfun"), 0x1::string::utf8(b"Launch and trade coins on Sui, directly from your wallet. Open the Apps tab and you'll find Blast right at the top."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a579f937799073bac00c70df56ef61a0cbfcf5581c2813a6b64bba5bf7d2b8cc.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


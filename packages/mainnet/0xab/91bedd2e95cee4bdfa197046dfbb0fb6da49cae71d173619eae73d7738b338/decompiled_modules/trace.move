module 0xab91bedd2e95cee4bdfa197046dfbb0fb6da49cae71d173619eae73d7738b338::trace {
    struct TRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"00d0aebce1d1900de7fd25121f6618c46177d83efd40bf92d83835f9e82f7d6d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"00d0aebce1d1900de7fd25121f6618c46177d83efd40bf92d83835f9e82f7d6d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TRACE>(arg0, 9, 0x1::string::utf8(b"TRACE"), 0x1::string::utf8(b"Deep Trace"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b23aef121d3b8dca36edbc55e0f128a55bfbebd2dd6e3a8f237f9889615ab47a.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TRACE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TRACE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


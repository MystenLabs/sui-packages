module 0x8c83ba0fc57353530159e813f4f31b38d6290cdc1334453303cd07620668a578::eaccdog {
    struct EACCDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EACCDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<EACCDOG>(arg0, 9, 0x1::string::utf8(b"EACCDOG"), 0x1::string::utf8(b"EACCDOG"), 0x1::string::utf8(x"54686520646f67207468617420616363656c6572617465732e0a652f61636320656e65726779206f6e207375690a5061797320686f6c646572732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/57725bbd470385ee331c0877c94b88b66a16a47068624d2ac8f399074cc0a27f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<EACCDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EACCDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


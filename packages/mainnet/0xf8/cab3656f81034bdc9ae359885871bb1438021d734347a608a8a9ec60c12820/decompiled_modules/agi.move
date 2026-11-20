module 0xf8cab3656f81034bdc9ae359885871bb1438021d734347a608a8a9ec60c12820::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a84b8b07ca848898659f8168ac66361410435b63288b10617c8e379380574d2b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a84b8b07ca848898659f8168ac66361410435b63288b10617c8e379380574d2b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<AGI>(arg0, 9, 0x1::string::utf8(b"AGI"), 0x1::string::utf8(b"Agorian"), 0x1::string::utf8(x"546865206f70656e206d61726b657420666f7220696e74656c6c6967656e63652e204163636573732066726f6e74696572206d6f64656c73207769746820612073696e676c652041504920616e64206d61726b6574e2809973206c6f776573742d636f737420696e666572656e63652e204d696e6520667265652041492063726564697473206a75737420627920686f6c64696e6720244147492e20466565732064697374726962757465206261636b20746f20686f6c646572732c206275726e202441474920616e64206275796261636b20244b4e54512e204275696c74206f6e20456c797369756d2e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ac76cbd10b1ad53e32dc4c1651c6e33e6fb759a7eefc0312535881ae9a61f7b3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<AGI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AGI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


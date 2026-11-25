module 0xca0f5be311a3f195e091a2cf4d657610dae9daf2a6743159f794579d5aadabe2::gtnanncx {
    struct GTNANNCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNANNCX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNANNCX>(arg0, 9, 0x1::string::utf8(b"GTNANNCX"), 0x1::string::utf8(b"0xNann"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/cqjiEGZHZNs2WQg5YeiuWWEQaFgP4F6L8DbunUVxPZ1j0WDw9qM8sbqURhGUe5-lNeWKRHdF5EITOOSusjfvpHQveUsVKuQnGlSRRLAyFa9NMsfj9gp9VP-84wwGERQl1tCIqpP2ieX9wD23Wht3ynycuRbXwvJZrPFsLfh8_BKewKiYlN1Db8fdqmfc6XrrezxYA_6vl64McepCCjwiTbbVaJsRllLpZfQlOs4DuiZa-xTv5h5ct8KXZen-FKQaP830OD1x3tTGCQ3UyxEOo7TaTPX6G_L1YIvmjcC3zup9I5H7dKdKfJehEuFCS1mQXUOlLye6-FD8qQ_POe2OdQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNANNCX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNANNCX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


module 0xd7e38b2097bb842be8287f4a30f63e6231f7e42c7c15f401ec4126c870756f4e::gtvanssui {
    struct GTVANSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVANSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVANSSUI>(arg0, 9, 0x1::string::utf8(b"GTVANSSUI"), 0x1::string::utf8(b"Van"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/cyf9f0L6vXy3LfQa3bd7obrOFFdElUfgZLdkBs5yMRBbKbMp0Y1_Wjeb3jW7qNvK9Cyz07RitN2JeZDeojce01NWbOSLOVDeog6Dj_SUtiLyBnJcLNj0Njn1-ShM-x7ZP3NO4OWsrDTjP3VATBfjPIOGVwe5GLlksKfr40Adw0Z8Lvkv4diQyKuA5ExaPguoKimv7PyC7miT6twroeMeOPElfYu2KfJTgLF3ub0uja3GjcDdRA_H9Qg4LWH-SkZgu-O49lqCr6jHg1DDikcsQeEKTv3INLRhjfW2splePjk7r73ghlmoODOJCr-hSUN8_F7yW8uKBaOr2PSSppnSlw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVANSSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVANSSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


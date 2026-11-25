module 0x1c8e67168f0320e3e622bc30dd9f75d90640787bae98a217787df3f8f154a4e3::gtjoybaear {
    struct GTJOYBAEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJOYBAEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJOYBAEAR>(arg0, 9, 0x1::string::utf8(b"GTJOYBAEAR"), 0x1::string::utf8(b"Justjoy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/I2117b4IYi6Or1VTwBCKwRLq_LLOztK6rfXOSO8_ZLzSkU_K4EX8KKqYaAMBdt27-B1NiRjIG3wZc8vlWBbfMDrHptbyKvyJ6UJwl0VmIvWaRqZvYu__EffdAXfOAD0eYC0d-vyFPbARhTsK8wexkQmLV8Ka59io6T9zME865GwJWtw2zbz8JfIWNemW0cZd7ZucDlUucA-LyADj9HRFwYnYf2sg5RiYjBQKtdI77vgTRJNA8YdSJHd9VVSEttLXCqpRPfXdFBQC427IKoHSHQITY2zxVg_XQsfhwKC_nbSlXN4V_Xgg5MLQib0hdgCSB1MSmEmBy4pL8Z3OhmXwJA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJOYBAEAR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJOYBAEAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


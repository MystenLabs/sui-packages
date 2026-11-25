module 0xe492b01cfeb9a7fe5e79d4045494bb67663f3ae1127f47639a1ddda05c528465::gtneotub {
    struct GTNEOTUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNEOTUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNEOTUB>(arg0, 9, 0x1::string::utf8(b"GTNEOTUB"), 0x1::string::utf8(x"4a6f73c3a92052"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/CrpzH4g41JL2pZeRuqRYr8grpqbP5uMcYW5KNt_UZajerE5YAIgkCDKtJ0gWGbbhOPWlQc_8WXCHkz10oqBs0XzCYnR3NUaRch53uducWgNmFnQM9eASUjYegEibFz_2kDVumli4fp-q7E5slDABmdtkkNMYE5MmR_S7zwBdl_d1s7vNmYIt-jSxFT3hwRomAn7SidaMQ4uSuizdUMCxacHe6EmcM8NixeQntPc-b46VzsyKbAJ04R4VfbZ2GuAzYnGJLgXdJqpLzK3oN_EDbmDHKsq-n1PjaqIxrjwUFg_Jh7rv1Z80ihtPNEdmwz7VQVN1qFIKLAFUQV51zevE8w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNEOTUB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNEOTUB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


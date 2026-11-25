module 0x15ec6489955c940be8bc1de3bee52d478e663163f2efbb8438c26ac92d46453c::gtworldofa {
    struct GTWORLDOFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWORLDOFA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWORLDOFA>(arg0, 9, 0x1::string::utf8(b"GTWORLDOFA"), 0x1::string::utf8(b"Armon Anderson"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/hAPkbWNH1jjenk19aVZYIcuH5yukkbofr49Wm3_2HOKVG7U0lhRVZyyASTYXIK1du9wQ6HE_WAFhJ7fgyFyEgEViNrwJbESquLfiIACdL25PPl6jt8Yr7yEx-dWHupTgnZ7u66lntJcUyez4JDpYTguA6_0ZOCf9tj0Obyrn-CYbI2drRY4iGL1B09E63_M6shTsVDPbTY6pJ_ZTYRA8HL7qmJR3vwKQ6Sg5uvPODJ_TPtyRSnufDr3tkEd6nNF7fRiwczy42j-ZZZ3M1ZbXxmO3MjAV5lOpJm-TEK0nKndr9UmO0ZEd3__mQgpPE8qGAYJ9OEROiEzzcWYyQNOVfg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWORLDOFA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWORLDOFA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


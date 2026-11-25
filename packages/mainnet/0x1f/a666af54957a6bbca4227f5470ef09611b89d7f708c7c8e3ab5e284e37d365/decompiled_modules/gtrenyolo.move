module 0x1fa666af54957a6bbca4227f5470ef09611b89d7f708c7c8e3ab5e284e37d365::gtrenyolo {
    struct GTRENYOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRENYOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRENYOLO>(arg0, 9, 0x1::string::utf8(b"GTRENYOLO"), 0x1::string::utf8(b"Ren Yolo"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/XxnBsGSYxvS7rzpC-CBto3imrwXaNlvqq2szmUqEttf2sZW9MJlZWnB6s88evNYYYZCz44XsCcVN6AQxq-ocSdQFhCPRGfoELaaBjFqF3f0AJOSmHrLCWCGnT59pHfqWjDlz83Q7aH8qBAzK9zSB4bAhns0ADu1gDUuUZcEjHElBIep3_QvZEkcHj-UGhVr8Ve0x7I6hhVFbzF63_KHfSmK8188kLAVQ7-Vfm47ufwQOBgFxTVZ-IZw7hsuGTk6qlYn-7-4yPNocIvHtFC1BWT0Kf5uZr5Q7vbD8whqbazRclFcSJjKU2RIB2PED6FJVlae2wSQ3-p1DmvkloENFzw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRENYOLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRENYOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


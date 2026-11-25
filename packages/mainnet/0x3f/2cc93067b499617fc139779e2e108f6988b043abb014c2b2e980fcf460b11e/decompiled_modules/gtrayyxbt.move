module 0x3f2cc93067b499617fc139779e2e108f6988b043abb014c2b2e980fcf460b11e::gtrayyxbt {
    struct GTRAYYXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRAYYXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRAYYXBT>(arg0, 9, 0x1::string::utf8(b"GTRAYYXBT"), 0x1::string::utf8(b"Krayy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ov0IJDXJUrVH6KDjAwhuGS5rOueyLOOro_HQwJ5DU4Y7yXA12l3FET6rxHJjoz7A23LmpUdIudiDmv703oF_3LhOZpLaX7kO17VxHOTMl75AIDTAM_k3tVf-Vq-xWvrGvUFvQKv4tMEs-jHJRaspnau9U1K74W_nInn9AWQ-GLIZMNrByc2VN_XyMGln9OFkZbz2TWvpV7wKRdVIP4SNuq_mQUBbBev8mPeqZxJBslB6VX45D-L3bUkSZjHpmrj4eNT-M6jrmBBub8SFg4OjmTr_N7iHLDj3JUwvugdjb1YPuTrk851uPmqV-clsOXEUUlOJVbmLo7BPf4lkFaljgQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRAYYXBT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRAYYXBT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


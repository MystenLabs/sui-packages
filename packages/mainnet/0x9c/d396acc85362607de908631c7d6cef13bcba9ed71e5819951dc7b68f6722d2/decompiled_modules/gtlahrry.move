module 0x9cd396acc85362607de908631c7d6cef13bcba9ed71e5819951dc7b68f6722d2::gtlahrry {
    struct GTLAHRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLAHRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLAHRRY>(arg0, 9, 0x1::string::utf8(b"GTLAHRRY"), 0x1::string::utf8(b"Lahrry"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iq0oiudHRaVe7L4goJUXAqERQe__ku8DOql9gbA-nLuQ0egSutd4TbktanqpLKpxy0jwCPjECh0ttPQFQhzXANmrxgM3w93Ig3JNR880MaIuKWV8iotnRS_6qBpxSiNqf8p9Q-8Xd9DG4AnMDdwKzlSoHbC4PRFaD_vcd7rhVfFQXQEPduj8n4zIiPbP8-c15bAMT6svCL3OyI4u11zUflC2kVInFKVBBD3mzAgw-tPzR7GzMfx7oV6QNUzQI_HfSSNIA-6YIdBL059jYo9vyiiJdF5U4TwzHrPa6k8jW80g3SUei5Er5rHXYwUr-pji1piQeP5N86-ZUnAwAvvCTQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLAHRRY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLAHRRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


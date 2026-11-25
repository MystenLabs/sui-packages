module 0x7d6d1654fef135f48d7a1a150b408d6cbfd1d452ce91fbe00e22f95d3c587609::gtblackcle {
    struct GTBLACKCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBLACKCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBLACKCLE>(arg0, 9, 0x1::string::utf8(b"GTBLACKCLE"), 0x1::string::utf8(b"Blackclef"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/CAypexb_oQTi5mn2WURaqUuvMsrhbnyKNQDNk7marzImlqyhKnfGzNHE13JtOMLM9cOhDSrRsnd1EKhhrBT-2bvymZj4L_td-P101WLpcQYKyC1ZhuKt85opNbNVDh81XEN66ZlhsGGG6O0I1MFOet7AKZXrekDKA1cpDx_BPDSfyuLQ2g2EXX4Cisvxe0gTQFi7NrvMWSQLJTxYgWPok3hOuvU1gRKwSGU6z1sBOjplaLQ72O1bhd8zzc37GgZBu7F8W2TYLpuQliczlQywSp66CNlJ7K27TK9EUDXbyrDu1bOgs38DLSxvACbWGujY3Ih48wFspzD4glz3_m0H0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBLACKCLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBLACKCLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


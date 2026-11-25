module 0xaef52a290a0351295bcda3b5e31f0890e9a333b8a20ee90acbb47a7006973c05::gttoadzie {
    struct GTTOADZIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTOADZIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTOADZIE>(arg0, 9, 0x1::string::utf8(b"GTTOADZIE"), 0x1::string::utf8(b"Toadz"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/WOXFp5wkLoYWaIPIWztJ6imMku2iZi0MYoJ0LO-QlNnq2R3StTzH54zy4Eb1xGBMgu48u8zfkhvdyUVVERXG5BF23KG1-h9V0rRTFsrtnlGHi5BGpg4QxxyAiKw6OEMVDFrGCVuk1-l6_1Rdl31e2tSEHZfs-bC1hLtW72tH9iQVe2sNiK8lbMlhA17JGoH7vtXYRVAqmWjHGCMuEPWHQKGFIDL0DIam8237Kvu4GvDzor9aorThaNkTJtsUNZ6aVI566py_i6sWJnNxfYKwppzF5sd2zZdwZnvYXHahRHnRXYG7XRspUYdUh0u-h6q_IPRYSwUz22SN6PRax83FaQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTOADZIE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTOADZIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


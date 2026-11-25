module 0xce981d6547e8b5371a679740378cc5e2b4d73d6196f8d0f72b018f6c215147e2::gtwisearic {
    struct GTWISEARIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWISEARIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWISEARIC>(arg0, 9, 0x1::string::utf8(b"GTWISEARIC"), 0x1::string::utf8(b"Wise"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/hsg5IsDq1hYFvr-GDqpkoQC-rGQo7Dpxs9pV4cxUDxlt4QXKZ1k0_EdYKY3owIg8nejXRv0ew1hWT7IzaLru9KEvl2c0CMQsy45Ai6TXILIL6R8wul_BXZUBkAvha7M3053SzgKYztpUjNIAlHLlcfT58GgUn4oLxk6eI8lB5XjdNOW0sgRP1eHA8XyuA0BG8S2m1aZ9XEkaPWP8K863PBEl-1QVIg7qr2JEP_4XX4WO1eOGOHKDXdfsmDpa3582dQyv5-gcti_-FPn5ZJySDMDaU1_9kg4eg3CFsyUpuA9684H6RvWm3sQY-UFKf0tiDYQLKps4RgrIzMwjXVErfg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWISEARIC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWISEARIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


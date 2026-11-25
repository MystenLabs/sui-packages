module 0xa69731f132fea60f3b32193b2b60d1f7619baa565802ff330b32ad9270fefd10::gtrachmats {
    struct GTRACHMATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRACHMATS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRACHMATS>(arg0, 9, 0x1::string::utf8(b"GTRACHMATS"), 0x1::string::utf8(b"rachmat setiawan"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/s4HLNvo0E7FXed-ES1ZLMlEg2XgvmhgZTOfXszFTOHxGFFHlAMjDmcZkYKADxMM4OSmhfCB0z2VukTimZEshydYHmbGf5KslscVORVw7phCd2_EOH_it0aJLV1NECjqbIbHYOdBcnLvLFZfx199pgCK4Vhpgy42mK3dWN02Jj0j7BuvVPZ2uq8SaEeyfJtzlBSvRplwiS0JpYYTLEpwUJXe_F4K7QW_1YQhNT4zbBGPCuL7qJPFNFsd2BAozoqRv8loTzSHcWkBXMexAQJXs2YkqOWuTOGnSPdsB2kpinnxvY2GkW02EwXGb-5od1HB8GKN7soNJf8JO7P70gsehmw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRACHMATS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRACHMATS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


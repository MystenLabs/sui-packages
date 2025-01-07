module 0x96bcd0cdd0e5184bd2cc4ebfceede65e08b5825cc98af2269c9259033fb191c2::turbos_nft {
    struct TURBOS_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TurbosPitCrewPass has store, key {
        id: 0x2::object::UID,
    }

    struct TurbosRacerPass has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_mint_pit_crew_pass(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosPitCrewPass{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<TurbosPitCrewPass>(v0, arg1);
    }

    public fun admin_mint_racer_pass(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosRacerPass{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<TurbosRacerPass>(v0, arg1);
    }

    fun init(arg0: TURBOS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TURBOS_NFT>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x2::display::new<TurbosPitCrewPass>(&v0, arg1);
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Turbos Sui Basecamp Pit Crew Pass"));
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Turbos Sui Basecamp Pit Crew Pass"));
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://app.turbos.finance/icon/pit-crew-pass.png"));
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.turbos.finance/#/prix"));
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Turbos Finance"));
        0x2::display::add<TurbosPitCrewPass>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://turbos.finance"));
        0x2::display::update_version<TurbosPitCrewPass>(&mut v2);
        let v3 = 0x2::display::new<TurbosRacerPass>(&v0, arg1);
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Turbos Sui Basecamp Racer Pass"));
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Turbos Sui Basecamp Racer Pass"));
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://app.turbos.finance/icon/basecamp-racer-pass.png"));
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.turbos.finance/#/prix"));
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Turbos Finance"));
        0x2::display::add<TurbosRacerPass>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://turbos.finance"));
        0x2::display::update_version<TurbosRacerPass>(&mut v3);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TurbosPitCrewPass>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TurbosRacerPass>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


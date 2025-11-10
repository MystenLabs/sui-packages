module 0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::guess {
    struct HopGuess has key {
        id: 0x2::object::UID,
        number: u64,
        timestamp: u64,
        launch_guess: 0x1::string::String,
    }

    struct GUESS has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &HopGuess) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: GUESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"launch_guess"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Hop Guess #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://bafybeiablijjareh2xhmck5dwco2vvf2h6pzi6ruw2rmmzlpv6oqobstem"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"We are building the future of Internet Capital Markets on Sui."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{launch_guess}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hop.ag"));
        let v4 = 0x2::package::claim<GUESS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HopGuess>(&v4, v0, v2, arg1);
        0x2::display::update_version<HopGuess>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HopGuess>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun launch_guess(arg0: &HopGuess) : 0x1::string::String {
        arg0.launch_guess
    }

    public fun mint(arg0: &mut 0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::MintState, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::enforce_version(arg0);
        0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::enforce_minting_enabled(arg0);
        0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::enforce_supply_available(arg0);
        let v0 = HopGuess{
            id           : 0x2::object::new(arg3),
            number       : 0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::current_number(arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
            launch_guess : arg1,
        };
        0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state::decrease_supply(arg0);
        0x2::transfer::transfer<HopGuess>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun number(arg0: &HopGuess) : u64 {
        arg0.number
    }

    public fun timestamp(arg0: &HopGuess) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}


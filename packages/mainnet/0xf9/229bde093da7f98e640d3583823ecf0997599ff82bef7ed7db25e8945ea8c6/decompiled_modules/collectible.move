module 0xf9229bde093da7f98e640d3583823ecf0997599ff82bef7ed7db25e8945ea8c6::collectible {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        started_at_ms: u64,
        ended_at_ms: u64,
        whitelist: 0x2::table::Table<address, bool>,
        total_supply: u64,
    }

    struct Token has key {
        id: 0x2::object::UID,
    }

    struct Mint has copy, drop {
        token_id: 0x2::object::ID,
        sender: address,
    }

    struct COLLECTIBLE has drop {
        dummy_field: bool,
    }

    public entry fun grant_whitelist(arg0: &AdminCap, arg1: &mut State, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.whitelist, *v1)) {
                0x2::table::add<address, bool>(&mut arg1.whitelist, *v1, false);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: COLLECTIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTIBLE>(arg0, arg1);
        let v1 = 0x2::display::new<Token>(&v0, arg1);
        0x2::display::add<Token>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"FlowX Genesis Pass"));
        0x2::display::add<Token>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://bafybeickw4qousokdxuodqr7s6sibztn5ugzodvq6srmhomg2h3ctayyee"));
        0x2::display::add<Token>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Certification for individuals participating in the GenesiX Farming program offered by FlowX Finance. The certification is non-transferable and cannot be exchanged."));
        0x2::display::update_version<Token>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Token>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = State{
            id            : 0x2::object::new(arg1),
            started_at_ms : 1696575600000,
            ended_at_ms   : 1699254000000,
            whitelist     : 0x2::table::new<address, bool>(arg1),
            total_supply  : 0,
        };
        0x2::transfer::share_object<State>(v3);
    }

    public entry fun mint(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.started_at_ms, 4);
        assert!(arg0.ended_at_ms > 0x2::clock::timestamp_ms(arg1), 6);
        assert!(arg0.total_supply < 200, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 1);
        assert!(!*0x2::table::borrow<address, bool>(&arg0.whitelist, v0), 2);
        arg0.total_supply = arg0.total_supply + 1;
        set_minted(arg0, v0);
        let v1 = Token{id: 0x2::object::new(arg2)};
        let v2 = Mint{
            token_id : 0x2::object::id<Token>(&v1),
            sender   : v0,
        };
        0x2::event::emit<Mint>(v2);
        0x2::transfer::transfer<Token>(v1, v0);
    }

    public entry fun revoke_whitelist(arg0: &AdminCap, arg1: &mut State, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            assert!(0x2::table::contains<address, bool>(&arg1.whitelist, *v1), 1);
            0x2::table::remove<address, bool>(&mut arg1.whitelist, *v1);
            v0 = v0 + 1;
        };
    }

    public entry fun set_end_time(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.ended_at_ms == 0 || arg1.ended_at_ms > 0x2::clock::timestamp_ms(arg3), 6);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3) && arg2 > arg1.started_at_ms, 3);
        arg1.ended_at_ms = arg2;
    }

    fun set_minted(arg0: &mut State, arg1: address) {
        *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, arg1) = true;
    }

    public entry fun set_start_time(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.started_at_ms == 0 || arg1.started_at_ms > 0x2::clock::timestamp_ms(arg3), 5);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 3);
        arg1.started_at_ms = arg2;
    }

    // decompiled from Move bytecode v6
}


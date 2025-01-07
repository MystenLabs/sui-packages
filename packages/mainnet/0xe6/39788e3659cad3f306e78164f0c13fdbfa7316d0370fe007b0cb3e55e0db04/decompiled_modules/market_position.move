module 0xe639788e3659cad3f306e78164f0c13fdbfa7316d0370fe007b0cb3e55e0db04::market_position {
    struct MarketPosition has store, key {
        id: 0x2::object::UID,
        market_state_id: 0x2::object::ID,
        expiry: u64,
        yield_token: 0x1::string::String,
        name: 0x1::string::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        lp_amount: u64,
    }

    struct MARKET_POSITION has drop {
        dummy_field: bool,
    }

    public fun decrease_lp_amount(arg0: &mut MarketPosition, arg1: u64) {
        arg0.lp_amount = arg0.lp_amount - arg1;
    }

    public fun increase_lp_amount(arg0: &mut MarketPosition, arg1: u64) {
        arg0.lp_amount = arg0.lp_amount + arg1;
    }

    fun init(arg0: MARKET_POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKET_POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<MarketPosition>(&v0, arg1);
        0x2::display::add<MarketPosition>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Nemo LP | {yield_token} Pool {expiry}"));
        0x2::display::add<MarketPosition>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Nemo Liquidity Position"));
        0x2::display::add<MarketPosition>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.nemoprotocol.com"));
        0x2::display::add<MarketPosition>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://app.nemoprotocol.com/api/v1/img/lp?objectId={id}"));
        0x2::display::update_version<MarketPosition>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MarketPosition>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun join(arg0: &mut MarketPosition, arg1: MarketPosition, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(market_state_id(arg0) == market_state_id(&arg1), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::market_invalid_market_position());
        increase_lp_amount(arg0, lp_amount(&arg1));
        let MarketPosition {
            id              : v0,
            market_state_id : _,
            expiry          : _,
            yield_token     : _,
            name            : _,
            url             : _,
            description     : _,
            lp_amount       : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun lp_amount(arg0: &MarketPosition) : u64 {
        arg0.lp_amount
    }

    public fun market_state_id(arg0: &MarketPosition) : 0x2::object::ID {
        arg0.market_state_id
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : MarketPosition {
        MarketPosition{
            id              : 0x2::object::new(arg3),
            market_state_id : arg0,
            expiry          : arg2,
            yield_token     : arg1,
            name            : 0x1::string::utf8(b"Nemo LP"),
            url             : 0x1::string::utf8(b""),
            description     : 0x1::string::utf8(b"Nemo Liquidity Position"),
            lp_amount       : 0,
        }
    }

    public fun set_lp_amount(arg0: &mut MarketPosition, arg1: u64) {
        arg0.lp_amount = arg1;
    }

    // decompiled from Move bytecode v6
}


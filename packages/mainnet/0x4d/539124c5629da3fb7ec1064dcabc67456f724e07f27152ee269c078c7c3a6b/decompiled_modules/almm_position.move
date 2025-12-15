module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        shares: 0x2::table::Table<u32, u64>,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: vector<u32>, arg2: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id      : 0x2::object::new(arg2),
            pair_id : arg0,
            bin_ids : arg1,
            shares  : 0x2::table::new<u32, u64>(arg2),
        }
    }

    public(friend) fun decrease_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.shares, arg1)
        } else {
            0
        };
        assert!(v0 >= arg2, 1);
        0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v0 - arg2);
    }

    public(friend) fun destroy(arg0: Position) {
        let Position {
            id      : v0,
            pair_id : _,
            bin_ids : _,
            shares  : v3,
        } = arg0;
        0x2::table::drop<u32, u64>(v3);
        0x2::object::delete(v0);
    }

    public fun ids(arg0: &Position) : &vector<u32> {
        &arg0.bin_ids
    }

    public(friend) fun increase_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.shares, arg1)
        } else {
            0
        };
        0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v0 + arg2);
    }

    public fun info(arg0: &Position) : (0x2::object::ID, &vector<u32>, &0x2::table::Table<u32, u64>) {
        (pair_id(arg0), ids(arg0), shares(arg0))
    }

    public fun pair_id(arg0: &Position) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun shares(arg0: &Position) : &0x2::table::Table<u32, u64> {
        &arg0.shares
    }

    public(friend) fun shrink(arg0: &mut Position, arg1: u32, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<u32>(&arg0.bin_ids, &arg1);
        assert!(v0, 13906834427746451455);
        assert!(*0x2::table::borrow<u32, u64>(&arg0.shares, arg1) >= arg2, 13906834432041418751);
        let v2 = 0x2::table::remove<u32, u64>(&mut arg0.shares, arg1);
        if (v2 == arg2) {
            0x1::vector::remove<u32>(&mut arg0.bin_ids, v1);
        } else {
            0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v2 - arg2);
        };
    }

    public fun update_display(arg0: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg0);
        assert!(0x2::package::from_module<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 13906834487875993599);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"pair_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{pair_id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.magmafinance.io/dashboard/almmposition?id={id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Magma ALMM Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://magmafinance.io"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"MAGMA"));
        let v2 = 0x2::display::new_with_fields<Position>(arg1, v0, v1, arg2);
        0x2::display::update_version<Position>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


module 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        bin_start: u32,
        bin_count: u32,
        shares: vector<u64>,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &vector<u32>, arg2: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        Position{
            id        : 0x2::object::new(arg2),
            pair_id   : arg0,
            bin_start : *0x1::vector::borrow<u32>(arg1, 0),
            bin_count : (0x1::vector::length<u32>(arg1) as u32),
            shares    : v0,
        }
    }

    public(friend) fun decrease_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 2);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.shares, get_bin_idx(arg0, arg1));
        assert!(*v0 >= arg2, 1);
        *v0 = *v0 - arg2;
    }

    public(friend) fun destroy(arg0: Position) {
        let Position {
            id        : v0,
            pair_id   : _,
            bin_start : _,
            bin_count : _,
            shares    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_bin_idx(arg0: &Position, arg1: u32) : u64 {
        ((arg1 - arg0.bin_start) as u64)
    }

    fun has_bin_id(arg0: &Position, arg1: u32) : bool {
        arg1 >= arg0.bin_start && arg0.bin_start + arg0.bin_count > arg1
    }

    public fun ids(arg0: &Position) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < arg0.bin_count) {
            0x1::vector::push_back<u32>(&mut v0, arg0.bin_start + v1);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun increase_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 2);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.shares, get_bin_idx(arg0, arg1));
        *v0 = *v0 + arg2;
    }

    public fun info(arg0: &Position) : (0x2::object::ID, vector<u32>, 0x2::vec_map::VecMap<u32, u64>) {
        (pair_id(arg0), ids(arg0), shares(arg0))
    }

    public fun pair_id(arg0: &Position) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun shares(arg0: &Position) : 0x2::vec_map::VecMap<u32, u64> {
        let v0 = 0x2::vec_map::empty<u32, u64>();
        let v1 = 0;
        while (v1 < arg0.bin_count) {
            0x2::vec_map::insert<u32, u64>(&mut v0, arg0.bin_start + v1, *0x1::vector::borrow<u64>(&arg0.shares, (v1 as u64)));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun shrink(arg0: &mut Position, arg1: u32, arg2: u64) {
        assert!(has_bin_id(arg0, arg1), 2);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.shares, get_bin_idx(arg0, arg1));
        assert!(*v0 >= arg2, 13906834539415601151);
        *v0 = *v0 - arg2;
    }

    public fun update_display(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::version_only(arg0);
        assert!(0x2::package::from_module<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory>(arg1), 13906834621019979775);
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


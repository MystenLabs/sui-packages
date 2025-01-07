module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        supply: 0x1::option::Option<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>,
    }

    public fun new<T0: drop, T1>(arg0: &T0, arg1: 0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : MintCap<T1> {
        if (0x1::option::is_some<u64>(&arg2)) {
            new_limited<T0, T1>(arg0, arg1, 0x1::option::destroy_some<u64>(arg2), arg3)
        } else {
            new_unlimited<T0, T1>(arg0, arg1, arg3)
        }
    }

    public fun new_display<T0: store + key>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::frozen_publisher::FrozenPublisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<MintCap<T0>> {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::frozen_publisher::new_display<Witness, MintCap<T0>>(v0, arg1, arg2);
        0x2::display::add<MintCap<T0>>(&mut v1, 0x1::string::utf8(b"type"), 0x1::string::utf8(b"MintCap"));
        v1
    }

    public fun assert_limited<T0>(arg0: &MintCap<T0>) {
        assert!(0x1::option::is_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply), 1);
    }

    public fun assert_unlimited<T0>(arg0: &MintCap<T0>) {
        assert!(0x1::option::is_none<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply), 2);
    }

    public fun borrow_supply<T0>(arg0: &MintCap<T0>) : &0x1::option::Option<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply> {
        &arg0.supply
    }

    public fun collection_id<T0>(arg0: &MintCap<T0>) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun delete_mint_cap<T0>(arg0: MintCap<T0>) {
        let MintCap {
            id            : v0,
            collection_id : _,
            supply        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_supply<T0>(arg0: &MintCap<T0>) : &0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply {
        assert_limited<T0>(arg0);
        0x1::option::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply)
    }

    public fun has_supply<T0>(arg0: &MintCap<T0>) : bool {
        0x1::option::is_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply)
    }

    public fun increment_supply<T0>(arg0: &mut MintCap<T0>, arg1: u64) {
        if (0x1::option::is_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply)) {
            0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::increment(0x1::option::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&mut arg0.supply), arg1);
        };
    }

    public fun merge<T0>(arg0: &mut MintCap<T0>, arg1: MintCap<T0>) {
        let MintCap {
            id            : v0,
            collection_id : _,
            supply        : v2,
        } = arg1;
        let v3 = v2;
        if (0x1::option::is_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&v3) && 0x1::option::is_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply)) {
            0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::merge(0x1::option::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&mut arg0.supply), 0x1::option::destroy_some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(v3));
        };
        0x2::object::delete(v0);
    }

    public fun new_limited<T0: drop, T1>(arg0: &T0, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : MintCap<T1> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::assert_same_module<T0, T1>();
        MintCap<T1>{
            id            : 0x2::object::new(arg3),
            collection_id : arg1,
            supply        : 0x1::option::some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::new(arg2)),
        }
    }

    public fun new_unlimited<T0: drop, T1>(arg0: &T0, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : MintCap<T1> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::assert_same_module<T0, T1>();
        MintCap<T1>{
            id            : 0x2::object::new(arg2),
            collection_id : arg1,
            supply        : 0x1::option::none<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(),
        }
    }

    public fun split<T0>(arg0: &mut MintCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap<T0> {
        let v0 = if (has_supply<T0>(arg0)) {
            0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::split(0x1::option::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&mut arg0.supply), arg1)
        } else {
            0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::new(arg1)
        };
        MintCap<T0>{
            id            : 0x2::object::new(arg2),
            collection_id : arg0.collection_id,
            supply        : 0x1::option::some<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(v0),
        }
    }

    public fun supply<T0>(arg0: &MintCap<T0>) : u64 {
        assert_limited<T0>(arg0);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::get_current(0x1::option::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply>(&arg0.supply))
    }

    // decompiled from Move bytecode v6
}


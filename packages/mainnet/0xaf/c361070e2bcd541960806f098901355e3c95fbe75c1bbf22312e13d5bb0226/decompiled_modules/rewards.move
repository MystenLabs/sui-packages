module 0xafc361070e2bcd541960806f098901355e3c95fbe75c1bbf22312e13d5bb0226::rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Tally has copy, drop, store {
        day: u64,
        used: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        rewards: 0x2::balance::Balance<T0>,
        rate: u64,
        max_reward: u64,
        builder_code: 0x2::object::ID,
        per_day: u64,
        claimed: 0x2::table::Table<u256, bool>,
        tallies: 0x2::table::Table<address, Tally>,
        paused: bool,
        total_paid: u64,
        claims: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        builder_code: 0x2::object::ID,
        rate: u64,
        max_reward: u64,
        per_day: u64,
    }

    struct Funded has copy, drop {
        vault: 0x2::object::ID,
        who: address,
        amount: u64,
        pot: u64,
    }

    struct Claimed has copy, drop {
        vault: 0x2::object::ID,
        who: address,
        order_id: u256,
        value: u64,
        amount: u64,
        pot: u64,
    }

    struct ConfigSet has copy, drop {
        vault: 0x2::object::ID,
        rate: u64,
        max_reward: u64,
        per_day: u64,
        paused: bool,
    }

    struct Drained has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    public fun builder_code<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.builder_code
    }

    public fun claim<T0>(arg0: &mut Vault<T0>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg8: u256, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(arg1) == 0x2::tx_context::sender(arg10), 11);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && 0x1::option::borrow<0x2::object::ID>(&v0) == &arg0.builder_code, 3);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::has_position(arg1, 0x2::object::id<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket>(arg2), arg8), 4);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::load_live_pricer(arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        pay<T0>(arg0, arg8, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::live_order_value(arg2, &v1, arg8), arg9, arg10)
    }

    public fun claimed_order<T0>(arg0: &Vault<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.claimed, arg1)
    }

    public fun claims<T0>(arg0: &Vault<T0>) : u64 {
        arg0.claims
    }

    public fun create<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        let v1 = Vault<T0>{
            id           : 0x2::object::new(arg4),
            version      : 1,
            rewards      : 0x2::balance::zero<T0>(),
            rate         : arg1,
            max_reward   : arg2,
            builder_code : arg0,
            per_day      : arg3,
            claimed      : 0x2::table::new<u256, bool>(arg4),
            tallies      : 0x2::table::new<address, Tally>(arg4),
            paused       : false,
            total_paid   : 0,
            claims       : 0,
        };
        let v2 = 0x2::object::id<Vault<T0>>(&v1);
        let v3 = VaultCreated{
            vault        : v2,
            builder_code : arg0,
            rate         : arg1,
            max_reward   : arg2,
            per_day      : arg3,
        };
        0x2::event::emit<VaultCreated>(v3);
        0x2::transfer::share_object<Vault<T0>>(v1);
        AdminCap{
            id    : 0x2::object::new(arg4),
            vault : v2,
        }
    }

    public fun drain<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault == 0x2::object::id<Vault<T0>>(arg0), 8);
        let v0 = if (arg2 == 0 || arg2 > 0x2::balance::value<T0>(&arg0.rewards)) {
            0x2::balance::value<T0>(&arg0.rewards)
        } else {
            arg2
        };
        let v1 = Drained{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            amount : v0,
        };
        0x2::event::emit<Drained>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, v0), arg3)
    }

    public fun fund<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        0x2::balance::join<T0>(&mut arg0.rewards, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Funded{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            who    : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
            pot    : 0x2::balance::value<T0>(&arg0.rewards),
        };
        0x2::event::emit<Funded>(v0);
    }

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.paused
    }

    public fun max_reward<T0>(arg0: &Vault<T0>) : u64 {
        arg0.max_reward
    }

    fun pay<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x2::table::contains<u256, bool>(&arg0.claimed, arg1), 5);
        let v0 = (((arg2 as u128) * (arg0.rate as u128) / 1000000) as u64);
        let v1 = v0;
        if (v0 > arg0.max_reward) {
            v1 = arg0.max_reward;
        };
        assert!(v1 > 0, 10);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        if (0x2::table::contains<address, Tally>(&arg0.tallies, v2)) {
            let v4 = 0x2::table::borrow_mut<address, Tally>(&mut arg0.tallies, v2);
            if (v4.day == v3) {
                assert!(v4.used < arg0.per_day, 6);
                v4.used = v4.used + 1;
            } else {
                v4.day = v3;
                v4.used = 1;
            };
        } else {
            let v5 = Tally{
                day  : v3,
                used : 1,
            };
            0x2::table::add<address, Tally>(&mut arg0.tallies, v2, v5);
        };
        assert!(0x2::balance::value<T0>(&arg0.rewards) >= v1, 7);
        0x2::table::add<u256, bool>(&mut arg0.claimed, arg1, true);
        arg0.total_paid = arg0.total_paid + v1;
        arg0.claims = arg0.claims + 1;
        let v6 = Claimed{
            vault    : 0x2::object::id<Vault<T0>>(arg0),
            who      : v2,
            order_id : arg1,
            value    : arg2,
            amount   : v1,
            pot      : 0x2::balance::value<T0>(&arg0.rewards),
        };
        0x2::event::emit<Claimed>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, v1), arg4)
    }

    public fun per_day<T0>(arg0: &Vault<T0>) : u64 {
        arg0.per_day
    }

    public fun pot<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    public fun quote<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        let v0 = (((arg1 as u128) * (arg0.rate as u128) / 1000000) as u64);
        if (v0 > arg0.max_reward) {
            arg0.max_reward
        } else {
            v0
        }
    }

    public fun rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.rate
    }

    public fun remaining_today<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, Tally>(&arg0.tallies, arg1)) {
            return arg0.per_day
        };
        let v0 = 0x2::table::borrow<address, Tally>(&arg0.tallies, arg1);
        if (v0.day != 0x2::clock::timestamp_ms(arg2) / 86400000) {
            return arg0.per_day
        };
        if (v0.used >= arg0.per_day) {
            0
        } else {
            arg0.per_day - v0.used
        }
    }

    public fun set_config<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        assert!(arg1.vault == 0x2::object::id<Vault<T0>>(arg0), 8);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        arg0.rate = arg2;
        arg0.max_reward = arg3;
        arg0.per_day = arg4;
        arg0.paused = arg5;
        let v1 = ConfigSet{
            vault      : 0x2::object::id<Vault<T0>>(arg0),
            rate       : arg2,
            max_reward : arg3,
            per_day    : arg4,
            paused     : arg5,
        };
        0x2::event::emit<ConfigSet>(v1);
    }

    public fun total_paid<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_paid
    }

    // decompiled from Move bytecode v7
}


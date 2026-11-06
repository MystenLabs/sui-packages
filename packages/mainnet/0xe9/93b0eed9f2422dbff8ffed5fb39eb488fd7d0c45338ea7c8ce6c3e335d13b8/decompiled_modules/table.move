module 0xe993b0eed9f2422dbff8ffed5fb39eb488fd7d0c45338ea7c8ce6c3e335d13b8::table {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        dealer: vector<u8>,
        fee_bps: u64,
        to: vector<address>,
        parts: vector<u64>,
        paused: bool,
        revoked: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Table<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0x2::object::ID,
        host: address,
        dealer: vector<u8>,
        rules: vector<u8>,
        buy_in: u64,
        max_seats: u64,
        players: vector<address>,
        deposits: vector<u64>,
        rebuys: vector<u64>,
        seen: vector<address>,
        seq: u64,
        pot: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        state: u8,
        start_by_ms: u64,
        game_ms: u64,
        settle_by_ms: u64,
        rebuy_price: u64,
        max_rebuys: u64,
        rebuy_window_ms: u64,
        rebuy_until_ms: u64,
        nft_stake: 0x1::option::Option<0x1::type_name::TypeName>,
        nfts: vector<Nft>,
        prizes: u64,
        payees: vector<address>,
        owed: vector<u64>,
    }

    struct Nft has copy, drop, store {
        owner: address,
        kind: 0x1::type_name::TypeName,
        prize: bool,
        dest: 0x1::option::Option<address>,
        out: bool,
    }

    struct NftKey has copy, drop, store {
        i: u64,
    }

    struct ConfigChanged has copy, drop {
        dealer: vector<u8>,
        fee_bps: u64,
        to: vector<address>,
        parts: vector<u64>,
        paused: bool,
        revoked: u64,
    }

    struct Created has copy, drop {
        table: 0x2::object::ID,
        host: address,
        coin: 0x1::type_name::TypeName,
        buy_in: u64,
        max_seats: u64,
        fee_bps: u64,
        rebuy_price: u64,
        max_rebuys: u64,
        nft_stake: 0x1::option::Option<0x1::type_name::TypeName>,
        rules: vector<u8>,
    }

    struct Joined has copy, drop {
        table: 0x2::object::ID,
        player: address,
        seats: u64,
    }

    struct Left has copy, drop {
        table: 0x2::object::ID,
        player: address,
    }

    struct Started has copy, drop {
        table: 0x2::object::ID,
        players: vector<address>,
    }

    struct Rebought has copy, drop {
        table: 0x2::object::ID,
        player: address,
        n: u64,
        amount: u64,
    }

    struct NftIn has copy, drop {
        table: 0x2::object::ID,
        i: u64,
        owner: address,
        kind: 0x1::type_name::TypeName,
        prize: bool,
    }

    struct NftOut has copy, drop {
        table: 0x2::object::ID,
        i: u64,
        to: address,
    }

    struct Settled has copy, drop {
        table: 0x2::object::ID,
        winners: vector<address>,
        amounts: vector<u64>,
        fee: u64,
    }

    struct Refunded has copy, drop {
        table: 0x2::object::ID,
        players: vector<address>,
        amounts: vector<u64>,
        by_team: bool,
    }

    struct Claimed has copy, drop {
        table: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    public fun join<T0>(arg0: &mut Table<T0>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        bound<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.nft_stake), 21);
        check_permit<T0>(arg0, &arg3, 0x2::tx_context::sender(arg5));
        seat<T0>(arg0, arg2, arg4, arg5);
    }

    public fun add_prize<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        ok<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.host, 15);
        assert!(arg0.state == 0, 6);
        assert!(arg0.prizes < 20, 22);
        arg0.prizes = arg0.prizes + 1;
        put_nft<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg2), true);
    }

    fun add_rebuy<T0>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address) {
        let v0 = *0x1::vector::borrow<u64>(&arg0.rebuys, arg2);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        *0x1::vector::borrow_mut<u64>(&mut arg0.rebuys, arg2) = v0 + 1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.deposits, arg2) = *0x1::vector::borrow<u64>(&arg0.deposits, arg2) + arg0.rebuy_price;
        let v1 = Rebought{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            player : arg3,
            n      : v0,
            amount : arg0.rebuy_price,
        };
        0x2::event::emit<Rebought>(v1);
    }

    public fun admin_close<T0>(arg0: &AdminCap, arg1: &mut Table<T0>) {
        ok<T0>(arg1);
        assert!(arg1.state == 0 || arg1.state == 1, 17);
        pay_back<T0>(arg1, true);
    }

    fun begin<T0>(arg0: &mut Table<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.state = 1;
        arg0.settle_by_ms = v0 + arg0.game_ms;
        arg0.rebuy_until_ms = v0 + arg0.rebuy_window_ms;
        let v1 = Started{
            table   : 0x2::object::uid_to_inner(&arg0.id),
            players : arg0.players,
        };
        0x2::event::emit<Started>(v1);
    }

    fun bound<T0>(arg0: &Table<T0>, arg1: &Config) {
        ok<T0>(arg0);
        cfg_ok(arg1);
        assert!(0x2::object::id<Config>(arg1) == arg0.config, 26);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.revoked, arg0.dealer), 29);
    }

    public fun buy_in<T0>(arg0: &Table<T0>) : u64 {
        arg0.buy_in
    }

    public fun cancel<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        ok<T0>(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.host, 15);
        assert!(arg0.state == 0, 6);
        pay_back<T0>(arg0, false);
    }

    fun cfg_ok(arg0: &Config) {
        assert!(arg0.version == 1, 28);
    }

    fun changed(arg0: &Config) {
        let v0 = ConfigChanged{
            dealer  : arg0.dealer,
            fee_bps : arg0.fee_bps,
            to      : arg0.to,
            parts   : arg0.parts,
            paused  : arg0.paused,
            revoked : 0x2::table::length<vector<u8>, bool>(&arg0.revoked),
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    fun check_permit<T0>(arg0: &Table<T0>, arg1: &vector<u8>, arg2: address) {
        let v0 = join_message(0x2::object::uid_to_bytes(&arg0.id), arg2);
        assert!(0x2::ed25519::ed25519_verify(arg1, &arg0.dealer, &v0), 12);
    }

    public fun claim<T0>(arg0: &mut Table<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        ok<T0>(arg0);
        assert!(arg0.state == 2 || arg0.state == 3, 11);
        assert!(arg1 < 0x1::vector::length<u64>(&arg0.owed) && *0x1::vector::borrow<u64>(&arg0.owed, arg1) > 0, 30);
        let v0 = *0x1::vector::borrow<u64>(&arg0.owed, arg1);
        let v1 = *0x1::vector::borrow<address>(&arg0.payees, arg1);
        *0x1::vector::borrow_mut<u64>(&mut arg0.owed, arg1) = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v0, arg2), v1);
        let v2 = Claimed{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            to     : v1,
            amount : v0,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun config_dealer(arg0: &Config) : vector<u8> {
        arg0.dealer
    }

    public fun config_fee(arg0: &Config) : (u64, vector<address>, vector<u64>) {
        (arg0.fee_bps, arg0.to, arg0.parts)
    }

    public fun config_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun create<T0>(arg0: &Config, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        new_table<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0x1::type_name::TypeName>(), arg9, arg10);
    }

    public fun create_with_stake<T0, T1: store + key>(arg0: &Config, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!is_coin(&v0), 32);
        new_table<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<0x1::type_name::TypeName>(v0), arg9, arg10);
    }

    fun credit<T0>(arg0: &mut Table<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.payees, &arg1);
        if (v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.owed, v1) = *0x1::vector::borrow<u64>(&arg0.owed, v1) + arg2;
        } else {
            0x1::vector::push_back<address>(&mut arg0.payees, arg1);
            0x1::vector::push_back<u64>(&mut arg0.owed, arg2);
        };
    }

    public fun deposits<T0>(arg0: &Table<T0>) : vector<u64> {
        arg0.deposits
    }

    public fun fee_bps<T0>(arg0: &Table<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fee_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun host<T0>(arg0: &Table<T0>) : address {
        arg0.host
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 10000);
        let v2 = Config{
            id      : 0x2::object::new(arg0),
            version : 1,
            dealer  : b"",
            fee_bps : 500,
            to      : v0,
            parts   : v1,
            paused  : true,
            revoked : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<Config>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    fun is_coin(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::with_defining_ids<0x2::coin::Coin<u8>>();
        let v1 = 0x1::type_name::address_string(arg0);
        let v2 = 0x1::type_name::module_string(arg0);
        v1 == 0x1::type_name::address_string(&v0) && v2 == 0x1::ascii::string(b"coin") || is_three(&v1) && v2 == 0x1::ascii::string(b"staking_pool")
    }

    public fun is_revoked(arg0: &Config, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.revoked, arg1)
    }

    fun is_three(arg0: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || *0x1::vector::borrow<u8>(v0, v1 - 1) != 51) {
            return false
        };
        let v2 = 0;
        while (v2 + 1 < v1) {
            if (*0x1::vector::borrow<u8>(v0, v2) != 48) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun join_message(arg0: vector<u8>, arg1: address) : vector<u8> {
        let v0 = b"viper-poker:join:v4";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        v0
    }

    public fun join_with_nft<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: T1, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        bound<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.nft_stake) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.nft_stake) == 0x1::type_name::with_defining_ids<T1>(), 20);
        check_permit<T0>(arg0, &arg4, 0x2::tx_context::sender(arg6));
        seat<T0>(arg0, arg2, arg5, arg6);
        put_nft<T0, T1>(arg0, arg3, 0x2::tx_context::sender(arg6), false);
    }

    public fun leave<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        ok<T0>(arg0);
        assert!(arg0.state == 0, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.players, &v0);
        assert!(v1, 10);
        0x1::vector::remove<address>(&mut arg0.players, v2);
        let v3 = 0x1::vector::remove<u64>(&mut arg0.deposits, v2);
        0x1::vector::remove<u64>(&mut arg0.rebuys, v2);
        arg0.seq = arg0.seq + 1;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v3, arg1), v0);
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<Nft>(&arg0.nfts)) {
            let v5 = 0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, v4);
            let v6 = if (v5.owner == v0) {
                if (!v5.prize) {
                    0x1::option::is_none<address>(&v5.dest)
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                v5.dest = 0x1::option::some<address>(v0);
            };
            v4 = v4 + 1;
        };
        let v7 = Left{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            player : v0,
        };
        0x2::event::emit<Left>(v7);
    }

    public fun migrate_config(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 28);
        arg1.version = 1;
    }

    public fun migrate_table<T0>(arg0: &AdminCap, arg1: &mut Table<T0>) {
        assert!(arg1.version < 1, 28);
        arg1.version = 1;
    }

    fun new_table<T0>(arg0: &Config, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<0x1::type_name::TypeName>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        cfg_ok(arg0);
        assert!(!arg0.paused, 25);
        assert!(0x1::vector::length<u8>(&arg0.dealer) == 32, 5);
        assert!(arg3 >= 2 && arg3 <= 10, 1);
        let v0 = if (arg4 >= 60000) {
            if (arg4 <= 604800000) {
                if (arg5 >= 60000) {
                    arg5 <= 604800000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 24);
        assert!(arg7 <= 20, 18);
        assert!(arg7 == 0 || arg6 > 0 && arg8 + 60000 <= arg5, 18);
        let v1 = 0x2::object::new(arg11);
        let v2 = Created{
            table       : 0x2::object::uid_to_inner(&v1),
            host        : 0x2::tx_context::sender(arg11),
            coin        : 0x1::type_name::with_defining_ids<T0>(),
            buy_in      : arg2,
            max_seats   : arg3,
            fee_bps     : arg0.fee_bps,
            rebuy_price : arg6,
            max_rebuys  : arg7,
            nft_stake   : arg9,
            rules       : arg1,
        };
        0x2::event::emit<Created>(v2);
        let v3 = Table<T0>{
            id              : v1,
            version         : 1,
            config          : 0x2::object::id<Config>(arg0),
            host            : 0x2::tx_context::sender(arg11),
            dealer          : arg0.dealer,
            rules           : arg1,
            buy_in          : arg2,
            max_seats       : arg3,
            players         : vector[],
            deposits        : vector[],
            rebuys          : vector[],
            seen            : vector[],
            seq             : 0,
            pot             : 0x2::balance::zero<T0>(),
            fee_bps         : arg0.fee_bps,
            state           : 0,
            start_by_ms     : 0x2::clock::timestamp_ms(arg10) + arg4,
            game_ms         : arg5,
            settle_by_ms    : 0,
            rebuy_price     : arg6,
            max_rebuys      : arg7,
            rebuy_window_ms : arg8,
            rebuy_until_ms  : 0,
            nft_stake       : arg9,
            nfts            : 0x1::vector::empty<Nft>(),
            prizes          : 0,
            payees          : vector[],
            owed            : vector[],
        };
        0x2::transfer::share_object<Table<T0>>(v3);
    }

    public fun nft_count<T0>(arg0: &Table<T0>) : u64 {
        0x1::vector::length<Nft>(&arg0.nfts)
    }

    public fun nft_dest<T0>(arg0: &Table<T0>, arg1: u64) : 0x1::option::Option<address> {
        0x1::vector::borrow<Nft>(&arg0.nfts, arg1).dest
    }

    public fun nft_out<T0>(arg0: &Table<T0>, arg1: u64) : bool {
        0x1::vector::borrow<Nft>(&arg0.nfts, arg1).out
    }

    fun ok<T0>(arg0: &Table<T0>) {
        assert!(arg0.version == 1, 28);
    }

    public fun owed<T0>(arg0: &Table<T0>) : vector<u64> {
        arg0.owed
    }

    fun pay_back<T0>(arg0: &mut Table<T0>, arg1: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.players)) {
            let v1 = *0x1::vector::borrow<address>(&arg0.players, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg0.deposits, v0);
            credit<T0>(arg0, v1, v2);
            v0 = v0 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<Nft>(&arg0.nfts)) {
            let v4 = 0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, v3);
            if (0x1::option::is_none<address>(&v4.dest)) {
                v4.dest = 0x1::option::some<address>(v4.owner);
            };
            v3 = v3 + 1;
        };
        arg0.state = 3;
        let v5 = Refunded{
            table   : 0x2::object::uid_to_inner(&arg0.id),
            players : arg0.players,
            amounts : arg0.deposits,
            by_team : arg1,
        };
        0x2::event::emit<Refunded>(v5);
    }

    fun pay_out<T0>(arg0: &mut Table<T0>, arg1: &Config, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg3), 14);
        let v1 = 0x2::balance::value<T0>(&arg0.pot);
        let v2 = fee_of(v1, arg0.fee_bps);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            assert!(0x1::vector::contains<address>(&arg0.players, 0x1::vector::borrow<address>(&arg2, v4)), 10);
            let v5 = v4 + 1;
            while (v5 < v0) {
                assert!(*0x1::vector::borrow<address>(&arg2, v4) != *0x1::vector::borrow<address>(&arg2, v5), 14);
                v5 = v5 + 1;
            };
            v3 = v3 + *0x1::vector::borrow<u64>(&arg3, v4);
            v4 = v4 + 1;
        };
        assert!(v3 == v1 - v2, 14);
        if (v2 > 0) {
            let v6 = 0x1::vector::length<address>(&arg1.to);
            let v7 = 0;
            while (v7 < v6) {
                let v8 = if (v7 + 1 == v6) {
                    v2
                } else {
                    (((v2 as u128) * (*0x1::vector::borrow<u64>(&arg1.parts, v7) as u128) / (10000 as u128)) as u64)
                };
                credit<T0>(arg0, *0x1::vector::borrow<address>(&arg1.to, v7), v8);
                v2 = v2 - v8;
                v7 = v7 + 1;
            };
        };
        v4 = 0;
        while (v4 < v0) {
            credit<T0>(arg0, *0x1::vector::borrow<address>(&arg2, v4), *0x1::vector::borrow<u64>(&arg3, v4));
            v4 = v4 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<Nft>(&arg0.nfts)) {
            let v10 = 0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, v9);
            if (0x1::option::is_none<address>(&v10.dest)) {
                v10.dest = 0x1::option::some<address>(*0x1::vector::borrow<address>(&arg2, 0));
            };
            v9 = v9 + 1;
        };
        arg0.state = 2;
        let v11 = Settled{
            table   : 0x2::object::uid_to_inner(&arg0.id),
            winners : arg2,
            amounts : arg3,
            fee     : v2,
        };
        0x2::event::emit<Settled>(v11);
    }

    public fun payees<T0>(arg0: &Table<T0>) : vector<address> {
        arg0.payees
    }

    public fun players<T0>(arg0: &Table<T0>) : vector<address> {
        arg0.players
    }

    public fun pot<T0>(arg0: &Table<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    fun put_nft<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: T1, arg2: address, arg3: bool) {
        let v0 = 0x1::vector::length<Nft>(&arg0.nfts);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = NftKey{i: v0};
        0x2::dynamic_object_field::add<NftKey, T1>(&mut arg0.id, v2, arg1);
        let v3 = Nft{
            owner : arg2,
            kind  : v1,
            prize : arg3,
            dest  : 0x1::option::none<address>(),
            out   : false,
        };
        0x1::vector::push_back<Nft>(&mut arg0.nfts, v3);
        let v4 = NftIn{
            table : 0x2::object::uid_to_inner(&arg0.id),
            i     : v0,
            owner : arg2,
            kind  : v1,
            prize : arg3,
        };
        0x2::event::emit<NftIn>(v4);
    }

    public fun rebuy<T0>(arg0: &mut Table<T0>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        bound<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = rebuy_check<T0>(arg0, &arg2, arg5, v0);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg3, 27);
        let v2 = rebuy_message(0x2::object::uid_to_bytes(&arg0.id), v0, *0x1::vector::borrow<u64>(&arg0.rebuys, v1), arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.dealer, &v2), 12);
        add_rebuy<T0>(arg0, arg2, v1, v0);
    }

    fun rebuy_check<T0>(arg0: &Table<T0>, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: address) : u64 {
        assert!(arg0.state == 1, 11);
        assert!(arg0.max_rebuys > 0 && 0x2::clock::timestamp_ms(arg2) < arg0.rebuy_until_ms, 19);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.players, &arg3);
        assert!(v0, 10);
        assert!(*0x1::vector::borrow<u64>(&arg0.rebuys, v1) < arg0.max_rebuys, 19);
        assert!(0x2::coin::value<T0>(arg1) == arg0.rebuy_price, 9);
        v1
    }

    public fun rebuy_message(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = b"viper-poker:rebuy:v4";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    public fun rebuy_until_ms<T0>(arg0: &Table<T0>) : u64 {
        arg0.rebuy_until_ms
    }

    public fun rebuys<T0>(arg0: &Table<T0>) : vector<u64> {
        arg0.rebuys
    }

    public fun refund<T0>(arg0: &mut Table<T0>, arg1: &0x2::clock::Clock) {
        ok<T0>(arg0);
        assert!(arg0.state == 0 || arg0.state == 1, 17);
        if (arg0.state == 0) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_by_ms, 16);
        } else {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.settle_by_ms, 16);
        };
        pay_back<T0>(arg0, false);
    }

    public fun release_nft<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: u64) {
        ok<T0>(arg0);
        assert!(arg1 < 0x1::vector::length<Nft>(&arg0.nfts), 23);
        let v0 = *0x1::vector::borrow<Nft>(&arg0.nfts, arg1);
        assert!(!v0.out && 0x1::option::is_some<address>(&v0.dest), 23);
        assert!(v0.kind == 0x1::type_name::with_defining_ids<T1>(), 20);
        let v1 = NftKey{i: arg1};
        let v2 = *0x1::option::borrow<address>(&v0.dest);
        0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<NftKey, T1>(&mut arg0.id, v1), v2);
        0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, arg1).out = true;
        let v3 = NftOut{
            table : 0x2::object::uid_to_inner(&arg0.id),
            i     : arg1,
            to    : v2,
        };
        0x2::event::emit<NftOut>(v3);
    }

    public fun revoke_dealer(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        cfg_ok(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        if (!0x2::table::contains<vector<u8>, bool>(&arg1.revoked, arg2)) {
            0x2::table::add<vector<u8>, bool>(&mut arg1.revoked, arg2, true);
        };
        if (arg1.dealer == arg2) {
            arg1.dealer = b"";
            arg1.paused = true;
        };
        changed(arg1);
    }

    public fun rules<T0>(arg0: &Table<T0>) : vector<u8> {
        arg0.rules
    }

    fun seat<T0>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_by_ms, 6);
        assert!(0x1::vector::length<address>(&arg0.players) < arg0.max_seats, 7);
        assert!(!0x1::vector::contains<address>(&arg0.players, &v0), 8);
        assert!(!0x1::vector::contains<address>(&arg0.seen, &v0), 31);
        assert!(0x1::vector::length<address>(&arg0.seen) < 30, 7);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.buy_in, 9);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        0x1::vector::push_back<address>(&mut arg0.players, v0);
        0x1::vector::push_back<address>(&mut arg0.seen, v0);
        0x1::vector::push_back<u64>(&mut arg0.deposits, arg0.buy_in);
        0x1::vector::push_back<u64>(&mut arg0.rebuys, 0);
        arg0.seq = arg0.seq + 1;
        let v1 = Joined{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            player : v0,
            seats  : 0x1::vector::length<address>(&arg0.players),
        };
        0x2::event::emit<Joined>(v1);
    }

    public fun seq<T0>(arg0: &Table<T0>) : u64 {
        arg0.seq
    }

    public fun set_dealer(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        cfg_ok(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32 && !0x2::table::contains<vector<u8>, bool>(&arg1.revoked, arg2), 5);
        arg1.dealer = arg2;
        changed(arg1);
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: vector<address>, arg4: vector<u64>) {
        cfg_ok(arg1);
        assert!(arg2 <= 1000, 3);
        let v0 = 0x1::vector::length<address>(&arg3);
        let v1 = if (v0 > 0) {
            if (v0 <= 8) {
                v0 == 0x1::vector::length<u64>(&arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v3) > 0, 3);
            v2 = v2 + *0x1::vector::borrow<u64>(&arg4, v3);
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 3);
        arg1.fee_bps = arg2;
        arg1.to = arg3;
        arg1.parts = arg4;
        changed(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        cfg_ok(arg1);
        assert!(arg2 || 0x1::vector::length<u8>(&arg1.dealer) == 32, 5);
        arg1.paused = arg2;
        changed(arg1);
    }

    public fun settle<T0>(arg0: &mut Table<T0>, arg1: &Config, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        bound<T0>(arg0, arg1);
        assert!(arg0.state == 1, 11);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.settle_by_ms, 27);
        let v0 = settle_message(0x2::object::uid_to_bytes(&arg0.id), arg2, arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.dealer, &v0), 12);
        pay_out<T0>(arg0, arg1, arg2, arg3);
    }

    public fun settle_by_ms<T0>(arg0: &Table<T0>) : u64 {
        arg0.settle_by_ms
    }

    public fun settle_message(arg0: vector<u8>, arg1: vector<address>, arg2: vector<u64>) : vector<u8> {
        let v0 = b"viper-poker:settle:v4";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        v0
    }

    public fun start<T0>(arg0: &mut Table<T0>, arg1: &Config, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        bound<T0>(arg0, arg1);
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.start_by_ms, 27);
        assert!(0x1::vector::length<address>(&arg0.players) >= 2, 13);
        let v0 = start_message(0x2::object::uid_to_bytes(&arg0.id), arg0.players, arg0.seq);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.dealer, &v0), 12);
        begin<T0>(arg0, arg3);
    }

    public fun start_message(arg0: vector<u8>, arg1: vector<address>, arg2: u64) : vector<u8> {
        let v0 = b"viper-poker:start:v4";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun state<T0>(arg0: &Table<T0>) : u8 {
        arg0.state
    }

    public fun version<T0>(arg0: &Table<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}


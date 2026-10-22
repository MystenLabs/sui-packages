module 0x41a7f5054b6482605981ab91d75b9f790f5fff1cc8d404e05265a74d44b1750d::table {
    struct Table<phantom T0> has key {
        id: 0x2::object::UID,
        host: address,
        dealer: vector<u8>,
        rules: vector<u8>,
        buy_in: u64,
        max_seats: u64,
        players: vector<address>,
        deposits: vector<u64>,
        rebuys: vector<u64>,
        pot: 0x2::balance::Balance<T0>,
        rake_bps: u64,
        rake_to: address,
        share_bps: u64,
        share_to: address,
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

    struct Created has copy, drop {
        table: 0x2::object::ID,
        host: address,
        buy_in: u64,
        max_seats: u64,
        rake_bps: u64,
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
        rake: u64,
    }

    struct Refunded has copy, drop {
        table: 0x2::object::ID,
        players: vector<address>,
        amounts: vector<u64>,
    }

    public fun join<T0>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.nft_stake), 21);
        check_permit<T0>(arg0, &arg2, 0x2::tx_context::sender(arg4));
        seat<T0>(arg0, arg1, arg3, arg4);
    }

    public fun add_prize<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.host, 15);
        assert!(arg0.state == 0, 6);
        assert!(arg0.prizes < 20, 22);
        arg0.prizes = arg0.prizes + 1;
        put_nft<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg2), true);
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

    public fun buy_in<T0>(arg0: &Table<T0>) : u64 {
        arg0.buy_in
    }

    public fun cancel<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.host, 15);
        assert!(arg0.state == 0, 6);
        pay_back<T0>(arg0, arg1);
    }

    fun check_permit<T0>(arg0: &Table<T0>, arg1: &vector<u8>, arg2: address) {
        let v0 = join_message(0x2::object::uid_to_bytes(&arg0.id), arg2);
        assert!(0x2::ed25519::ed25519_verify(arg1, &arg0.dealer, &v0), 12);
    }

    public fun create<T0, T1>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 2 && arg3 <= 10, 1);
        assert!(arg2 > 0 || arg13, 2);
        assert!(arg4 <= 1000 && arg6 <= 5000, 3);
        let v0 = if (arg8 >= 60000) {
            if (arg8 <= 604800000) {
                if (arg9 >= 60000) {
                    arg9 <= 604800000
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
        assert!(0x1::vector::length<u8>(&arg0) == 32, 5);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 24);
        assert!(arg11 <= 20, 18);
        assert!(arg11 == 0 || arg10 > 0 && arg12 <= arg9, 18);
        let v1 = if (arg13) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        let v2 = 0x2::object::new(arg15);
        let v3 = Created{
            table       : 0x2::object::uid_to_inner(&v2),
            host        : 0x2::tx_context::sender(arg15),
            buy_in      : arg2,
            max_seats   : arg3,
            rake_bps    : arg4,
            rebuy_price : arg10,
            max_rebuys  : arg11,
            nft_stake   : v1,
            rules       : arg1,
        };
        0x2::event::emit<Created>(v3);
        let v4 = Table<T0>{
            id              : v2,
            host            : 0x2::tx_context::sender(arg15),
            dealer          : arg0,
            rules           : arg1,
            buy_in          : arg2,
            max_seats       : arg3,
            players         : vector[],
            deposits        : vector[],
            rebuys          : vector[],
            pot             : 0x2::balance::zero<T0>(),
            rake_bps        : arg4,
            rake_to         : arg5,
            share_bps       : arg6,
            share_to        : arg7,
            state           : 0,
            start_by_ms     : 0x2::clock::timestamp_ms(arg14) + arg8,
            game_ms         : arg9,
            settle_by_ms    : 0,
            rebuy_price     : arg10,
            max_rebuys      : arg11,
            rebuy_window_ms : arg12,
            rebuy_until_ms  : 0,
            nft_stake       : v1,
            nfts            : 0x1::vector::empty<Nft>(),
            prizes          : 0,
        };
        0x2::transfer::share_object<Table<T0>>(v4);
    }

    public fun deposits<T0>(arg0: &Table<T0>) : vector<u64> {
        arg0.deposits
    }

    public fun join_message(arg0: vector<u8>, arg1: address) : vector<u8> {
        let v0 = b"viper-poker:join:v2";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        v0
    }

    public fun join_with_nft<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: T1, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.nft_stake) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.nft_stake) == 0x1::type_name::with_defining_ids<T1>(), 20);
        check_permit<T0>(arg0, &arg3, 0x2::tx_context::sender(arg5));
        seat<T0>(arg0, arg1, arg4, arg5);
        put_nft<T0, T1>(arg0, arg2, 0x2::tx_context::sender(arg5), false);
    }

    public fun leave<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.players, &v0);
        assert!(v1, 10);
        0x1::vector::remove<address>(&mut arg0.players, v2);
        let v3 = 0x1::vector::remove<u64>(&mut arg0.deposits, v2);
        0x1::vector::remove<u64>(&mut arg0.rebuys, v2);
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

    public fun nft_count<T0>(arg0: &Table<T0>) : u64 {
        0x1::vector::length<Nft>(&arg0.nfts)
    }

    public fun nft_dest<T0>(arg0: &Table<T0>, arg1: u64) : 0x1::option::Option<address> {
        0x1::vector::borrow<Nft>(&arg0.nfts, arg1).dest
    }

    public fun nft_out<T0>(arg0: &Table<T0>, arg1: u64) : bool {
        0x1::vector::borrow<Nft>(&arg0.nfts, arg1).out
    }

    fun pay_back<T0>(arg0: &mut Table<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.players)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.deposits, v0);
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v1, arg1), *0x1::vector::borrow<address>(&arg0.players, v0));
            };
            v0 = v0 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<Nft>(&arg0.nfts)) {
            let v3 = 0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, v2);
            if (0x1::option::is_none<address>(&v3.dest)) {
                v3.dest = 0x1::option::some<address>(v3.owner);
            };
            v2 = v2 + 1;
        };
        arg0.state = 3;
        let v4 = Refunded{
            table   : 0x2::object::uid_to_inner(&arg0.id),
            players : arg0.players,
            amounts : arg0.deposits,
        };
        0x2::event::emit<Refunded>(v4);
    }

    fun pay_out<T0>(arg0: &mut Table<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg2), 14);
        let v1 = 0x2::balance::value<T0>(&arg0.pot);
        let v2 = (((v1 as u128) * (arg0.rake_bps as u128) / (10000 as u128)) as u64);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            assert!(0x1::vector::contains<address>(&arg0.players, 0x1::vector::borrow<address>(&arg1, v4)), 10);
            let v5 = v4 + 1;
            while (v5 < v0) {
                assert!(*0x1::vector::borrow<address>(&arg1, v4) != *0x1::vector::borrow<address>(&arg1, v5), 14);
                v5 = v5 + 1;
            };
            v3 = v3 + *0x1::vector::borrow<u64>(&arg2, v4);
            v4 = v4 + 1;
        };
        assert!(v3 == v1 - v2, 14);
        if (v2 > 0) {
            let v6 = (((v2 as u128) * (arg0.share_bps as u128) / (10000 as u128)) as u64);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v6, arg3), arg0.share_to);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v2 - v6, arg3), arg0.rake_to);
        };
        v4 = 0;
        while (v4 < v0) {
            if (*0x1::vector::borrow<u64>(&arg2, v4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, *0x1::vector::borrow<u64>(&arg2, v4), arg3), *0x1::vector::borrow<address>(&arg1, v4));
            };
            v4 = v4 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<Nft>(&arg0.nfts)) {
            let v8 = 0x1::vector::borrow_mut<Nft>(&mut arg0.nfts, v7);
            if (0x1::option::is_none<address>(&v8.dest)) {
                v8.dest = 0x1::option::some<address>(*0x1::vector::borrow<address>(&arg1, 0));
            };
            v7 = v7 + 1;
        };
        arg0.state = 2;
        let v9 = Settled{
            table   : 0x2::object::uid_to_inner(&arg0.id),
            winners : arg1,
            amounts : arg2,
            rake    : v2,
        };
        0x2::event::emit<Settled>(v9);
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

    public fun rebuy<T0>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 11);
        assert!(arg0.max_rebuys > 0 && 0x2::clock::timestamp_ms(arg3) < arg0.rebuy_until_ms, 19);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.players, &v0);
        assert!(v1, 10);
        let v3 = *0x1::vector::borrow<u64>(&arg0.rebuys, v2);
        assert!(v3 < arg0.max_rebuys, 19);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.rebuy_price, 9);
        let v4 = rebuy_message(0x2::object::uid_to_bytes(&arg0.id), v0, v3);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.dealer, &v4), 12);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        *0x1::vector::borrow_mut<u64>(&mut arg0.rebuys, v2) = v3 + 1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.deposits, v2) = *0x1::vector::borrow<u64>(&arg0.deposits, v2) + arg0.rebuy_price;
        let v5 = Rebought{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            player : v0,
            n      : v3,
            amount : arg0.rebuy_price,
        };
        0x2::event::emit<Rebought>(v5);
    }

    public fun rebuy_message(arg0: vector<u8>, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"viper-poker:rebuy:v2";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun rebuy_until_ms<T0>(arg0: &Table<T0>) : u64 {
        arg0.rebuy_until_ms
    }

    public fun rebuys<T0>(arg0: &Table<T0>) : vector<u64> {
        arg0.rebuys
    }

    public fun refund<T0>(arg0: &mut Table<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0 || arg0.state == 1, 17);
        if (arg0.state == 0) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_by_ms, 16);
        } else {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.settle_by_ms, 16);
        };
        pay_back<T0>(arg0, arg2);
    }

    public fun release_nft<T0, T1: store + key>(arg0: &mut Table<T0>, arg1: u64) {
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

    public fun rules<T0>(arg0: &Table<T0>) : vector<u8> {
        arg0.rules
    }

    fun seat<T0>(arg0: &mut Table<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_by_ms, 6);
        assert!(0x1::vector::length<address>(&arg0.players) < arg0.max_seats, 7);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.players, &v0), 8);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.buy_in, 9);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        0x1::vector::push_back<address>(&mut arg0.players, 0x2::tx_context::sender(arg3));
        0x1::vector::push_back<u64>(&mut arg0.deposits, arg0.buy_in);
        0x1::vector::push_back<u64>(&mut arg0.rebuys, 0);
        let v1 = Joined{
            table  : 0x2::object::uid_to_inner(&arg0.id),
            player : 0x2::tx_context::sender(arg3),
            seats  : 0x1::vector::length<address>(&arg0.players),
        };
        0x2::event::emit<Joined>(v1);
    }

    public fun settle<T0>(arg0: &mut Table<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 11);
        let v0 = settle_message(0x2::object::uid_to_bytes(&arg0.id), arg1, arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.dealer, &v0), 12);
        pay_out<T0>(arg0, arg1, arg2, arg4);
    }

    public fun settle_by_ms<T0>(arg0: &Table<T0>) : u64 {
        arg0.settle_by_ms
    }

    public fun settle_message(arg0: vector<u8>, arg1: vector<address>, arg2: vector<u64>) : vector<u8> {
        let v0 = b"viper-poker:settle:v2";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        v0
    }

    public fun start<T0>(arg0: &mut Table<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(arg0.state == 0, 6);
        assert!(0x1::vector::length<address>(&arg0.players) >= 2, 13);
        let v0 = start_message(0x2::object::uid_to_bytes(&arg0.id), arg0.players);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.dealer, &v0), 12);
        begin<T0>(arg0, arg2);
    }

    public fun start_message(arg0: vector<u8>, arg1: vector<address>) : vector<u8> {
        let v0 = b"viper-poker:start:v2";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        v0
    }

    public fun state<T0>(arg0: &Table<T0>) : u8 {
        arg0.state
    }

    // decompiled from Move bytecode v7
}


module 0x8a619c9ea1574b576b51d8f9a7f4b3e9cccc9be18894d4d2ecf55c854d8211e9::checkdot_bridge_v1 {
    struct Transfer has copy, store {
        hash: vector<u8>,
        from: address,
        quantity: u64,
        fromChain: 0x1::string::String,
        toChain: 0x1::string::String,
        fees_in_cdt: u64,
        fees_in_sui: u64,
        block_timestamp: u64,
        block_number: u64,
        data: 0x1::string::String,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        cdt_coin: 0x2::balance::Balance<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>,
        chain: 0x1::string::String,
        fees_in_dollar: u64,
        fees_in_cdt_percentage: u64,
        minimum_transfer_quantity: u64,
        bridge_fees_in_cdt: u64,
        lock_ask_duration: u64,
        unlock_ask_duration: u64,
        unlock_ask_time: u64,
        transfers: vector<Transfer>,
        transfers_indexs: 0x2::table::Table<vector<u8>, u64>,
        transfers_hashs: 0x2::table::Table<vector<u8>, vector<u8>>,
        owner: address,
        program: address,
        paused: bool,
        sui_coin: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun balance(arg0: &Bridge) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_coin)
    }

    public entry fun add_transfers_from(arg0: &mut Bridge, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_owner_or_program(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::balance::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg0.cdt_coin) >= arg3, 504);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>>(0x2::coin::take<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&mut arg0.cdt_coin, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun ask_withdraw(arg0: &mut Bridge, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.unlock_ask_time = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    public fun assert_is_actived(arg0: &Bridge) {
        assert!(!arg0.paused, 300);
    }

    public fun assert_is_owner(arg0: &Bridge, arg1: address) {
        assert!(arg1 == arg0.owner, 200);
    }

    public fun assert_is_owner_or_program(arg0: &Bridge, arg1: address) {
        assert!(arg1 == arg0.owner || arg1 == arg0.program, 201);
    }

    public fun balance_CDT(arg0: &Bridge) : u64 {
        0x2::balance::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg0.cdt_coin)
    }

    public entry fun collect_cdt_fees(arg0: &mut Bridge, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg1));
        assert!(0x2::balance::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg0.cdt_coin) >= arg0.bridge_fees_in_cdt, 504);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>>(0x2::coin::take<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&mut arg0.cdt_coin, arg0.bridge_fees_in_cdt, arg1), 0x2::tx_context::sender(arg1));
        arg0.bridge_fees_in_cdt = 0;
    }

    public entry fun deposit(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::put<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&mut arg0.cdt_coin, arg1);
    }

    public entry fun deposit_sui(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_coin, arg1);
    }

    fun fees_in_cdt_by_quantity(arg0: &Bridge, arg1: u64) : u64 {
        arg1 * arg0.fees_in_cdt_percentage / 100
    }

    fun fees_in_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg1: &Bridge) : u64 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<0x2::sui::SUI, T0>(arg0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 > 0, 400);
        (((arg1.fees_in_dollar as u256) * 0x1::u256::pow(10, 6) / 0x1::u256::pow(10, 9) * (0x2::balance::value<0x2::sui::SUI>(v0) as u256) / (v2 as u256)) as u64)
    }

    public fun get_fees_in_cdt_by_quantity(arg0: &Bridge, arg1: u64) : u64 {
        arg1 * arg0.fees_in_cdt_percentage / 100
    }

    public fun get_fees_in_dollar(arg0: &Bridge) : u64 {
        arg0.fees_in_dollar
    }

    public fun get_fees_in_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg1: &Bridge) : u64 {
        fees_in_sui<T0>(arg0, arg1)
    }

    fun get_hash(arg0: address, arg1: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg0));
        0x2::hash::keccak256(&v1)
    }

    public fun get_last_transfers(arg0: &Bridge, arg1: u64) : vector<Transfer> {
        let v0 = 0x1::vector::length<Transfer>(&arg0.transfers);
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = v1;
        let v3 = 0x1::vector::empty<Transfer>();
        while (v2 < v0) {
            0x1::vector::push_back<Transfer>(&mut v3, *0x1::vector::borrow<Transfer>(&arg0.transfers, v2));
            v2 = v2 + 1;
        };
        v3
    }

    public fun get_transfer(arg0: &Bridge, arg1: vector<u8>) : Transfer {
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.transfers_indexs, arg1), 502);
        *0x1::vector::borrow<Transfer>(&arg0.transfers, *0x2::table::borrow<vector<u8>, u64>(&arg0.transfers_indexs, arg1))
    }

    public fun get_transfer_length(arg0: &Bridge) : u64 {
        0x1::vector::length<Transfer>(&arg0.transfers)
    }

    public fun get_transfers(arg0: &Bridge, arg1: u64, arg2: u64) : vector<Transfer> {
        let v0 = 0x1::vector::length<Transfer>(&arg0.transfers);
        assert!(v0 >= arg1 * arg2, 503);
        let v1 = v0 - arg1 * arg2;
        let v2 = if (v1 >= arg2) {
            v1 - arg2
        } else {
            0
        };
        assert!(v1 <= v0, 503);
        let v3 = 0x1::vector::empty<Transfer>();
        while (v1 > v2) {
            0x1::vector::push_back<Transfer>(&mut v3, *0x1::vector::borrow<Transfer>(&arg0.transfers, v1 - 1));
            v1 = v1 - 1;
        };
        v3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Bridge{
            id                        : 0x2::object::new(arg0),
            cdt_coin                  : 0x2::balance::zero<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(),
            chain                     : 0x1::string::utf8(b"sui"),
            fees_in_dollar            : 0,
            fees_in_cdt_percentage    : 0,
            minimum_transfer_quantity : 100000000,
            bridge_fees_in_cdt        : 0,
            lock_ask_duration         : 172800000000,
            unlock_ask_duration       : 1296000000000,
            unlock_ask_time           : 0,
            transfers                 : 0x1::vector::empty<Transfer>(),
            transfers_indexs          : 0x2::table::new<vector<u8>, u64>(arg0),
            transfers_hashs           : 0x2::table::new<vector<u8>, vector<u8>>(arg0),
            owner                     : v0,
            program                   : v0,
            paused                    : false,
            sui_coin                  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Bridge>(v1);
    }

    public entry fun init_transfer<T0>(arg0: &mut Bridge, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert_is_actived(arg0);
        assert!(0x2::coin::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg3) >= arg0.minimum_transfer_quantity, 500);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= fees_in_sui<T0>(arg1, arg0), 501);
        let v2 = 0x2::coin::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_coin, arg2);
        0x2::coin::put<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&mut arg0.cdt_coin, arg3);
        let v3 = fees_in_cdt_by_quantity(arg0, v2);
        arg0.bridge_fees_in_cdt = arg0.bridge_fees_in_cdt + v3;
        let v4 = get_hash(v0, arg6);
        let v5 = Transfer{
            hash            : v4,
            from            : v0,
            quantity        : v2 - v3,
            fromChain       : arg0.chain,
            toChain         : arg4,
            fees_in_cdt     : v3,
            fees_in_sui     : v1,
            block_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg6),
            block_number    : 0x2::tx_context::epoch(arg6),
            data            : arg5,
        };
        0x1::vector::push_back<Transfer>(&mut arg0.transfers, v5);
        0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.transfers_hashs, v4, v4);
        0x2::table::add<vector<u8>, u64>(&mut arg0.transfers_indexs, v4, 0x1::vector::length<Transfer>(&arg0.transfers));
    }

    public fun is_paused(arg0: &Bridge) : bool {
        arg0.paused
    }

    public entry fun set_fees_in_cdt_percentage(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.fees_in_cdt_percentage = arg1;
    }

    public entry fun set_fees_in_dollar(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.fees_in_dollar = arg1;
    }

    public entry fun set_minimum_transfer_quantity(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.minimum_transfer_quantity = arg1;
    }

    public entry fun set_owner(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.owner = arg1;
    }

    public entry fun set_paused(arg0: &mut Bridge, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.paused = arg1;
    }

    public entry fun set_program(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.program = arg1;
    }

    public fun transfer_exists(arg0: &Bridge, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, vector<u8>>(&arg0.transfers_hashs, arg1)
    }

    public entry fun withdraw(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(arg0.unlock_ask_time < v0 - arg0.lock_ask_duration, 505);
        assert!(arg0.unlock_ask_time > v0 - arg0.unlock_ask_duration, 506);
        assert!(0x2::balance::value<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&arg0.cdt_coin) >= arg1, 504);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>>(0x2::coin::take<0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt::CDT>(&mut arg0.cdt_coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_coin) >= arg1, 504);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


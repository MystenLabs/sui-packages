module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::vault {
    struct DepositedEvent has copy, drop {
        deposit_id: vector<u8>,
        depositor: address,
        coin_id: 0x1::string::String,
        amt: u64,
        mint_chain_id: u64,
        mint_addr: vector<u8>,
        nonce: u64,
    }

    struct WithdrawnEvent has copy, drop {
        wd_id: vector<u8>,
        receiver: address,
        coin_id: 0x1::string::String,
        amt: u64,
        ref_chain_id: u64,
        burn_addr: vector<u8>,
        ref_id: vector<u8>,
    }

    struct CoinConfig has drop, store {
        pool_id: 0x2::object::ID,
        min_deposit: u64,
        max_deposit: u64,
        delay_threshold: u64,
        vol_cap: u64,
    }

    struct WithdrawInfo has drop {
        coin_id: 0x1::string::String,
        receiver: vector<u8>,
        amt: u64,
        burner: vector<u8>,
        ref_chain_id: u64,
        ref_id: vector<u8>,
    }

    struct VaultState has key {
        id: 0x2::object::UID,
        coin_map: 0x2::table::Table<0x1::string::String, CoinConfig>,
        domain_prefix: vector<u8>,
        module_addr: vector<u8>,
        records: 0x2::table::Table<vector<u8>, bool>,
        paused: bool,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public entry fun add_token<T0>(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut VaultState, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg6), arg0), 3021);
        let v0 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>();
        if (0x2::table::contains<0x1::string::String, CoinConfig>(&arg1.coin_map, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, CoinConfig>(&mut arg1.coin_map, v0);
            v1.min_deposit = arg2;
            v1.max_deposit = arg3;
            v1.delay_threshold = arg4;
            v1.vol_cap = arg5;
        } else {
            let v2 = 0x2::object::new(arg6);
            let v3 = CoinConfig{
                pool_id         : 0x2::object::uid_to_inner(&v2),
                min_deposit     : arg2,
                max_deposit     : arg3,
                delay_threshold : arg4,
                vol_cap         : arg5,
            };
            0x2::table::add<0x1::string::String, CoinConfig>(&mut arg1.coin_map, v0, v3);
            let v4 = Pool<T0>{
                id   : v2,
                coin : 0x2::coin::zero<T0>(arg6),
            };
            0x2::transfer::share_object<Pool<T0>>(v4);
        };
    }

    fun cal_wd_id(arg0: &WithdrawInfo, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg0.amt);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 0x1::bcs::to_bytes<u64>(&arg0.ref_chain_id);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, arg0.receiver);
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg0.coin_id));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, arg0.burner);
        0x1::vector::append<u8>(&mut v2, v1);
        0x1::vector::append<u8>(&mut v2, arg0.ref_id);
        0x1::vector::append<u8>(&mut v2, arg1);
        0x2::hash::keccak256(&v2)
    }

    fun decode_wd_pb(arg0: vector<u8>) : WithdrawInfo {
        let v0 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::create(arg0);
        let v1 = WithdrawInfo{
            coin_id      : 0x1::string::utf8(b""),
            receiver     : 0x1::vector::empty<u8>(),
            amt          : 0,
            burner       : 0x1::vector::empty<u8>(),
            ref_chain_id : 0,
            ref_id       : 0x1::vector::empty<u8>(),
        };
        while (0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::has_more(&v0)) {
            let (v2, v3) = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_key(&mut v0);
            if (v2 == 1) {
                assert!(v3 == 2, 3003);
                v1.coin_id = 0x1::string::utf8(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0));
                continue
            };
            if (v2 == 2) {
                assert!(v3 == 2, 3003);
                v1.receiver = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                continue
            };
            if (v2 == 3) {
                assert!(v3 == 2, 3003);
                let v4 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                v1.amt = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::to_u64(&v4);
                continue
            };
            if (v2 == 4) {
                assert!(v3 == 2, 3003);
                v1.burner = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                continue
            };
            if (v2 == 5) {
                assert!(v3 == 0, 3004);
                v1.ref_chain_id = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_varint(&mut v0);
                continue
            };
            assert!(v2 == 6, 3005);
            assert!(v3 == 2, 3003);
            v1.ref_id = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
        };
        v1
    }

    public entry fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &mut VaultState, arg5: &mut Pool<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.paused == false, 3006);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>();
        assert!(0x2::table::contains<0x1::string::String, CoinConfig>(&arg4.coin_map, v1), 3011);
        let v2 = 0x2::coin::value<T0>(&arg0);
        let v3 = get_deposit_id(v0, v1, v2, arg1, arg2, arg3, arg4.domain_prefix);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg4.records, v3) == false, 3016);
        0x2::table::add<vector<u8>, bool>(&mut arg4.records, v3, true);
        let v4 = 0x2::table::borrow<0x1::string::String, CoinConfig>(&arg4.coin_map, v1);
        assert!(v2 > 0, 3013);
        assert!(v4.max_deposit == 0 || v2 <= v4.max_deposit, 3014);
        assert!(v2 >= v4.min_deposit, 3015);
        assert!(0x2::object::id<Pool<T0>>(arg5) == v4.pool_id, 3026);
        0x2::coin::join<T0>(&mut arg5.coin, arg0);
        let v5 = DepositedEvent{
            deposit_id    : v3,
            depositor     : v0,
            coin_id       : v1,
            amt           : v2,
            mint_chain_id : arg1,
            mint_addr     : arg2,
            nonce         : arg3,
        };
        0x2::event::emit<DepositedEvent>(v5);
    }

    public entry fun execute_delay_transfer<T0>(arg0: vector<u8>, arg1: &mut VaultState, arg2: &mut Pool<T0>, arg3: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::DelayedTransferState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused == false, 3006);
        let (v0, v1, v2) = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::execute_delayed_transfer(arg0, arg3, arg4);
        assert!(v1 == 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>(), 3011);
        assert!(0x2::object::id<Pool<T0>>(arg2) == 0x2::table::borrow<0x1::string::String, CoinConfig>(&arg1.coin_map, v1).pool_id, 3026);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.coin, v2, arg5), v0);
    }

    fun get_deposit_id(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::bcs::to_bytes<u64>(&arg2);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::bcs::to_bytes<u64>(&arg3);
        0x1::vector::reverse<u8>(&mut v2);
        let v3 = 0x1::bcs::to_bytes<u64>(&arg5);
        0x1::vector::reverse<u8>(&mut v3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(&arg1));
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, v3);
        0x1::vector::append<u8>(&mut v0, arg6);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<VaultState>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)));
        let v3 = 0x1::bcs::to_bytes<address>(&v2);
        let v4 = 0x1::type_name::get<VaultState>();
        let v5 = 0x1::ascii::into_bytes(0x1::type_name::get_module(&v4));
        let v6 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_chain_id();
        let v7 = 0x1::bcs::to_bytes<u64>(&v6);
        0x1::vector::reverse<u8>(&mut v7);
        0x1::vector::append<u8>(&mut v7, v3);
        0x1::vector::append<u8>(&mut v7, v5);
        0x1::vector::append<u8>(&mut v3, v5);
        let v8 = VaultState{
            id            : 0x2::object::new(arg0),
            coin_map      : 0x2::table::new<0x1::string::String, CoinConfig>(arg0),
            domain_prefix : v7,
            module_addr   : v3,
            records       : 0x2::table::new<vector<u8>, bool>(arg0),
            paused        : false,
        };
        0x2::transfer::share_object<VaultState>(v8);
    }

    public entry fun pause(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut VaultState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_pauser(0x2::tx_context::sender(arg2), arg0), 3022);
        arg1.paused = true;
    }

    public entry fun rm_token<T0>(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut VaultState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg2), arg0), 3021);
        0x2::table::remove<0x1::string::String, CoinConfig>(&mut arg1.coin_map, 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>());
    }

    public entry fun unpause(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut VaultState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_pauser(0x2::tx_context::sender(arg2), arg0), 3022);
        arg1.paused = false;
    }

    public entry fun withdraw<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<u128>, arg4: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::BridgeState, arg5: &mut VaultState, arg6: &mut Pool<T0>, arg7: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::DelayedTransferState, arg8: &0x2::clock::Clock, arg9: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::volume_control::VolumeControlState, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.paused == false, 3006);
        let v0 = arg5.domain_prefix;
        0x1::vector::append<u8>(&mut v0, b".Withdraw");
        0x1::vector::append<u8>(&mut v0, arg0);
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::verify_sigs(v0, arg1, arg2, arg3, arg4), 3008);
        let v1 = decode_wd_pb(arg0);
        assert!(0x2::table::contains<0x1::string::String, CoinConfig>(&arg5.coin_map, v1.coin_id), 3011);
        assert!(v1.amt > 0, 3009);
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>() == v1.coin_id, 3010);
        let v2 = 0x2::address::from_bytes(v1.receiver);
        let v3 = 0x2::table::borrow<0x1::string::String, CoinConfig>(&arg5.coin_map, v1.coin_id);
        assert!(0x2::object::id<Pool<T0>>(arg6) == v3.pool_id, 3026);
        let v4 = cal_wd_id(&v1, arg5.module_addr);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg5.records, v4) == false, 3012);
        0x2::table::add<vector<u8>, bool>(&mut arg5.records, v4, true);
        0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::volume_control::update_volume(v1.coin_id, &v1.amt, &v3.vol_cap, arg9, arg8);
        if (v1.amt > v3.delay_threshold && v3.delay_threshold > 0) {
            0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::add_delayed_transfer(v4, v1.coin_id, v2, v1.amt, arg7, arg8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg6.coin, v1.amt, arg10), v2);
        };
        let v5 = WithdrawnEvent{
            wd_id        : v4,
            receiver     : v2,
            coin_id      : v1.coin_id,
            amt          : v1.amt,
            ref_chain_id : v1.ref_chain_id,
            burn_addr    : v1.burner,
            ref_id       : v1.ref_id,
        };
        0x2::event::emit<WithdrawnEvent>(v5);
    }

    // decompiled from Move bytecode v6
}


module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::peg_bridge {
    struct MintEvent has copy, drop {
        mint_id: vector<u8>,
        receiver: address,
        coin_id: 0x1::string::String,
        amt: u64,
        ref_chain_id: u64,
        ref_id: vector<u8>,
        depositor: vector<u8>,
    }

    struct BurnEvent has copy, drop {
        burn_id: vector<u8>,
        burner: address,
        coin_id: 0x1::string::String,
        amt: u64,
        to_chain: u64,
        to_addr: vector<u8>,
        nonce: u64,
    }

    struct CoinConfig has drop, store {
        mint_tc_id: 0x2::object::ID,
        min_burn: u64,
        max_burn: u64,
        delay_threshold: u64,
        vol_cap: u64,
    }

    struct MintInfo has drop {
        account: vector<u8>,
        coin_id: 0x1::string::String,
        amt: u64,
        depositor: vector<u8>,
        ref_chain_id: u64,
        ref_id: vector<u8>,
    }

    struct TreasuryWrap<phantom T0> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct PegBridgeState has key {
        id: 0x2::object::UID,
        coin_map: 0x2::table::Table<0x1::string::String, CoinConfig>,
        domain_prefix: vector<u8>,
        module_addr: vector<u8>,
        records: 0x2::table::Table<vector<u8>, bool>,
        paused: bool,
    }

    public entry fun burn<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &mut PegBridgeState, arg5: &mut TreasuryWrap<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.paused == false, 2006);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>();
        let v2 = 0x2::coin::value<T0>(&arg0);
        let v3 = get_burn_id(v0, v1, v2, arg1, arg2, arg3, arg4.domain_prefix);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg4.records, v3) == false, 2016);
        0x2::table::add<vector<u8>, bool>(&mut arg4.records, v3, true);
        assert!(0x2::table::contains<0x1::string::String, CoinConfig>(&arg4.coin_map, v1), 2011);
        let v4 = 0x2::table::borrow<0x1::string::String, CoinConfig>(&arg4.coin_map, v1);
        assert!(v2 > 0, 2013);
        assert!(v4.max_burn == 0 || v2 <= v4.max_burn, 2014);
        assert!(v2 >= v4.min_burn, 2015);
        0x2::coin::burn<T0>(&mut arg5.cap, arg0);
        let v5 = BurnEvent{
            burn_id  : v3,
            burner   : v0,
            coin_id  : v1,
            amt      : v2,
            to_chain : arg1,
            to_addr  : arg2,
            nonce    : arg3,
        };
        0x2::event::emit<BurnEvent>(v5);
    }

    public entry fun mint<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<u128>, arg4: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::BridgeState, arg5: &mut PegBridgeState, arg6: &mut TreasuryWrap<T0>, arg7: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::DelayedTransferState, arg8: &0x2::clock::Clock, arg9: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::volume_control::VolumeControlState, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.paused == false, 2006);
        let v0 = arg5.domain_prefix;
        0x1::vector::append<u8>(&mut v0, b".Mint");
        0x1::vector::append<u8>(&mut v0, arg0);
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::verify_sigs(v0, arg1, arg2, arg3, arg4), 2008);
        let v1 = decode_mint_pb(arg0);
        assert!(0x2::table::contains<0x1::string::String, CoinConfig>(&arg5.coin_map, v1.coin_id), 2011);
        assert!(v1.amt > 0, 2009);
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>() == v1.coin_id, 2010);
        let v2 = 0x2::address::from_bytes(v1.account);
        let v3 = 0x2::table::borrow<0x1::string::String, CoinConfig>(&arg5.coin_map, v1.coin_id);
        let v4 = cal_mint_id(&v1, arg5.module_addr);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg5.records, v4) == false, 2012);
        0x2::table::add<vector<u8>, bool>(&mut arg5.records, v4, true);
        0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::volume_control::update_volume(v1.coin_id, &v1.amt, &v3.vol_cap, arg9, arg8);
        if (v1.amt > v3.delay_threshold && v3.delay_threshold > 0) {
            0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::add_delayed_transfer(v4, v1.coin_id, v2, v1.amt, arg7, arg8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg6.cap, v1.amt, arg10), v2);
        };
        let v5 = MintEvent{
            mint_id      : v4,
            receiver     : v2,
            coin_id      : v1.coin_id,
            amt          : v1.amt,
            ref_chain_id : v1.ref_chain_id,
            ref_id       : v1.ref_id,
            depositor    : v1.depositor,
        };
        0x2::event::emit<MintEvent>(v5);
    }

    public entry fun add_token<T0>(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut PegBridgeState, arg6: &TreasuryWrap<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg7), arg0), 2021);
        let v0 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>();
        if (0x2::table::contains<0x1::string::String, CoinConfig>(&arg5.coin_map, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, CoinConfig>(&mut arg5.coin_map, v0);
            v1.min_burn = arg1;
            v1.max_burn = arg2;
            v1.delay_threshold = arg3;
            v1.vol_cap = arg4;
        } else {
            let v2 = CoinConfig{
                mint_tc_id      : 0x2::object::uid_to_inner(&arg6.id),
                min_burn        : arg1,
                max_burn        : arg2,
                delay_threshold : arg3,
                vol_cap         : arg4,
            };
            0x2::table::add<0x1::string::String, CoinConfig>(&mut arg5.coin_map, v0, v2);
        };
    }

    public entry fun add_token_treasury<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryWrap<T0>{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::share_object<TreasuryWrap<T0>>(v0);
    }

    fun cal_mint_id(arg0: &MintInfo, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg0.amt);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 0x1::bcs::to_bytes<u64>(&arg0.ref_chain_id);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, arg0.account);
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg0.coin_id));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, arg0.depositor);
        0x1::vector::append<u8>(&mut v2, v1);
        0x1::vector::append<u8>(&mut v2, arg0.ref_id);
        0x1::vector::append<u8>(&mut v2, arg1);
        0x2::hash::keccak256(&v2)
    }

    fun decode_mint_pb(arg0: vector<u8>) : MintInfo {
        let v0 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::create(arg0);
        let v1 = MintInfo{
            account      : 0x1::vector::empty<u8>(),
            coin_id      : 0x1::string::utf8(b""),
            amt          : 0,
            depositor    : 0x1::vector::empty<u8>(),
            ref_chain_id : 0,
            ref_id       : 0x1::vector::empty<u8>(),
        };
        while (0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::has_more(&v0)) {
            let (v2, v3) = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_key(&mut v0);
            if (v2 == 1) {
                assert!(v3 == 2, 2004);
                v1.coin_id = 0x1::string::utf8(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0));
                continue
            };
            if (v2 == 2) {
                assert!(v3 == 2, 2003);
                v1.account = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                assert!(0x1::vector::length<u8>(&v1.account) == 32, 2026);
                continue
            };
            if (v2 == 3) {
                assert!(v3 == 2, 2003);
                let v4 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                v1.amt = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::to_u64(&v4);
                continue
            };
            if (v2 == 4) {
                assert!(v3 == 2, 2003);
                v1.depositor = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
                continue
            };
            if (v2 == 5) {
                assert!(v3 == 0, 2004);
                v1.ref_chain_id = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_varint(&mut v0);
                continue
            };
            assert!(v2 == 6, 2005);
            assert!(v3 == 2, 2003);
            v1.ref_id = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb::dec_bytes(&mut v0);
        };
        v1
    }

    public entry fun execute_delay_transfer<T0>(arg0: vector<u8>, arg1: &mut PegBridgeState, arg2: &mut TreasuryWrap<T0>, arg3: &mut 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::DelayedTransferState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused == false, 2006);
        let (v0, v1, v2) = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::delayed_transfer::execute_delayed_transfer(arg0, arg3, arg4);
        assert!(0x2::table::contains<0x1::string::String, CoinConfig>(&arg1.coin_map, v1), 2011);
        assert!(v1 == 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>(), 2010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg2.cap, v2, arg5), v0);
    }

    fun get_burn_id(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) : vector<u8> {
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
        let v0 = 0x1::type_name::get<PegBridgeState>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)));
        let v3 = 0x1::bcs::to_bytes<address>(&v2);
        let v4 = 0x1::type_name::get<PegBridgeState>();
        let v5 = 0x1::ascii::into_bytes(0x1::type_name::get_module(&v4));
        let v6 = 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_chain_id();
        let v7 = 0x1::bcs::to_bytes<u64>(&v6);
        0x1::vector::reverse<u8>(&mut v7);
        0x1::vector::append<u8>(&mut v7, v3);
        0x1::vector::append<u8>(&mut v7, v5);
        0x1::vector::append<u8>(&mut v3, v5);
        let v8 = PegBridgeState{
            id            : 0x2::object::new(arg0),
            coin_map      : 0x2::table::new<0x1::string::String, CoinConfig>(arg0),
            domain_prefix : v7,
            module_addr   : v3,
            records       : 0x2::table::new<vector<u8>, bool>(arg0),
            paused        : false,
        };
        0x2::transfer::share_object<PegBridgeState>(v8);
    }

    public entry fun pause(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut PegBridgeState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_pauser(0x2::tx_context::sender(arg2), arg0), 2022);
        arg1.paused = true;
    }

    public entry fun rm_token<T0>(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut PegBridgeState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg2), arg0), 2021);
        0x2::table::remove<0x1::string::String, CoinConfig>(&mut arg1.coin_map, 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::bridge::get_coin_id<T0>());
    }

    public entry fun unpause(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: &mut PegBridgeState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_pauser(0x2::tx_context::sender(arg2), arg0), 2022);
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}


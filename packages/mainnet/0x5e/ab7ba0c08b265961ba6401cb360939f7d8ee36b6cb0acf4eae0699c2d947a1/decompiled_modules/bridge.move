module 0x5eab7ba0c08b265961ba6401cb360939f7d8ee36b6cb0acf4eae0699c2d947a1::bridge {
    struct BridgeHub has key {
        id: 0x2::object::UID,
        transfers: 0x2::table::Table<0x1::ascii::String, RelayConfig>,
        version: u8,
    }

    struct RelayConfig has store {
        owner: address,
        relayer: address,
        status: u8,
        destination_chain: address,
        fee_collector: address,
        relay_fee: u8,
        transfers: 0x2::table::Table<0x2::object::ID, TransferMeta>,
    }

    struct TransferMeta has copy, drop, store {
        asset_class: 0x1::ascii::String,
        nonce: u64,
        relayed: bool,
    }

    struct RelayCreated has copy, drop {
        relay_id: 0x1::ascii::String,
        owner: address,
    }

    struct TransferInitiated has copy, drop {
        relay_id: 0x1::ascii::String,
        transfer_id: 0x2::object::ID,
        asset_class: 0x1::ascii::String,
        nonce: u64,
    }

    struct RelayCompleted has copy, drop {
        relay_id: 0x1::ascii::String,
        transfer_id: 0x2::object::ID,
        result_nonce: u64,
    }

    public entry fun activate_relay(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun archive_transfer(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut BridgeHub, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg1.transfers, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg1.transfers, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.relayer, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TransferMeta>(&v0.transfers, arg3);
            !v3.relayed && v3.nonce > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg3).relayed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.relay_fee as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.fee_collector);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.destination_chain);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.destination_chain);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.fee_collector);
        };
        let v7 = RelayCompleted{
            relay_id     : arg2,
            transfer_id  : arg3,
            result_nonce : v5,
        };
        0x2::event::emit<RelayCompleted>(v7);
    }

    public entry fun create_relay(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = RelayConfig{
            owner             : 0x2::tx_context::sender(arg6),
            relayer           : arg2,
            status            : 0,
            destination_chain : arg3,
            fee_collector     : arg4,
            relay_fee         : arg5,
            transfers         : 0x2::table::new<0x2::object::ID, TransferMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1, v0);
        let v1 = RelayCreated{
            relay_id : arg1,
            owner    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RelayCreated>(v1);
    }

    public fun finalize_transfer<T0: store + key>(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.relayer, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TransferMeta>(&v0.transfers, arg2);
            !v3.relayed && v3.nonce > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg2).relayed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.destination_chain);
        let v4 = RelayCompleted{
            relay_id     : arg1,
            transfer_id  : arg2,
            result_nonce : 1,
        };
        0x2::event::emit<RelayCompleted>(v4);
    }

    public fun get_relay_info(arg0: &BridgeHub, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1);
        (v0.owner, v0.relayer, v0.status & 1 != 0, v0.destination_chain, v0.fee_collector, v0.relay_fee)
    }

    public fun get_transfer_info(arg0: &BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1);
        assert!(0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, TransferMeta>(&v0.transfers, arg2);
        (v1.asset_class, v1.nonce, v1.relayed)
    }

    public fun get_transfer_nonce(arg0: &BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, TransferMeta>(&v0.transfers, arg2);
        if (v1.relayed) {
            return 0
        };
        v1.nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeHub{
            id        : 0x2::object::new(arg0),
            transfers : 0x2::table::new<0x1::ascii::String, RelayConfig>(arg0),
            version   : 1,
        };
        0x2::transfer::share_object<BridgeHub>(v0);
    }

    public entry fun initiate_transfer(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.relayer, 100);
        let v2 = TransferMeta{
            asset_class : arg3,
            nonce       : arg4,
            relayed     : false,
        };
        if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg2, v2);
        };
        let v3 = TransferInitiated{
            relay_id    : arg1,
            transfer_id : arg2,
            asset_class : arg3,
            nonce       : arg4,
        };
        0x2::event::emit<TransferInitiated>(v3);
    }

    public fun relay_batch<T0>(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.relayer, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg2).relayed = true;
        };
        let v3 = v2 * (v0.relay_fee as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.fee_collector);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.destination_chain);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.destination_chain);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.fee_collector);
        };
        let v4 = RelayCompleted{
            relay_id     : arg1,
            transfer_id  : arg2,
            result_nonce : v2,
        };
        0x2::event::emit<RelayCompleted>(v4);
    }

    public fun should_relay(arg0: &BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_transfer_nonce(arg0, arg1, arg2) > 0
    }

    public entry fun update_nonce(arg0: &mut BridgeHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, RelayConfig>(&arg0.transfers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, RelayConfig>(&mut arg0.transfers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.relayer, 100);
        assert!(0x2::table::contains<0x2::object::ID, TransferMeta>(&v0.transfers, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, TransferMeta>(&mut v0.transfers, arg2).nonce = arg3;
    }

    // decompiled from Move bytecode v6
}


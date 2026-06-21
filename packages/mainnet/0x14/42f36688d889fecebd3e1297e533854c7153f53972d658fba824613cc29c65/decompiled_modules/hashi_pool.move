module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool {
    struct HashiPoolConfig has key {
        id: 0x2::object::UID,
        derivation_address: address,
        btc_deposit_address: vector<u8>,
        total_deposits: u64,
        total_sats_confirmed: u128,
        pending_sats: u64,
        deposit_index: 0x2::table::Table<u64, address>,
    }

    struct BlockDepositRecord has key {
        id: 0x2::object::UID,
        round_id: u64,
        txid: vector<u8>,
        vout: u32,
        amount_sats: u64,
        hashi_request_id: 0x1::option::Option<address>,
        status: u8,
        created_at_ms: u64,
        confirmed_at_ms: 0x1::option::Option<u64>,
        failure_reason: 0x1::option::Option<vector<u8>>,
        funded_batch_id: 0x1::option::Option<address>,
    }

    struct HashiPoolInitialized has copy, drop {
        config_id: address,
        derivation_address: address,
        btc_deposit_address: vector<u8>,
    }

    struct BtcAddressUpdated has copy, drop {
        config_id: address,
        old_address: vector<u8>,
        new_address: vector<u8>,
    }

    struct BlockRewardRecorded has copy, drop {
        record_id: address,
        round_id: u64,
        txid: vector<u8>,
        vout: u32,
        amount_sats: u64,
    }

    struct HashibDepositRequested has copy, drop {
        record_id: address,
        round_id: u64,
        txid: vector<u8>,
        vout: u32,
        amount_sats: u64,
        derivation_address: address,
    }

    struct HashibDepositRegistered has copy, drop {
        record_id: address,
        hashi_request_id: address,
    }

    struct HashibDepositConfirmed has copy, drop {
        record_id: address,
        round_id: u64,
        amount_sats: u64,
    }

    struct HashibDepositFailed has copy, drop {
        record_id: address,
        round_id: u64,
        reason: vector<u8>,
    }

    public fun btc_deposit_address(arg0: &HashiPoolConfig) : vector<u8> {
        arg0.btc_deposit_address
    }

    public fun clear_pending_sats(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut HashiPoolConfig, arg2: u64) {
        if (arg2 >= arg1.pending_sats) {
            arg1.pending_sats = 0;
        } else {
            arg1.pending_sats = arg1.pending_sats - arg2;
        };
    }

    public fun dep_approved() : u8 {
        2
    }

    public fun dep_confirmed() : u8 {
        3
    }

    public fun dep_failed() : u8 {
        4
    }

    public fun dep_registered() : u8 {
        1
    }

    public fun dep_unregistered() : u8 {
        0
    }

    public fun deposit_record_id_for_round(arg0: &HashiPoolConfig, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.deposit_index, arg1)
    }

    public fun derivation_address(arg0: &HashiPoolConfig) : address {
        arg0.derivation_address
    }

    public fun funded_batch_id(arg0: &BlockDepositRecord) : 0x1::option::Option<address> {
        arg0.funded_batch_id
    }

    public fun initialize(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835084876840967);
        let v0 = HashiPoolConfig{
            id                   : 0x2::object::new(arg3),
            derivation_address   : arg1,
            btc_deposit_address  : arg2,
            total_deposits       : 0,
            total_sats_confirmed : 0,
            pending_sats         : 0,
            deposit_index        : 0x2::table::new<u64, address>(arg3),
        };
        let v1 = HashiPoolInitialized{
            config_id           : 0x2::object::uid_to_address(&v0.id),
            derivation_address  : arg1,
            btc_deposit_address : arg2,
        };
        0x2::event::emit<HashiPoolInitialized>(v1);
        0x2::transfer::share_object<HashiPoolConfig>(v0);
    }

    public fun is_confirmed(arg0: &BlockDepositRecord) : bool {
        arg0.status == 3
    }

    public(friend) fun mark_funded(arg0: &mut BlockDepositRecord, arg1: address) {
        assert!(0x1::option::is_none<address>(&arg0.funded_batch_id), 13906836274583175181);
        arg0.funded_batch_id = 0x1::option::some<address>(arg1);
    }

    public fun mark_hashi_approved(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut BlockDepositRecord) {
        assert!(arg1.status == 1, 13906835759186968587);
        arg1.status = 2;
    }

    public fun mark_hashi_confirmed(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut HashiPoolConfig, arg2: &mut BlockDepositRecord, arg3: &0x2::clock::Clock) {
        assert!(arg2.status == 2, 13906835819316510731);
        arg2.status = 3;
        arg2.confirmed_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        arg1.total_sats_confirmed = arg1.total_sats_confirmed + (arg2.amount_sats as u128);
        arg1.pending_sats = arg1.pending_sats + arg2.amount_sats;
        let v0 = HashibDepositConfirmed{
            record_id   : 0x2::object::uid_to_address(&arg2.id),
            round_id    : arg2.round_id,
            amount_sats : arg2.amount_sats,
        };
        0x2::event::emit<HashibDepositConfirmed>(v0);
    }

    public fun mark_hashi_failed(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut BlockDepositRecord, arg2: vector<u8>) {
        assert!(arg1.status == 1 || arg1.status == 2, 13906835926690693131);
        arg1.status = 4;
        arg1.failure_reason = 0x1::option::some<vector<u8>>(arg2);
        let v0 = HashibDepositFailed{
            record_id : 0x2::object::uid_to_address(&arg1.id),
            round_id  : arg1.round_id,
            reason    : arg2,
        };
        0x2::event::emit<HashibDepositFailed>(v0);
    }

    public fun pending_sats(arg0: &HashiPoolConfig) : u64 {
        arg0.pending_sats
    }

    public fun record_amount_sats(arg0: &BlockDepositRecord) : u64 {
        arg0.amount_sats
    }

    public fun record_block_found(arg0: &mut HashiPoolConfig, arg1: &0x2::clock::Clock, arg2: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::BlockFoundClaim, arg3: vector<u8>, arg4: u32, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906835368344813577);
        let v0 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::claim_round_id(arg2);
        let v1 = BlockDepositRecord{
            id               : 0x2::object::new(arg6),
            round_id         : v0,
            txid             : arg3,
            vout             : arg4,
            amount_sats      : arg5,
            hashi_request_id : 0x1::option::none<address>(),
            status           : 0,
            created_at_ms    : 0x2::clock::timestamp_ms(arg1),
            confirmed_at_ms  : 0x1::option::none<u64>(),
            failure_reason   : 0x1::option::none<vector<u8>>(),
            funded_batch_id  : 0x1::option::none<address>(),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0x2::table::add<u64, address>(&mut arg0.deposit_index, v0, v2);
        arg0.total_deposits = arg0.total_deposits + 1;
        let v3 = BlockRewardRecorded{
            record_id   : v2,
            round_id    : v0,
            txid        : arg3,
            vout        : arg4,
            amount_sats : arg5,
        };
        0x2::event::emit<BlockRewardRecorded>(v3);
        0x2::transfer::share_object<BlockDepositRecord>(v1);
    }

    public fun record_hashi_request_id(arg0: &BlockDepositRecord) : 0x1::option::Option<address> {
        arg0.hashi_request_id
    }

    public fun record_round_id(arg0: &BlockDepositRecord) : u64 {
        arg0.round_id
    }

    public fun record_status(arg0: &BlockDepositRecord) : u8 {
        arg0.status
    }

    public fun record_txid(arg0: &BlockDepositRecord) : vector<u8> {
        arg0.txid
    }

    public fun record_vout(arg0: &BlockDepositRecord) : u32 {
        arg0.vout
    }

    public fun register_with_hashi(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &HashiPoolConfig, arg2: &mut BlockDepositRecord, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 13906835604568145931);
        arg2.status = 1;
        let v0 = HashibDepositRequested{
            record_id          : 0x2::object::uid_to_address(&arg2.id),
            round_id           : arg2.round_id,
            txid               : arg2.txid,
            vout               : arg2.vout,
            amount_sats        : arg2.amount_sats,
            derivation_address : arg1.derivation_address,
        };
        0x2::event::emit<HashibDepositRequested>(v0);
    }

    public fun set_hashi_request_id(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut BlockDepositRecord, arg2: address) {
        assert!(arg1.status == 1, 13906835694762459147);
        arg1.hashi_request_id = 0x1::option::some<address>(arg2);
        let v0 = HashibDepositRegistered{
            record_id        : 0x2::object::uid_to_address(&arg1.id),
            hashi_request_id : arg2,
        };
        0x2::event::emit<HashibDepositRegistered>(v0);
    }

    public fun total_deposits(arg0: &HashiPoolConfig) : u64 {
        arg0.total_deposits
    }

    public fun total_sats_confirmed(arg0: &HashiPoolConfig) : u128 {
        arg0.total_sats_confirmed
    }

    public fun update_btc_address(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::PoolAdminCap, arg1: &mut HashiPoolConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835213725859847);
        arg1.btc_deposit_address = arg2;
        let v0 = BtcAddressUpdated{
            config_id   : 0x2::object::uid_to_address(&arg1.id),
            old_address : arg1.btc_deposit_address,
            new_address : arg2,
        };
        0x2::event::emit<BtcAddressUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}


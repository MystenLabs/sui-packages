module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        created_at: u64,
        num_rows: u8,
        authority: address,
        queue_addr: address,
        escrows: 0x2::bag::Bag,
        token_addr: address,
        version: u64,
    }

    struct OracleToken has key {
        id: 0x2::object::UID,
        oracle_addr: address,
        queue_addr: address,
        created_at: u64,
        expires_at: u64,
        updates: 0x2::table::Table<address, Status>,
    }

    struct Status has store {
        last_update: u64,
        owed: u64,
    }

    public(friend) fun new(arg0: vector<u8>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Oracle {
        Oracle{
            id         : 0x2::object::new(arg4),
            name       : arg0,
            created_at : arg3,
            num_rows   : 0,
            authority  : arg1,
            queue_addr : arg2,
            escrows    : 0x2::bag::new(arg4),
            token_addr : @0x0,
            version    : 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(),
        }
    }

    public fun escrow_balance<T0>(arg0: &Oracle, arg1: address) : u64 {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_balance<T0>(&arg0.escrows, arg1)
    }

    public(friend) fun escrow_deposit<T0>(arg0: &mut Oracle, arg1: address, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_deposit<T0>(&mut arg0.escrows, arg1, arg2);
    }

    public(friend) fun escrow_withdraw<T0>(arg0: &mut Oracle, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_withdraw<T0>(&mut arg0.escrows, arg1, arg2, arg3)
    }

    public fun OracleResponseDisagreement() : u8 {
        0
    }

    public fun OracleResponseError() : u8 {
        2
    }

    public fun OracleResponseNoResponse() : u8 {
        3
    }

    public fun OracleResponseSuccess() : u8 {
        1
    }

    public fun authority(arg0: &Oracle) : address {
        arg0.authority
    }

    public fun can_update(arg0: &mut OracleToken, arg1: address, arg2: u64, arg3: u64) : bool {
        if (arg0.expires_at < arg3) {
            false
        } else if (!0x2::table::contains<address, Status>(&mut arg0.updates, arg1)) {
            let v1 = Status{
                last_update : 0,
                owed        : 0,
            };
            0x2::table::add<address, Status>(&mut arg0.updates, arg1, v1);
            true
        } else {
            arg3 - 0x2::table::borrow<address, Status>(&mut arg0.updates, arg1).last_update > arg2
        }
    }

    public fun has_authority(arg0: &Oracle, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    entry fun migrate(arg0: &mut Oracle, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) {
        assert!(arg0.version < 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version();
    }

    public(friend) fun new_oracle_token(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OracleToken {
        OracleToken{
            id          : 0x2::object::new(arg4),
            oracle_addr : arg0,
            queue_addr  : arg1,
            created_at  : arg3,
            expires_at  : arg2,
            updates     : 0x2::table::new<address, Status>(arg4),
        }
    }

    public fun num_rows(arg0: &Oracle) : u8 {
        arg0.num_rows
    }

    public fun oracle_address(arg0: &Oracle) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun oracle_token_address(arg0: &OracleToken) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun oracle_token_data(arg0: &OracleToken) : (address, address, u64, u64) {
        (arg0.oracle_addr, arg0.queue_addr, arg0.expires_at, arg0.created_at)
    }

    public fun queue_addr(arg0: &Oracle) : address {
        arg0.queue_addr
    }

    public fun rewards_owed_to_oracle(arg0: &OracleToken, arg1: address) : u64 {
        0x2::table::borrow<address, Status>(&arg0.updates, arg1).owed
    }

    public(friend) fun set_configs(arg0: &mut Oracle, arg1: vector<u8>, arg2: address, arg3: address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.name = arg1;
        arg0.authority = arg2;
        arg0.queue_addr = arg3;
    }

    public(friend) fun set_token_addr(arg0: &mut Oracle, arg1: address) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.token_addr = arg1;
    }

    public fun share_oracle(arg0: Oracle) {
        0x2::transfer::share_object<Oracle>(arg0);
    }

    public fun token_addr(arg0: &Oracle) : address {
        arg0.token_addr
    }

    public fun transfer_oracle_token(arg0: OracleToken, arg1: address) {
        0x2::transfer::transfer<OracleToken>(arg0, arg1);
    }

    public(friend) fun update_aggregator(arg0: &mut OracleToken, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, Status>(&mut arg0.updates, arg1);
        assert!(arg2 > v0.last_update, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        v0.owed = v0.owed + 1;
        v0.last_update = arg2;
    }

    public(friend) fun update_oracle_token(arg0: &mut OracleToken, arg1: u64) {
        arg0.expires_at = arg1;
    }

    // decompiled from Move bytecode v6
}


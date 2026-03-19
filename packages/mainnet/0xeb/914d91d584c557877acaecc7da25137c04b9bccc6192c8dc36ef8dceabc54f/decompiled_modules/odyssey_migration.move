module 0xeb914d91d584c557877acaecc7da25137c04b9bccc6192c8dc36ef8dceabc54f::odyssey_migration {
    struct OdysseyConfig has store, key {
        id: 0x2::object::UID,
        treasury: address,
        migration_fee: u64,
    }

    struct OdysseyAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct PoolState has store, key {
        id: 0x2::object::UID,
        completed: bool,
        total_sui_raised: u64,
    }

    struct MigrationEvent has copy, drop {
        user: address,
        sui_amount: u64,
        token_amount: u64,
    }

    public fun complete_migration(arg0: &mut PoolState, arg1: &OdysseyConfig, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg2, arg1.migration_fee), arg5), arg1.treasury);
        arg0.completed = true;
        arg0.total_sui_raised = v0;
        let v1 = MigrationEvent{
            user         : 0x2::tx_context::sender(arg5),
            sui_amount   : v0,
            token_amount : 0x2::balance::value<0x2::sui::SUI>(arg3),
        };
        0x2::event::emit<MigrationEvent>(v1);
    }

    public fun create_pool(arg0: &OdysseyConfig, arg1: &mut 0x2::tx_context::TxContext) : PoolState {
        PoolState{
            id               : 0x2::object::new(arg1),
            completed        : false,
            total_sui_raised : 0,
        }
    }

    public fun get_total_raised(arg0: &PoolState) : u64 {
        arg0.total_sui_raised
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OdysseyConfig{
            id            : 0x2::object::new(arg0),
            treasury      : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
            migration_fee : 100000000000,
        };
        0x2::transfer::share_object<OdysseyConfig>(v0);
        let v1 = OdysseyAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OdysseyAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_completed(arg0: &PoolState) : bool {
        arg0.completed
    }

    // decompiled from Move bytecode v6
}


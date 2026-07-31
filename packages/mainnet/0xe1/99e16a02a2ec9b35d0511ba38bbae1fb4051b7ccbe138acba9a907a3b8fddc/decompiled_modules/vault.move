module 0xe199e16a02a2ec9b35d0511ba38bbae1fb4051b7ccbe138acba9a907a3b8fddc::vault {
    struct HouseCap has store, key {
        id: 0x2::object::UID,
        house: address,
    }

    struct Contribution has drop, store {
        amount: u64,
        epoch: u64,
    }

    struct TableVault has key {
        id: 0x2::object::UID,
        table_id: vector<u8>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        contributions: 0x2::table::Table<address, Contribution>,
        created_epoch: u64,
        max_settle: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        table_id: vector<u8>,
    }

    struct BuyInEvent has copy, drop {
        vault: 0x2::object::ID,
        table_id: vector<u8>,
        player: address,
        amount: u64,
    }

    struct SettleEvent has copy, drop {
        vault: 0x2::object::ID,
        player: address,
        payout: u64,
    }

    struct RakeEvent has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    struct ReclaimEvent has copy, drop {
        vault: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    public fun balance_of(arg0: &TableVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun buy_in(arg0: &mut TableVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::table::contains<address, Contribution>(&arg0.contributions, v1)) {
            let v2 = 0x2::table::borrow_mut<address, Contribution>(&mut arg0.contributions, v1);
            v2.amount = v2.amount + v0;
            v2.epoch = 0x2::tx_context::epoch(arg2);
        } else {
            let v3 = Contribution{
                amount : v0,
                epoch  : 0x2::tx_context::epoch(arg2),
            };
            0x2::table::add<address, Contribution>(&mut arg0.contributions, v1, v3);
        };
        let v4 = BuyInEvent{
            vault    : 0x2::object::id<TableVault>(arg0),
            table_id : arg0.table_id,
            player   : v1,
            amount   : v0,
        };
        0x2::event::emit<BuyInEvent>(v4);
    }

    public fun contribution(arg0: &TableVault, arg1: address) : u64 {
        if (0x2::table::contains<address, Contribution>(&arg0.contributions, arg1)) {
            0x2::table::borrow<address, Contribution>(&arg0.contributions, arg1).amount
        } else {
            0
        }
    }

    public fun create_vault(arg0: &HouseCap, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg3), 0);
        let v0 = TableVault{
            id            : 0x2::object::new(arg3),
            table_id      : arg1,
            funds         : 0x2::balance::zero<0x2::sui::SUI>(),
            contributions : 0x2::table::new<address, Contribution>(arg3),
            created_epoch : 0x2::tx_context::epoch(arg3),
            max_settle    : arg2,
        };
        let v1 = VaultCreated{
            vault    : 0x2::object::id<TableVault>(&v0),
            table_id : v0.table_id,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<TableVault>(v0);
    }

    public fun house(arg0: &HouseCap) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{
            id    : 0x2::object::new(arg0),
            house : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun reclaim(arg0: &mut TableVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Contribution>(&arg0.contributions, v0), 3);
        assert!(0x2::tx_context::epoch(arg1) >= 0x2::table::borrow<address, Contribution>(&arg0.contributions, v0).epoch + 7, 2);
        let v1 = 0x2::table::remove<address, Contribution>(&mut arg0.contributions, v0);
        let v2 = v1.amount;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.funds);
        let v4 = if (v2 <= v3) {
            v2
        } else {
            v3
        };
        assert!(v4 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v4), arg1), v0);
        let v5 = ReclaimEvent{
            vault  : 0x2::object::id<TableVault>(arg0),
            player : v0,
            amount : v4,
        };
        0x2::event::emit<ReclaimEvent>(v5);
    }

    public fun settle(arg0: &HouseCap, arg1: &mut TableVault, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg4), 0);
        assert!(arg3 <= arg1.max_settle, 7);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.funds), 1);
        if (0x2::table::contains<address, Contribution>(&arg1.contributions, arg2)) {
            0x2::table::remove<address, Contribution>(&mut arg1.contributions, arg2);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, arg3), arg4), arg2);
        };
        let v0 = SettleEvent{
            vault  : 0x2::object::id<TableVault>(arg1),
            player : arg2,
            payout : arg3,
        };
        0x2::event::emit<SettleEvent>(v0);
    }

    public fun sweep_and_close(arg0: &HouseCap, arg1: TableVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg2), 0);
        let TableVault {
            id            : v0,
            table_id      : _,
            funds         : v2,
            contributions : v3,
            created_epoch : _,
            max_settle    : _,
        } = arg1;
        let v6 = v3;
        let v7 = v2;
        let v8 = v0;
        assert!(0x2::table::is_empty<address, Contribution>(&v6), 6);
        0x2::table::destroy_empty<address, Contribution>(v6);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg2), arg0.house);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        };
        let v10 = RakeEvent{
            vault  : 0x2::object::uid_to_inner(&v8),
            amount : v9,
        };
        0x2::event::emit<RakeEvent>(v10);
        0x2::object::delete(v8);
    }

    public fun table_id(arg0: &TableVault) : vector<u8> {
        arg0.table_id
    }

    // decompiled from Move bytecode v7
}


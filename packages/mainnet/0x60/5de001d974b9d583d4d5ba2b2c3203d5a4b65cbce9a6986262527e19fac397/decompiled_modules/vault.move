module 0x605de001d974b9d583d4d5ba2b2c3203d5a4b65cbce9a6986262527e19fac397::vault {
    struct HouseCap has store, key {
        id: 0x2::object::UID,
        house: address,
    }

    struct TableVault has key {
        id: 0x2::object::UID,
        table_id: vector<u8>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        contributions: 0x2::table::Table<address, u64>,
        created_epoch: u64,
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
        if (0x2::table::contains<address, u64>(&arg0.contributions, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, v1, v0);
        };
        let v3 = BuyInEvent{
            vault    : 0x2::object::id<TableVault>(arg0),
            table_id : arg0.table_id,
            player   : v1,
            amount   : v0,
        };
        0x2::event::emit<BuyInEvent>(v3);
    }

    public fun contribution(arg0: &TableVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.contributions, arg1)
        } else {
            0
        }
    }

    public fun create_vault(arg0: &HouseCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg2), 0);
        let v0 = TableVault{
            id            : 0x2::object::new(arg2),
            table_id      : arg1,
            funds         : 0x2::balance::zero<0x2::sui::SUI>(),
            contributions : 0x2::table::new<address, u64>(arg2),
            created_epoch : 0x2::tx_context::epoch(arg2),
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
        assert!(0x2::tx_context::epoch(arg1) >= arg0.created_epoch + 7, 2);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, v0), 3);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.contributions, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.funds);
        let v3 = if (v1 <= v2) {
            v1
        } else {
            v2
        };
        assert!(v3 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v3), arg1), v0);
        let v4 = ReclaimEvent{
            vault  : 0x2::object::id<TableVault>(arg0),
            player : v0,
            amount : v3,
        };
        0x2::event::emit<ReclaimEvent>(v4);
    }

    public fun settle(arg0: &HouseCap, arg1: &mut TableVault, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg4), 0);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.funds), 1);
        if (0x2::table::contains<address, u64>(&arg1.contributions, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.contributions, arg2);
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
        } = arg1;
        let v5 = v3;
        let v6 = v2;
        let v7 = v0;
        assert!(0x2::table::is_empty<address, u64>(&v5), 6);
        0x2::table::destroy_empty<address, u64>(v5);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), arg0.house);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v9 = RakeEvent{
            vault  : 0x2::object::uid_to_inner(&v7),
            amount : v8,
        };
        0x2::event::emit<RakeEvent>(v9);
        0x2::object::delete(v7);
    }

    public fun table_id(arg0: &TableVault) : vector<u8> {
        arg0.table_id
    }

    // decompiled from Move bytecode v7
}


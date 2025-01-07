module 0x14bd70e4823bb2d929a6e84607576865c69a042b95311969a3920e7fa9272add::suigallerie {
    struct DeployRecord has key {
        id: 0x2::object::UID,
        version: u64,
        space_ids: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        per_gas: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Space<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DeployEvent has copy, drop {
        deployer: address,
        space: 0x2::object::ID,
    }

    struct AddFund has copy, drop {
        space: 0x2::object::ID,
        value: u64,
        coinType: 0x1::ascii::String,
        sender: address,
    }

    struct AddGas has copy, drop {
        space: 0x2::object::ID,
        value: u64,
        sender: address,
    }

    struct AirDrop has copy, drop {
        space: 0x2::object::ID,
        sender: address,
    }

    public entry fun add_fund<T0>(arg0: &mut Space<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        add_fund_non_entry<T0>(arg0, arg1, arg2);
    }

    public fun add_fund_non_entry<T0>(arg0: &mut Space<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AddFund{
            space    : 0x2::object::id<Space<T0>>(arg0),
            value    : 0x2::coin::value<T0>(&arg1),
            coinType : 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()),
            sender   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddFund>(v0);
    }

    public entry fun add_gas<T0>(arg0: &mut Space<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = AddGas{
            space  : 0x2::object::id<Space<T0>>(arg0),
            value  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddGas>(v0);
    }

    public fun airdrop<T0>(arg0: &AdminCap, arg1: &DeployRecord, arg2: &mut Space<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 1);
        let v0 = 0x1::vector::length<address>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.gas, v0 * arg1.per_gas, arg5), 0x2::tx_context::sender(arg5));
        while (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, 0x1::vector::pop_back<u64>(&mut arg4), arg5), 0x1::vector::pop_back<address>(&mut arg3));
            v0 = v0 - 1;
        };
        let v1 = AirDrop{
            space  : 0x2::object::id<Space<T0>>(arg2),
            sender : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AirDrop>(v1);
    }

    public fun balance_value<T0>(arg0: &Space<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun deploy_space<T0>(arg0: &mut DeployRecord, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Space<T0>>(deploy_space_non_entry<T0>(arg0, arg1, arg2));
    }

    public fun deploy_space_non_entry<T0>(arg0: &mut DeployRecord, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : Space<T0> {
        assert!(arg0.version == 1, 0);
        let v0 = Space<T0>{
            id      : 0x2::object::new(arg2),
            version : 1,
            balance : 0x2::balance::zero<T0>(),
            gas     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = 0x2::object::id<Space<T0>>(&v0);
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.space_ids, arg1, v1);
        let v2 = DeployEvent{
            deployer : 0x2::tx_context::sender(arg2),
            space    : v1,
        };
        0x2::event::emit<DeployEvent>(v2);
        v0
    }

    public fun gas_value<T0>(arg0: &Space<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DeployRecord{
            id        : 0x2::object::new(arg0),
            version   : 1,
            space_ids : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
            per_gas   : 3000000,
        };
        0x2::transfer::share_object<DeployRecord>(v1);
    }

    public fun set_per_gas(arg0: &AdminCap, arg1: &mut DeployRecord, arg2: u64) {
        arg1.per_gas = arg2;
    }

    public fun withdraw_coin_to<T0>(arg0: &AdminCap, arg1: &mut Space<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg3, arg4), arg2);
    }

    public fun withdraw_gas_to<T0>(arg0: &AdminCap, arg1: &mut Space<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.gas, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}


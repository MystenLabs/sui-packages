module 0xbba7b50e9ea178e138fec87973d3ce1bc405e47e6667dc72fa85d7ebba202da::gas_station {
    struct GasStation has key {
        id: 0x2::object::UID,
        allowed_objects: 0x2::table::Table<0x2::object::ID, bool>,
        available_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        admins: vector<address>,
        refill_to_value: u64,
    }

    struct AdminAddedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        admin: address,
    }

    struct AllowedObjectAddedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        object: 0x2::object::ID,
    }

    struct AllowedObjectRemovedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        object: 0x2::object::ID,
    }

    struct GasStationFundsAddedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    struct GasStationFundsRemovedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    struct GasObjectFundsRechargedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    struct GasObjectFundsDecreasedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    public fun add_admin(arg0: &mut GasStation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAddedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            admin       : arg1,
        };
        0x2::event::emit<AdminAddedEvent>(v0);
    }

    public fun add_allowed_object(arg0: &mut GasStation, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.allowed_objects, arg1, true);
        let v0 = AllowedObjectAddedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            object      : arg1,
        };
        0x2::event::emit<AllowedObjectAddedEvent>(v0);
    }

    public fun add_funds(arg0: &mut GasStation, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_funds, v0);
        let v1 = GasStationFundsAddedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<GasStationFundsAddedEvent>(v1);
    }

    fun assert_is_admin(arg0: &GasStation, arg1: address) {
        assert!(is_admin(arg0, arg1), 1);
    }

    fun assert_is_allowed_object_id(arg0: &GasStation, arg1: 0x2::object::ID) {
        assert!(is_allowed_object_id(arg0, arg1), 4);
    }

    fun is_admin(arg0: &GasStation, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    fun is_allowed_object_id(arg0: &GasStation, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.allowed_objects, arg1)
    }

    public fun new_gas_station(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id              : 0x2::object::new(arg1),
            allowed_objects : 0x2::table::new<0x2::object::ID, bool>(arg1),
            available_funds : 0x2::balance::zero<0x2::sui::SUI>(),
            admins          : vector[],
            refill_to_value : arg0,
        };
        0x1::vector::push_back<address>(&mut v0.admins, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GasStation>(v0);
    }

    public fun recharge_funds(arg0: &mut GasStation, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_allowed_object_id(arg0, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1));
        let v0 = arg0.refill_to_value - 0x2::coin::value<0x2::sui::SUI>(arg1);
        0x2::coin::join<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_funds, v0), arg2));
        let v1 = GasObjectFundsRechargedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            amount      : v0,
        };
        0x2::event::emit<GasObjectFundsRechargedEvent>(v1);
    }

    public fun remove_admin(arg0: &mut GasStation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemovedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            admin       : arg1,
        };
        0x2::event::emit<AdminRemovedEvent>(v2);
    }

    public fun remove_allowed_object(arg0: &mut GasStation, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.allowed_objects, arg1);
        let v0 = AllowedObjectRemovedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            object      : arg1,
        };
        0x2::event::emit<AllowedObjectRemovedEvent>(v0);
    }

    public fun remove_funds(arg0: &mut GasStation, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_allowed_object_id(arg0, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1));
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1) - arg0.refill_to_value;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_funds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg2)));
        let v1 = GasObjectFundsDecreasedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            amount      : v0,
        };
        0x2::event::emit<GasObjectFundsDecreasedEvent>(v1);
    }

    public fun withdraw_funds(arg0: &mut GasStation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_funds, arg1);
        let v1 = GasStationFundsRemovedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<GasStationFundsRemovedEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
    }

    // decompiled from Move bytecode v6
}


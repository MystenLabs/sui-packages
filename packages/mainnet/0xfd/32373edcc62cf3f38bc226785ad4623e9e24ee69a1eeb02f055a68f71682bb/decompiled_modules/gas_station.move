module 0xfd32373edcc62cf3f38bc226785ad4623e9e24ee69a1eeb02f055a68f71682bb::gas_station {
    struct GasStation has key {
        id: 0x2::object::UID,
        available_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        admins: vector<address>,
        gas_signer: address,
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

    struct GasStationFundsAddedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    struct GasStationFundsRemovedEvent has copy, drop {
        gas_station: 0x2::object::ID,
        amount: u64,
    }

    struct GasObjectFundsRefilledEvent has copy, drop {
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

    public fun add_funds(arg0: &mut GasStation, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        new_gas_station(500000000, v0, @0x8526da49a364ebba2faa8a68fcbb8c70d8db2a0f6c9750025354f7fc20137e92, arg0);
    }

    fun is_admin(arg0: &GasStation, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun new_gas_station(arg0: u64, arg1: vector<address>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id              : 0x2::object::new(arg3),
            available_funds : 0x2::balance::zero<0x2::sui::SUI>(),
            admins          : arg1,
            gas_signer      : arg2,
            refill_to_value : arg0,
        };
        0x2::transfer::share_object<GasStation>(v0);
    }

    public fun refill_funds(arg0: &mut GasStation, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg2);
        assert!(*0x1::option::borrow<address>(&v0) == arg0.gas_signer, 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        if (arg0.refill_to_value > v1) {
            let v2 = arg0.refill_to_value - v1;
            0x2::coin::join<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_funds, v2), arg2));
            let v3 = GasObjectFundsRefilledEvent{
                gas_station : 0x2::object::id<GasStation>(arg0),
                amount      : v2,
            };
            0x2::event::emit<GasObjectFundsRefilledEvent>(v3);
        } else {
            let v4 = v1 - arg0.refill_to_value;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_funds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v4, arg2)));
            let v5 = GasObjectFundsDecreasedEvent{
                gas_station : 0x2::object::id<GasStation>(arg0),
                amount      : v4,
            };
            0x2::event::emit<GasObjectFundsDecreasedEvent>(v5);
        };
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

    public fun remove_funds(arg0: &mut GasStation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_funds, arg1);
        let v1 = GasStationFundsRemovedEvent{
            gas_station : 0x2::object::id<GasStation>(arg0),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<GasStationFundsRemovedEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
    }

    public fun set_gas_signer(arg0: &mut GasStation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.gas_signer = arg1;
    }

    // decompiled from Move bytecode v6
}


module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::collector {
    struct COLLECTOR has drop {
        dummy_field: bool,
    }

    struct CollectorAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Collector has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        auto_collect_recipient: 0x1::option::Option<address>,
    }

    public fun transfer(arg0: &mut Collector, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.auto_collect_recipient), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), *0x1::option::borrow<address>(&arg0.auto_collect_recipient));
    }

    public(friend) fun collect(arg0: &mut Collector, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun init(arg0: COLLECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CollectorAdminCap>(v0, @0x8233bf6971d0819edf3684b276bb03d4b7c005931909206564b71855d37145a1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COLLECTOR>(arg0, arg1), @0x8233bf6971d0819edf3684b276bb03d4b7c005931909206564b71855d37145a1);
        let v1 = Collector{
            id                     : 0x2::object::new(arg1),
            balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            auto_collect_recipient : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Collector>(v1);
    }

    public fun set_auto_collect_recipient(arg0: &mut Collector, arg1: &CollectorAdminCap, arg2: 0x1::option::Option<address>) {
        arg0.auto_collect_recipient = arg2;
    }

    public fun withdraw(arg0: &mut Collector, arg1: &CollectorAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    public fun withdraw_all(arg0: &mut Collector, arg1: &CollectorAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}


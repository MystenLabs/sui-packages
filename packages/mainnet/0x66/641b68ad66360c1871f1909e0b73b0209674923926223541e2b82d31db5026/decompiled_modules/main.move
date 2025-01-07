module 0x66641b68ad66360c1871f1909e0b73b0209674923926223541e2b82d31db5026::main {
    struct OwnerCapability has key {
        id: 0x2::object::UID,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct Banking has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit_sui(arg0: &mut Banking, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Banking{
            id          : 0x2::object::new(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Banking>(v0);
        let v1 = OwnerCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCapability>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw_sui(arg0: &OwnerCapability, arg1: &mut Banking, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


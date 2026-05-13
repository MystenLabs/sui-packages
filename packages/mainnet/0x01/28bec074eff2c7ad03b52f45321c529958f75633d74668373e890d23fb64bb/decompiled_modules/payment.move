module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment {
    struct FormTreasury has key {
        id: 0x2::object::UID,
        form_id: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun form_id(arg0: &FormTreasury) : address {
        arg0.form_id
    }

    public fun balance_value(arg0: &FormTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun create(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &mut 0x2::tx_context::TxContext) : FormTreasury {
        FormTreasury{
            id      : 0x2::object::new(arg1),
            form_id : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun create_and_share(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        share(create(arg0, arg1));
    }

    public(friend) fun deposit_fee(arg0: &mut FormTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_payment_deposited(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_payment_deposited(arg0.form_id, arg3, v0));
        v0
    }

    public fun share(arg0: FormTreasury) {
        0x2::transfer::share_object<FormTreasury>(arg0);
    }

    public fun withdraw(arg0: &mut FormTreasury, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg1) == arg0.form_id, 1);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_payment_withdrawn(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_payment_withdrawn(arg0.form_id, 0x2::tx_context::sender(arg3), arg2));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    public fun withdraw_all(arg0: &mut FormTreasury, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg1) == arg0.form_id, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        withdraw(arg0, arg1, v0, arg2)
    }

    // decompiled from Move bytecode v6
}


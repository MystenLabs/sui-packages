module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account {
    struct TraderAccount has key {
        id: 0x2::object::UID,
        owner: address,
        profit_address: address,
        positions: 0x2::bag::Bag,
    }

    public(friend) fun add_position<T0: store + key>(arg0: &mut TraderAccount, arg1: T0) {
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.positions, 0x2::object::id<T0>(&arg1), arg1);
    }

    public fun assert_owner(arg0: &TraderAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public fun borrow_mut_position<T0: store + key>(arg0: &mut TraderAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        assert_owner(arg0, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1), 2);
        0x2::bag::borrow_mut<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public(friend) fun create(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TraderAccount {
        TraderAccount{
            id             : 0x2::object::new(arg2),
            owner          : arg0,
            profit_address : arg1,
            positions      : 0x2::bag::new(arg2),
        }
    }

    public fun owner(arg0: &TraderAccount) : address {
        arg0.owner
    }

    public fun profit_address(arg0: &TraderAccount) : address {
        arg0.profit_address
    }

    public(friend) fun share_account(arg0: TraderAccount) {
        0x2::transfer::share_object<TraderAccount>(arg0);
    }

    public fun take_position<T0: store + key>(arg0: &mut TraderAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1), 2);
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public(friend) fun update_owner(arg0: &mut TraderAccount, arg1: address) {
        arg0.owner = arg1;
    }

    public(friend) fun update_profit_address(arg0: &mut TraderAccount, arg1: address) {
        arg0.profit_address = arg1;
    }

    // decompiled from Move bytecode v6
}


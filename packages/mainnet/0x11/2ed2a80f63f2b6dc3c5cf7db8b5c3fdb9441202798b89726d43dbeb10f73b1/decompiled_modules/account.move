module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account {
    struct AccountParams has copy, drop, store {
        tag: vector<u8>,
        owner: address,
        profit_address: address,
        slot: vector<u8>,
    }

    struct TraderAccount has key {
        id: 0x2::object::UID,
        info: AccountParams,
        positions: 0x2::bag::Bag,
    }

    public(friend) fun add_position<T0: store + key>(arg0: &mut TraderAccount, arg1: T0, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_owner(arg0, arg2);
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.positions, v0, arg1);
        v0
    }

    public(friend) fun assert_owner(arg0: &TraderAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.info.owner, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::not_authorized());
    }

    public(friend) fun borrow_mut_position<T0: store + key>(arg0: &mut TraderAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        assert_owner(arg0, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1), 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::position_not_found());
        0x2::bag::borrow_mut<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    fun bytes_to_params(arg0: vector<u8>) : AccountParams {
        let v0 = 0x2::bcs::new(arg0);
        AccountParams{
            tag            : 0x2::bcs::peel_vec_u8(&mut v0),
            owner          : 0x2::bcs::peel_address(&mut v0),
            profit_address : 0x2::bcs::peel_address(&mut v0),
            slot           : 0x2::bcs::peel_vec_u8(&mut v0),
        }
    }

    public(friend) fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : TraderAccount {
        TraderAccount{
            id        : 0x2::object::new(arg1),
            info      : bytes_to_params(arg0),
            positions : 0x2::bag::new(arg1),
        }
    }

    public fun has_position(arg0: &TraderAccount, arg1: 0x2::object::ID) : bool {
        0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1)
    }

    public fun owner(arg0: &TraderAccount) : address {
        arg0.info.owner
    }

    public fun positions_size(arg0: &TraderAccount) : u64 {
        0x2::bag::length(&arg0.positions)
    }

    public fun profit_address(arg0: &TraderAccount) : address {
        arg0.info.profit_address
    }

    public(friend) fun share_account(arg0: TraderAccount) {
        0x2::transfer::share_object<TraderAccount>(arg0);
    }

    public fun tag(arg0: &TraderAccount) : vector<u8> {
        arg0.info.tag
    }

    public fun take_position<T0: store + key>(arg0: &mut TraderAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1), 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::position_not_found());
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public(friend) fun update_owner(arg0: &mut TraderAccount, arg1: address) {
        arg0.info.owner = arg1;
    }

    public(friend) fun update_profit_address(arg0: &mut TraderAccount, arg1: address) {
        arg0.info.profit_address = arg1;
    }

    public(friend) fun update_profit_tag(arg0: &mut TraderAccount, arg1: vector<u8>) {
        arg0.info.tag = arg1;
    }

    // decompiled from Move bytecode v6
}


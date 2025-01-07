module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite {
    struct Invite has store, key {
        id: 0x2::object::UID,
        inviters: 0x2::vec_map::VecMap<address, address>,
        root: address,
        inviter_fee: u64,
    }

    struct Bind has copy, drop {
        sender: address,
        inviter: address,
    }

    public(friend) fun new(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Invite{
            id          : 0x2::object::new(arg2),
            inviters    : 0x2::vec_map::empty<address, address>(),
            root        : arg0,
            inviter_fee : arg1,
        };
        0x2::transfer::public_share_object<Invite>(v0);
    }

    public fun assert_already_bind_inviter(arg0: &Invite, arg1: address) {
        assert!(!0x2::vec_map::contains<address, address>(&arg0.inviters, &arg1), 3);
    }

    public fun assert_invalid_inviter(arg0: &Invite, arg1: address) {
        assert!(&arg1 == &arg0.root || 0x2::vec_map::contains<address, address>(&arg0.inviters, &arg1), 2);
    }

    public fun assert_invalid_sender(arg0: &Invite, arg1: address) {
        assert!(!(&arg1 == &arg0.root), 1);
    }

    public fun assert_not_bind_inviter(arg0: &Invite, arg1: address) {
        assert!(0x2::vec_map::contains<address, address>(&arg0.inviters, &arg1), 4);
    }

    entry fun bind(arg0: &mut Invite, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_invalid_sender(arg0, v0);
        assert_invalid_inviter(arg0, arg1);
        assert_already_bind_inviter(arg0, v0);
        0x2::vec_map::insert<address, address>(&mut arg0.inviters, v0, arg1);
        let v1 = Bind{
            sender  : v0,
            inviter : arg1,
        };
        0x2::event::emit<Bind>(v1);
    }

    public fun inviter_fee(arg0: &Invite) : u64 {
        arg0.inviter_fee
    }

    public fun inviters(arg0: &Invite, arg1: address) : address {
        if (0x2::vec_map::contains<address, address>(&arg0.inviters, &arg1)) {
            *0x2::vec_map::get<address, address>(&arg0.inviters, &arg1)
        } else {
            0x2::address::from_u256(0)
        }
    }

    public(friend) fun modify(arg0: &mut Invite, arg1: address, arg2: u64) {
        arg0.root = arg1;
        arg0.inviter_fee = arg2;
    }

    public fun root(arg0: &Invite) : address {
        arg0.root
    }

    // decompiled from Move bytecode v6
}


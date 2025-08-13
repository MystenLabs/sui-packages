module 0xe1dcfb8419fc65ccfe8daf2815b7b29969e578edf52724faf27f6c35bff5d615::core {
    struct InviteeAdded has copy, drop {
        invitee: address,
        inviter: address,
    }

    struct InviteeUpdated has copy, drop {
        invitee: address,
        inviter: address,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        version: u64,
        invitees: 0x2::table::Table<address, address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CORE has drop {
        dummy_field: bool,
    }

    public fun borrow_invitees(arg0: &State) : &0x2::table::Table<address, address> {
        &arg0.invitees
    }

    fun borrow_mut_invitees(arg0: &mut State) : &mut 0x2::table::Table<address, address> {
        &mut arg0.invitees
    }

    public fun get_inviter(arg0: &State, arg1: address) : address {
        *0x2::table::borrow<address, address>(&arg0.invitees, arg1)
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id       : 0x2::object::new(arg1),
            version  : 1,
            invitees : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::public_share_object<State>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_invitation(arg0: &AdminCap, arg1: &mut State, arg2: address, arg3: address) {
        let v0 = borrow_mut_invitees(arg1);
        assert!(!0x2::table::contains<address, address>(v0, arg2), 13906834410566582273);
        0x2::table::add<address, address>(v0, arg2, arg3);
        let v1 = InviteeAdded{
            invitee : arg2,
            inviter : arg3,
        };
        0x2::event::emit<InviteeAdded>(v1);
    }

    public fun is_invitee(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.invitees, arg1)
    }

    public fun update_invitation(arg0: &AdminCap, arg1: &mut State, arg2: address, arg3: address) {
        let v0 = borrow_mut_invitees(arg1);
        assert!(0x2::table::contains<address, address>(v0, arg2), 13906834483581026305);
        0x2::table::add<address, address>(v0, arg2, arg3);
        let v1 = InviteeUpdated{
            invitee : arg2,
            inviter : arg3,
        };
        0x2::event::emit<InviteeUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}


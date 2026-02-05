module 0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::watchtower {
    struct WATCHTOWER has drop {
        dummy_field: bool,
    }

    struct Watchtower has key {
        id: 0x2::object::UID,
        addresses: 0x2::vec_set::VecSet<address>,
    }

    public fun add_watchtower(arg0: &mut Watchtower, arg1: &0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::auth::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.addresses, arg2);
        0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::structs::emit_watchtower_added(arg2);
    }

    public(friend) fun assert_sender(arg0: &Watchtower, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.addresses, &v0), 54);
    }

    fun init(arg0: WATCHTOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Watchtower{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Watchtower>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<WATCHTOWER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_watchtower(arg0: &mut Watchtower, arg1: &0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::auth::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<address>(&mut arg0.addresses, &arg2);
        0x4250caa0a1174f0eec43c8b35c73e060595a24dc4121c767e82d538f4d9cde19::structs::emit_watchtower_removed(arg2);
    }

    // decompiled from Move bytecode v6
}


module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        form_id: address,
        members: 0x2::vec_set::VecSet<address>,
    }

    public fun contains(arg0: &Allowlist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun remove(arg0: &mut Allowlist, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: address) {
        assert_cap(arg0, arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg2);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_allowlist_updated(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_allowlist_updated(0x2::object::uid_to_address(&arg0.id), arg0.form_id, arg2, false));
    }

    public fun add(arg0: &mut Allowlist, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: address) {
        assert_cap(arg0, arg1);
        assert!(!0x2::vec_set::contains<address>(&arg0.members, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.members, arg2);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_allowlist_updated(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_allowlist_updated(0x2::object::uid_to_address(&arg0.id), arg0.form_id, arg2, true));
    }

    public fun add_many(arg0: &mut Allowlist, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: vector<address>) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_set::contains<address>(&arg0.members, &v1)) {
                0x2::vec_set::insert<address>(&mut arg0.members, v1);
                0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_allowlist_updated(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_allowlist_updated(0x2::object::uid_to_address(&arg0.id), arg0.form_id, v1, true));
            };
            v0 = v0 + 1;
        };
    }

    fun assert_cap(arg0: &Allowlist, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg1) == arg0.form_id, 3);
    }

    public fun create(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Allowlist {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg0);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_allowlist_created(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_allowlist_created(0x2::object::uid_to_address(&v0), v1, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1)));
        Allowlist{
            id      : v0,
            form_id : v1,
            members : 0x2::vec_set::empty<address>(),
        }
    }

    public fun create_and_share(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        share(create(arg0, arg1, arg2));
    }

    public fun form_id(arg0: &Allowlist) : address {
        arg0.form_id
    }

    public fun share(arg0: Allowlist) {
        0x2::transfer::share_object<Allowlist>(arg0);
    }

    public fun size(arg0: &Allowlist) : u64 {
        0x2::vec_set::length<address>(&arg0.members)
    }

    // decompiled from Move bytecode v6
}


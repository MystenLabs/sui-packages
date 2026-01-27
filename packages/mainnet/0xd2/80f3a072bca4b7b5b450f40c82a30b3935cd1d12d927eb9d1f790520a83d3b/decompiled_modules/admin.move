module 0xd280f3a072bca4b7b5b450f40c82a30b3935cd1d12d927eb9d1f790520a83d3b::admin {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        authority: 0x2::vec_set::VecSet<address>,
        u64_padding: vector<u64>,
    }

    public(friend) fun add_tails_exp_amount(arg0: &Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: address, arg4: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(0x2::dynamic_field::borrow<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg3, arg4);
    }

    entry fun add_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &arg1), 0);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id          : 0x2::object::new(arg0),
            value       : 2,
            authority   : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            u64_padding : vector[],
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun install_ecosystem_manager_cap_entry(arg0: &mut Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg0.id, 0x1::string::utf8(b"ecosystem_manager_cap"), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::issue_manager_cap(arg1, arg2));
    }

    entry fun remove_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &arg1), 1);
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
        assert!(0x2::vec_set::length<address>(&arg0.authority) > 0, 2);
    }

    entry fun upgrade(arg0: &mut Version) {
        version_check(arg0);
        arg0.value = 2;
    }

    public(friend) fun verify(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 4);
    }

    public(friend) fun version_check(arg0: &Version) {
        assert!(2 >= arg0.value, 3);
    }

    // decompiled from Move bytecode v6
}


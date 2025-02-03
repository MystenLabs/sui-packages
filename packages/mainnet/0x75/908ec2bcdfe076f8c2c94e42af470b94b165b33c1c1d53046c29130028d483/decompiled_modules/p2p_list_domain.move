module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::p2p_list_domain {
    struct P2PListDomain has store {
        lists: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun empty() : P2PListDomain {
        P2PListDomain{lists: 0x2::vec_set::empty<0x2::object::ID>()}
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: P2PListDomain) {
        assert_no_transfer_allowlist(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<P2PListDomain>(), arg1);
    }

    public fun add_id<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: &0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::Authlist) {
        let v0 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut borrow_domain_mut(v0).lists, 0x2::object::id<0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::Authlist>(arg2));
    }

    public fun assert_no_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 1);
    }

    public fun assert_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_allowlists(arg0: &P2PListDomain) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.lists
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<P2PListDomain>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<P2PListDomain>())
    }

    public fun delete(arg0: P2PListDomain) {
        let P2PListDomain {  } = arg0;
    }

    public fun from_id(arg0: 0x2::object::ID) : P2PListDomain {
        P2PListDomain{lists: 0x2::vec_set::singleton<0x2::object::ID>(arg0)}
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<P2PListDomain>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<P2PListDomain>())
    }

    public fun remove_id<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut borrow_domain_mut(v0).lists, &arg2);
    }

    // decompiled from Move bytecode v6
}


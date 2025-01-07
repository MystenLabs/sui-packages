module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::creators {
    struct Creators has store {
        creators: 0x2::vec_set::VecSet<address>,
    }

    public fun empty() : Creators {
        Creators{creators: 0x2::vec_set::empty<address>()}
    }

    public fun is_empty(arg0: &Creators) : bool {
        0x2::vec_set::is_empty<address>(&arg0.creators)
    }

    public fun add_creator(arg0: &mut Creators, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.creators, arg1);
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: Creators) {
        assert_no_Creators(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Creators>, Creators>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Creators>(), arg1);
    }

    public fun assert_Creators(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_creator(arg0: &Creators, arg1: &address) {
        assert!(contains_creator(arg0, arg1), 3);
    }

    public fun assert_no_Creators(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &Creators {
        assert_Creators(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Creators>, Creators>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Creators>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Creators {
        assert_Creators(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Creators>, Creators>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Creators>())
    }

    public fun contains_creator(arg0: &Creators, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.creators, arg1)
    }

    public fun delete(arg0: Creators) {
        let Creators {  } = arg0;
    }

    public fun get_Creators(arg0: &Creators) : &0x2::vec_set::VecSet<address> {
        &arg0.creators
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Creators>, Creators>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Creators>())
    }

    public fun new(arg0: 0x2::vec_set::VecSet<address>) : Creators {
        Creators{creators: arg0}
    }

    public fun remove_creator(arg0: &mut Creators, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.creators, &arg1);
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Creators {
        assert_Creators(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Creators>, Creators>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Creators>())
    }

    // decompiled from Move bytecode v6
}


module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::creators {
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
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Creators>, Creators>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Creators>(), arg1);
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
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Creators>, Creators>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Creators>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Creators {
        assert_Creators(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Creators>, Creators>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Creators>())
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
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Creators>, Creators>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Creators>())
    }

    public fun new(arg0: 0x2::vec_set::VecSet<address>) : Creators {
        Creators{creators: arg0}
    }

    public fun remove_creator(arg0: &mut Creators, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.creators, &arg1);
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Creators {
        assert_Creators(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Creators>, Creators>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Creators>())
    }

    // decompiled from Move bytecode v6
}


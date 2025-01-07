module 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::policy {
    struct Request {
        round_id: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct Policy has store, key {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::string::String>,
        other: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Policy, 0x2::object::ID) {
        let v0 = Policy{
            id    : 0x2::object::new(arg0),
            rules : 0x2::vec_set::empty<0x1::string::String>(),
            other : 0x2::object_bag::new(arg0),
        };
        (v0, *0x2::object::uid_as_inner(uid(&v0)))
    }

    public(friend) fun add_receipt<T0>(arg0: &mut Request) {
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.receipts, 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<T0>());
    }

    public(friend) fun add_rule<T0, T1: drop + store>(arg0: &mut Policy, arg1: T1) {
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<T0>();
        assert!(!has_rule(arg0, v0), 402);
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.rules, v0);
        0x2::dynamic_field::add<0x1::string::String, T1>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun confirm_request(arg0: &Policy, arg1: Request) : 0x2::object::ID {
        let Request {
            round_id : v0,
            receipts : v1,
        } = arg1;
        let v2 = 0x2::vec_set::into_keys<0x1::string::String>(v1);
        assert!(0x1::vector::length<0x1::string::String>(&v2) == 0x2::vec_set::size<0x1::string::String>(&arg0.rules), 400);
        while (0x1::vector::length<0x1::string::String>(&v2) != 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut v2);
            assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.rules, &v3), 401);
        };
        v0
    }

    public(friend) fun get_rule<T0, T1: drop + store>(arg0: &Policy) : &T1 {
        0x2::dynamic_field::borrow<0x1::string::String, T1>(&arg0.id, 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<T0>())
    }

    public(friend) fun has_rule(arg0: &Policy, arg1: 0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.rules, &arg1)
    }

    public(friend) fun new_request(arg0: 0x2::object::ID) : Request {
        Request{
            round_id : arg0,
            receipts : 0x2::vec_set::empty<0x1::string::String>(),
        }
    }

    public(friend) fun remove_rule<T0, T1: drop + store>(arg0: &mut Policy) {
        let v0 = 0x64af9ef6e47a41b72a91dfdeac34988179a87d6c388190943c514b3aa2833142::utils::get_key_by_struct<T0>();
        0x2::vec_set::remove<0x1::string::String>(&mut arg0.rules, &v0);
        0x2::dynamic_field::remove<0x1::string::String, T1>(&mut arg0.id, v0);
    }

    public(friend) fun rules(arg0: &Policy) : &0x2::vec_set::VecSet<0x1::string::String> {
        &arg0.rules
    }

    public(friend) fun uid(arg0: &Policy) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}


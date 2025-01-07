module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy {
    struct TRANSFER_POLICY has drop {
        dummy_field: bool,
    }

    struct TransferRequest<phantom T0> {
        item: 0x2::object::ID,
        paid: u64,
        from: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct TransferPolicy<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct AdminList has store, key {
        id: 0x2::object::UID,
        super_admin: address,
        admins: vector<address>,
    }

    struct TransferPolicyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct TransferPolicyCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct RuleKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (TransferPolicy<T0>, TransferPolicyCap<T0>) {
        assert!(0x2::package::from_package<T0>(arg0), 0);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = TransferPolicyCreated<T0>{id: v1};
        0x2::event::emit<TransferPolicyCreated<T0>>(v2);
        let v3 = TransferPolicy<T0>{
            id      : v0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v4 = TransferPolicyCap<T0>{
            id        : 0x2::object::new(arg1),
            policy_id : v1,
        };
        (v3, v4)
    }

    public fun add_receipt<T0, T1: drop>(arg0: T1, arg1: &mut TransferRequest<T0>) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::get<T1>());
    }

    public fun add_rule<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &mut TransferPolicy<T0>, arg2: &TransferPolicyCap<T0>, arg3: T2) {
        assert!(0x2::object::id<TransferPolicy<T0>>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0, T1>(arg1), 3);
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T1>, T2>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.rules, 0x1::type_name::get<T1>());
    }

    public fun add_to_balance<T0, T1: drop>(arg0: T1, arg1: &mut TransferPolicy<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(has_rule<T0, T1>(arg1), 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    public fun admin_destroy_and_withdraw<T0>(arg0: &mut AdminList, arg1: TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        let TransferPolicy {
            id      : v0,
            balance : v1,
            rules   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2)
    }

    public fun admin_new<T0>(arg0: &mut AdminList, arg1: &mut 0x2::tx_context::TxContext) : (TransferPolicy<T0>, TransferPolicyCap<T0>) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = TransferPolicyCreated<T0>{id: v1};
        0x2::event::emit<TransferPolicyCreated<T0>>(v2);
        let v3 = TransferPolicy<T0>{
            id      : v0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v4 = TransferPolicyCap<T0>{
            id        : 0x2::object::new(arg1),
            policy_id : v1,
        };
        (v3, v4)
    }

    public fun confirm_request<T0>(arg0: &TransferPolicy<T0>, arg1: TransferRequest<T0>) : (0x2::object::ID, u64, 0x2::object::ID) {
        let TransferRequest {
            item     : v0,
            paid     : v1,
            from     : v2,
            receipts : v3,
        } = arg1;
        let v4 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v3);
        let v5 = 0x1::vector::length<0x1::type_name::TypeName>(&v4);
        assert!(v5 == 0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.rules), 0);
        while (v5 > 0) {
            let v6 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v6), 1);
            v5 = v5 - 1;
        };
        (v0, v1, v2)
    }

    public fun destroy_and_withdraw<T0>(arg0: TransferPolicy<T0>, arg1: TransferPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::id<TransferPolicy<T0>>(&arg0) == arg1.policy_id, 4);
        let TransferPolicyCap {
            id        : v0,
            policy_id : _,
        } = arg1;
        let TransferPolicy {
            id      : v2,
            balance : v3,
            rules   : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg2)
    }

    public fun from<T0>(arg0: &TransferRequest<T0>) : 0x2::object::ID {
        arg0.from
    }

    public fun get_rule<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &TransferPolicy<T0>) : &T2 {
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T1>, T2>(&arg1.id, v0)
    }

    public fun has_rule<T0, T1: drop>(arg0: &TransferPolicy<T0>) : bool {
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists_<RuleKey<T1>>(&arg0.id, v0)
    }

    fun init(arg0: TRANSFER_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TRANSFER_POLICY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminList{
            id          : 0x2::object::new(arg1),
            super_admin : 0x2::tx_context::sender(arg1),
            admins      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<AdminList>(v0);
    }

    public entry fun is_admin(arg0: &mut AdminList, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun item<T0>(arg0: &TransferRequest<T0>) : 0x2::object::ID {
        arg0.item
    }

    public fun new_request<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID) : TransferRequest<T0> {
        TransferRequest<T0>{
            item     : arg0,
            paid     : arg1,
            from     : arg2,
            receipts : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun paid<T0>(arg0: &TransferRequest<T0>) : u64 {
        arg0.paid
    }

    public fun remove_rule<T0, T1: drop, T2: drop + store>(arg0: &mut TransferPolicy<T0>, arg1: &TransferPolicyCap<T0>) {
        assert!(0x2::object::id<TransferPolicy<T0>>(arg0) == arg1.policy_id, 4);
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T1>, T2>(&mut arg0.id, v0);
        let v1 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v1);
    }

    public fun rules<T0>(arg0: &TransferPolicy<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.rules
    }

    public entry fun toggle_admin(arg0: &mut AdminList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg2), 0);
        if (is_admin(arg0, arg1)) {
            let (_, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        } else {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    public entry fun toggle_super_admin(arg0: &0x2::package::Publisher, arg1: &mut AdminList, arg2: address) {
        0x2::package::from_package<TRANSFER_POLICY>(arg0);
        arg1.super_admin = arg2;
    }

    public fun uid<T0>(arg0: &TransferPolicy<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut_as_owner<T0>(arg0: &mut TransferPolicy<T0>, arg1: &TransferPolicyCap<T0>) : &mut 0x2::object::UID {
        assert!(0x2::object::id<TransferPolicy<T0>>(arg0) == arg1.policy_id, 4);
        &mut arg0.id
    }

    public fun withdraw<T0>(arg0: &mut TransferPolicy<T0>, arg1: &TransferPolicyCap<T0>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::id<TransferPolicy<T0>>(arg0) == arg1.policy_id, 4);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 5);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
        };
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3)
    }

    // decompiled from Move bytecode v6
}


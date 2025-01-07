module 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::quorum {
    struct Quorum<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        members: 0x2::vec_set::VecSet<address>,
        delegates: 0x2::vec_set::VecSet<0x2::object::ID>,
        admin_count: u64,
    }

    struct ReturnReceipt<phantom T0, phantom T1: key> {
        dummy_field: bool,
    }

    struct ExtensionToken<phantom T0> has store {
        quorum_id: 0x2::object::ID,
    }

    struct Signatures<phantom T0> has copy, drop, store {
        list: 0x2::vec_set::VecSet<address>,
    }

    struct AdminField has copy, drop, store {
        type_name: 0x1::type_name::TypeName,
    }

    struct MemberField has copy, drop, store {
        type_name: 0x1::type_name::TypeName,
    }

    struct AddAdmin has copy, drop, store {
        admin: address,
    }

    struct RemoveAdmin has copy, drop, store {
        admin: address,
    }

    struct AddDelegate has copy, drop, store {
        entity: 0x2::object::ID,
    }

    struct RemoveDelegate has copy, drop, store {
        entity: 0x2::object::ID,
    }

    struct CreateQuorumEvent has copy, drop {
        quorum_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    struct Foo has drop {
        dummy_field: bool,
    }

    public fun singleton<T0>(arg0: &T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Quorum<T0> {
        create<T0>(arg0, 0x2::vec_set::singleton<address>(arg1), 0x2::vec_set::empty<address>(), 0x2::vec_set::empty<0x2::object::ID>(), arg2)
    }

    public fun add_admin_with_extension<T0>(arg0: &mut Quorum<T0>, arg1: &ExtensionToken<T0>, arg2: address) {
        assert_version_and_upgrade<T0>(arg0);
        assert_extension_token<T0>(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
        arg0.admin_count = arg0.admin_count + 1;
    }

    public fun add_delegate_with_extension<T0>(arg0: &mut Quorum<T0>, arg1: &ExtensionToken<T0>, arg2: 0x2::object::ID) {
        assert_version_and_upgrade<T0>(arg0);
        assert_extension_token<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.delegates, arg2);
    }

    public fun add_member<T0>(arg0: &mut Quorum<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert_admin<T0>(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.members, arg1);
    }

    public fun admin_count<T0>(arg0: &Quorum<T0>) : u64 {
        arg0.admin_count
    }

    public fun admins<T0>(arg0: &Quorum<T0>) : &0x2::vec_set::VecSet<address> {
        &arg0.admins
    }

    public fun assert_admin<T0>(arg0: &Quorum<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
    }

    public fun assert_delegate<T0>(arg0: &Quorum<T0>, arg1: &0x2::object::UID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.delegates, 0x2::object::uid_as_inner(arg1)), 6);
    }

    public fun assert_extension_token<T0>(arg0: &Quorum<T0>, arg1: &ExtensionToken<T0>) {
        assert!(0x2::object::id<Quorum<T0>>(arg0) == arg1.quorum_id, 5);
    }

    public fun assert_member<T0>(arg0: &Quorum<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 2);
    }

    public fun assert_member_or_admin<T0>(arg0: &Quorum<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::vec_set::contains<address>(&arg0.admins, &v0)) {
            true
        } else {
            let v2 = 0x2::tx_context::sender(arg1);
            0x2::vec_set::contains<address>(&arg0.members, &v2)
        };
        assert!(v1, 3);
    }

    fun assert_version<T0>(arg0: &Quorum<T0>) {
        assert!(arg0.version == 2, 1000);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut Quorum<T0>) {
        if (arg0.version < 2) {
            arg0.version = 2;
        };
        assert_version<T0>(arg0);
    }

    public fun borrow_cap<T0, T1: store + key>(arg0: &mut Quorum<T0>, arg1: &mut 0x2::tx_context::TxContext) : (T1, ReturnReceipt<T0, T1>) {
        assert_version_and_upgrade<T0>(arg0);
        assert_member_or_admin<T0>(arg0, arg1);
        let v0 = AdminField{type_name: 0x1::type_name::get<T1>()};
        let v1 = if (0x2::dynamic_field::exists_<AdminField>(&arg0.id, v0)) {
            assert_admin<T0>(arg0, arg1);
            let v2 = AdminField{type_name: 0x1::type_name::get<T1>()};
            0x1::option::extract<T1>(0x2::dynamic_field::borrow_mut<AdminField, 0x1::option::Option<T1>>(&mut arg0.id, v2))
        } else {
            assert_member<T0>(arg0, arg1);
            let v3 = MemberField{type_name: 0x1::type_name::get<T1>()};
            0x1::option::extract<T1>(0x2::dynamic_field::borrow_mut<MemberField, 0x1::option::Option<T1>>(&mut arg0.id, v3))
        };
        let v4 = ReturnReceipt<T0, T1>{dummy_field: false};
        (v1, v4)
    }

    public fun borrow_cap_as_delegate<T0, T1, T2: store + key>(arg0: &mut Quorum<T0>, arg1: &Quorum<T1>, arg2: &mut 0x2::tx_context::TxContext) : (T2, ReturnReceipt<T0, T2>) {
        assert_version_and_upgrade<T0>(arg0);
        assert_delegate<T0>(arg0, &arg1.id);
        assert_member_or_admin<T1>(arg1, arg2);
        let v0 = AdminField{type_name: 0x1::type_name::get<T2>()};
        let v1 = if (0x2::dynamic_field::exists_<AdminField>(&arg0.id, v0)) {
            assert_admin<T1>(arg1, arg2);
            let v2 = AdminField{type_name: 0x1::type_name::get<T2>()};
            0x1::option::extract<T2>(0x2::dynamic_field::borrow_mut<AdminField, 0x1::option::Option<T2>>(&mut arg0.id, v2))
        } else {
            assert_member<T1>(arg1, arg2);
            let v3 = MemberField{type_name: 0x1::type_name::get<T2>()};
            0x1::option::extract<T2>(0x2::dynamic_field::borrow_mut<MemberField, 0x1::option::Option<T2>>(&mut arg0.id, v3))
        };
        let v4 = ReturnReceipt<T0, T2>{dummy_field: false};
        (v1, v4)
    }

    fun burn_receipt<T0, T1: store + key>(arg0: ReturnReceipt<T0, T1>) {
        let ReturnReceipt {  } = arg0;
    }

    fun calc_voting_threshold(arg0: u64) : u64 {
        if (arg0 == 1) {
            1
        } else {
            let v1 = 0x2::math::divide_and_round_up(arg0, 2);
            let v0 = v1;
            if (arg0 % 2 == 0) {
                v0 = v1 + 1;
            };
            v0
        }
    }

    public fun create<T0>(arg0: &T0, arg1: 0x2::vec_set::VecSet<address>, arg2: 0x2::vec_set::VecSet<address>, arg3: 0x2::vec_set::VecSet<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) : Quorum<T0> {
        let v0 = 0x2::object::new(arg4);
        let v1 = CreateQuorumEvent{
            quorum_id : 0x2::object::uid_to_inner(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreateQuorumEvent>(v1);
        Quorum<T0>{
            id          : v0,
            version     : 2,
            admins      : arg1,
            members     : arg2,
            delegates   : arg3,
            admin_count : 0x2::vec_set::size<address>(&arg1),
        }
    }

    public fun create_for_extension<T0>(arg0: &T0, arg1: 0x2::vec_set::VecSet<address>, arg2: 0x2::vec_set::VecSet<address>, arg3: 0x2::vec_set::VecSet<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) : (Quorum<T0>, ExtensionToken<T0>) {
        let v0 = create<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = ExtensionToken<T0>{quorum_id: 0x2::object::id<Quorum<T0>>(&v0)};
        (v0, v1)
    }

    public fun delegates<T0>(arg0: &Quorum<T0>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.delegates
    }

    public fun extension_token_id<T0>(arg0: &ExtensionToken<T0>) : 0x2::object::ID {
        arg0.quorum_id
    }

    public fun init_quorum<T0>(arg0: &T0, arg1: 0x2::vec_set::VecSet<address>, arg2: 0x2::vec_set::VecSet<address>, arg3: 0x2::vec_set::VecSet<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<Quorum<T0>>(v0);
        0x2::object::id<Quorum<T0>>(&v0)
    }

    public fun insert_cap<T0, T1: store + key>(arg0: &mut Quorum<T0>, arg1: T1, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert_admin<T0>(arg0, arg3);
        insert_cap_<T0, T1>(arg0, arg1, arg2);
    }

    fun insert_cap_<T0, T1: store + key>(arg0: &mut Quorum<T0>, arg1: T1, arg2: bool) {
        if (arg2) {
            let v0 = AdminField{type_name: 0x1::type_name::get<T1>()};
            0x2::dynamic_field::add<AdminField, 0x1::option::Option<T1>>(&mut arg0.id, v0, 0x1::option::some<T1>(arg1));
        } else {
            let v1 = MemberField{type_name: 0x1::type_name::get<T1>()};
            0x2::dynamic_field::add<MemberField, 0x1::option::Option<T1>>(&mut arg0.id, v1, 0x1::option::some<T1>(arg1));
        };
    }

    public fun members<T0>(arg0: &Quorum<T0>) : &0x2::vec_set::VecSet<address> {
        &arg0.members
    }

    entry fun migrate_as_creator<T0>(arg0: &mut Quorum<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 2;
    }

    entry fun migrate_as_pub<T0>(arg0: &mut Quorum<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::permissions::PERMISSIONS>(arg1), 0);
        arg0.version = 2;
    }

    public fun quorum_id<T0>(arg0: &Quorum<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun remove_admin_with_extension<T0>(arg0: &mut Quorum<T0>, arg1: &ExtensionToken<T0>, arg2: address) {
        assert_version_and_upgrade<T0>(arg0);
        assert_extension_token<T0>(arg0, arg1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        arg0.admin_count = arg0.admin_count - 1;
    }

    public fun remove_delegate_with_extension<T0>(arg0: &mut Quorum<T0>, arg1: &ExtensionToken<T0>, arg2: 0x2::object::ID) {
        assert_version_and_upgrade<T0>(arg0);
        assert_extension_token<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.delegates, &arg2);
    }

    public fun remove_member<T0>(arg0: &mut Quorum<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert_admin<T0>(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg1);
    }

    public fun return_cap<T0, T1: store + key>(arg0: &mut Quorum<T0>, arg1: T1, arg2: ReturnReceipt<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        return_cap_<T0, T1>(arg0, arg1, arg3);
        burn_receipt<T0, T1>(arg2);
    }

    fun return_cap_<T0, T1: store + key>(arg0: &mut Quorum<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminField{type_name: 0x1::type_name::get<T1>()};
        if (0x2::dynamic_field::exists_<AdminField>(&arg0.id, v0)) {
            assert_admin<T0>(arg0, arg2);
            let v1 = AdminField{type_name: 0x1::type_name::get<T1>()};
            0x1::option::fill<T1>(0x2::dynamic_field::borrow_mut<AdminField, 0x1::option::Option<T1>>(&mut arg0.id, v1), arg1);
        } else {
            assert_member<T0>(arg0, arg2);
            let v2 = MemberField{type_name: 0x1::type_name::get<T1>()};
            0x1::option::fill<T1>(0x2::dynamic_field::borrow_mut<MemberField, 0x1::option::Option<T1>>(&mut arg0.id, v2), arg1);
        };
    }

    public fun return_cap_as_delegate<T0, T1, T2: store + key>(arg0: &mut Quorum<T0>, arg1: &Quorum<T1>, arg2: T2, arg3: ReturnReceipt<T0, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert_delegate<T0>(arg0, &arg1.id);
        assert_member_or_admin<T1>(arg1, arg4);
        let v0 = AdminField{type_name: 0x1::type_name::get<T2>()};
        if (0x2::dynamic_field::exists_<AdminField>(&arg0.id, v0)) {
            assert_admin<T1>(arg1, arg4);
            let v1 = AdminField{type_name: 0x1::type_name::get<T2>()};
            0x1::option::fill<T2>(0x2::dynamic_field::borrow_mut<AdminField, 0x1::option::Option<T2>>(&mut arg0.id, v1), arg2);
        } else {
            assert_member<T1>(arg1, arg4);
            let v2 = MemberField{type_name: 0x1::type_name::get<T2>()};
            0x1::option::fill<T2>(0x2::dynamic_field::borrow_mut<MemberField, 0x1::option::Option<T2>>(&mut arg0.id, v2), arg2);
        };
        burn_receipt<T0, T2>(arg3);
    }

    fun sign<T0>(arg0: &mut Signatures<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.list, 0x2::tx_context::sender(arg1));
    }

    public fun vote<T0, T1: copy + drop + store>(arg0: &mut Quorum<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_version_and_upgrade<T0>(arg0);
        assert_admin<T0>(arg0, arg2);
        let (v0, v1) = if (0x2::dynamic_field::exists_<T1>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<T1, Signatures<T0>>(&mut arg0.id, arg1);
            sign<T0>(v2, arg2);
            (calc_voting_threshold(arg0.admin_count), 0x2::vec_set::size<address>(&v2.list))
        } else {
            let v3 = Signatures<T0>{list: 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg2))};
            0x2::dynamic_field::add<T1, Signatures<T0>>(&mut arg0.id, arg1, v3);
            (calc_voting_threshold(arg0.admin_count), 1)
        };
        (v1, v0)
    }

    public entry fun vote_add_admin<T0>(arg0: &mut Quorum<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = AddAdmin{admin: arg1};
        let (v1, v2) = vote<T0, AddAdmin>(arg0, v0, arg2);
        if (v1 >= v2) {
            let v3 = AddAdmin{admin: arg1};
            0x2::dynamic_field::remove<AddAdmin, Signatures<T0>>(&mut arg0.id, v3);
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
            arg0.admin_count = arg0.admin_count + 1;
        };
    }

    public entry fun vote_add_delegate<T0>(arg0: &mut Quorum<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = AddDelegate{entity: arg1};
        let (v1, v2) = vote<T0, AddDelegate>(arg0, v0, arg2);
        if (v1 >= v2) {
            let v3 = AddDelegate{entity: arg1};
            0x2::dynamic_field::remove<AddDelegate, Signatures<T0>>(&mut arg0.id, v3);
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.delegates, arg1);
        };
    }

    public entry fun vote_remove_admin<T0>(arg0: &mut Quorum<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert!(arg0.admin_count >= 1, 4);
        let v0 = RemoveAdmin{admin: arg1};
        let (v1, v2) = vote<T0, RemoveAdmin>(arg0, v0, arg2);
        if (v1 >= v2) {
            let v3 = RemoveAdmin{admin: arg1};
            0x2::dynamic_field::remove<RemoveAdmin, Signatures<T0>>(&mut arg0.id, v3);
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
            arg0.admin_count = arg0.admin_count - 1;
        };
    }

    public entry fun vote_remove_delegate<T0>(arg0: &mut Quorum<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert!(arg0.admin_count >= 1, 4);
        let v0 = RemoveDelegate{entity: arg1};
        let (v1, v2) = vote<T0, RemoveDelegate>(arg0, v0, arg2);
        if (v1 >= v2) {
            let v3 = RemoveDelegate{entity: arg1};
            0x2::dynamic_field::remove<RemoveDelegate, Signatures<T0>>(&mut arg0.id, v3);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.delegates, &arg1);
        };
    }

    // decompiled from Move bytecode v6
}


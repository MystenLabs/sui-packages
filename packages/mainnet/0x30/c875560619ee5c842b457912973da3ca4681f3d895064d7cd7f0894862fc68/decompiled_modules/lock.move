module 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock {
    struct LockCreated has copy, drop, store {
        id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct TreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct Lock<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        deadline: u64,
        total_fee_a: u64,
        total_fee_b: u64,
        total_admin_fee_a: u64,
        total_admin_fee_b: u64,
        meme_amount_locked: u64,
        sui_amount_locked: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        locks: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public fun burn<T0: drop>(arg0: &mut Lock<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(has_treasury_cap<T0>(arg0), 9223372741230067723);
        let v0 = TreasuryKey{dummy_field: false};
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<TreasuryKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0), arg1);
    }

    public fun update_description<T0: drop>(arg0: &mut Lock<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        assert!(has_treasury_cap<T0>(arg0), 9223372766999871499);
        let v0 = TreasuryKey{dummy_field: false};
        0x2::coin::update_description<T0>(0x2::dynamic_object_field::borrow_mut<TreasuryKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0), arg1, arg2);
    }

    public fun new<T0: drop>(arg0: &mut Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : Lock<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::destroy_some<u64>(arg1)
        } else {
            0x1::option::destroy_none<u64>(arg1);
            18446744073709551615
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.locks, 0x1::type_name::get<T0>(), 0x2::object::uid_to_inner(&v0));
        let v2 = LockCreated{
            id        : 0x2::object::uid_to_inner(&v0),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LockCreated>(v2);
        Lock<T0>{
            id                 : v0,
            metadata           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            deadline           : v1,
            total_fee_a        : 0,
            total_fee_b        : 0,
            total_admin_fee_a  : 0,
            total_admin_fee_b  : 0,
            meme_amount_locked : 0,
            sui_amount_locked  : 0,
        }
    }

    public(friend) fun add_fee_a<T0: drop>(arg0: &mut Lock<T0>, arg1: u64, arg2: u64) {
        arg0.total_fee_a = arg0.total_fee_a + arg1;
        arg0.total_admin_fee_a = arg0.total_admin_fee_a + arg2;
    }

    public(friend) fun add_fee_b<T0: drop>(arg0: &mut Lock<T0>, arg1: u64, arg2: u64) {
        arg0.total_fee_b = arg0.total_fee_b + arg1;
        arg0.total_admin_fee_b = arg0.total_admin_fee_b + arg2;
    }

    public(friend) fun add_position<T0: drop, T1: store + key>(arg0: &mut Lock<T0>, arg1: T1, arg2: u64, arg3: u64) {
        arg0.meme_amount_locked = arg0.meme_amount_locked + arg2;
        arg0.sui_amount_locked = arg0.sui_amount_locked + arg3;
        0x2::dynamic_object_field::add<0x2::object::ID, T1>(&mut arg0.id, 0x2::object::id<T1>(&arg1), arg1);
    }

    public fun add_to_registry<T0: drop>(arg0: &0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::acl::Admin, arg1: &mut Registry, arg2: 0x2::object::ID) {
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.locks, 0x1::type_name::get<T0>(), arg2);
    }

    public fun add_treasury_cap<T0: drop>(arg0: &mut Lock<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        assert!(!has_treasury_cap<T0>(arg0), 9223372543661047811);
        let v0 = TreasuryKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun borrow_position<T0: drop, T1: store + key>(arg0: &Lock<T0>, arg1: 0x2::object::ID) : &T1 {
        0x2::dynamic_object_field::borrow<0x2::object::ID, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_position_mut<T0: drop, T1: store + key>(arg0: &mut Lock<T0>, arg1: 0x2::object::ID) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun deadline<T0: drop>(arg0: &Lock<T0>) : u64 {
        arg0.deadline
    }

    public fun destroy<T0: drop>(arg0: Lock<T0>, arg1: &mut Registry) {
        assert!(!has_treasury_cap<T0>(&arg0), 9223372616675753991);
        assert!(arg0.meme_amount_locked == 0 && arg0.sui_amount_locked == 0, 9223372620970590213);
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.locks, 0x1::type_name::get<T0>());
        let Lock {
            id                 : v0,
            metadata           : _,
            deadline           : _,
            total_fee_a        : _,
            total_fee_b        : _,
            total_admin_fee_a  : _,
            total_admin_fee_b  : _,
            meme_amount_locked : _,
            sui_amount_locked  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun has_position<T0: drop>(arg0: &Lock<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = PositionKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<PositionKey>(&arg0.id, v0)
    }

    public(friend) fun has_treasury_cap<T0: drop>(arg0: &Lock<T0>) : bool {
        let v0 = TreasuryKey{dummy_field: false};
        0x2::dynamic_object_field::exists_<TreasuryKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            locks : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun remove_from_registry<T0: drop>(arg0: &0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::acl::Admin, arg1: &mut Registry) {
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.locks, 0x1::type_name::get<T0>());
    }

    public(friend) fun remove_position<T0: drop, T1: store + key>(arg0: &mut Lock<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : T1 {
        assert!(arg0.deadline > 0x2::tx_context::epoch(arg4), 9223373037582155777);
        assert!(has_position<T0>(arg0, arg1), 9223373041877647369);
        arg0.meme_amount_locked = arg0.meme_amount_locked - arg2;
        arg0.sui_amount_locked = arg0.sui_amount_locked - arg3;
        0x2::dynamic_object_field::remove<0x2::object::ID, T1>(&mut arg0.id, arg1)
    }

    public fun remove_treasury_cap<T0: drop>(arg0: &mut Lock<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        assert!(arg0.deadline > 0x2::tx_context::epoch(arg1), 9223372578020655105);
        assert!(has_treasury_cap<T0>(arg0), 9223372582316277771);
        let v0 = 0x1::string::utf8(b"can_mint");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &v0);
        let v3 = TreasuryKey{dummy_field: false};
        0x2::dynamic_object_field::remove<TreasuryKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v3)
    }

    public fun update_icon<T0: drop>(arg0: &mut Lock<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        assert!(has_treasury_cap<T0>(arg0), 9223372792769675275);
        let v0 = TreasuryKey{dummy_field: false};
        0x2::coin::update_icon_url<T0>(0x2::dynamic_object_field::borrow_mut<TreasuryKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


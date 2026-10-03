module 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault {
    struct RangeKey has copy, drop, store {
        lower: u32,
        upper: u32,
    }

    struct PositionInfo has copy, drop, store {
        id: 0x2::object::ID,
        intent: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        range: RangeKey,
        index: u64,
        removed: bool,
        fees_collected: bool,
    }

    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        version: u64,
        pool_id: 0x2::object::ID,
        ranges: 0x2::table::Table<RangeKey, vector<T0>>,
        items: vector<PositionInfo>,
    }

    fun new<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id      : 0x2::object::new(arg1),
            owner   : 0x2::tx_context::sender(arg1),
            version : 2,
            pool_id : arg0,
            ranges  : 0x2::table::new<RangeKey, vector<T0>>(arg1),
            items   : 0x1::vector::empty<PositionInfo>(),
        }
    }

    public(friend) fun activate<T0: store + key>(arg0: &mut Vault<T0>, arg1: RangeKey, arg2: u64, arg3: 0x2::object::ID, arg4: bool, arg5: address) {
        assert_idle<T0>(arg0);
        let v0 = PositionInfo{
            id             : 0x2::object::id<T0>(0x1::vector::borrow<T0>(0x2::table::borrow<RangeKey, vector<T0>>(&arg0.ranges, arg1), arg2)),
            intent         : arg5,
            pool_id        : arg0.pool_id,
            position_id    : arg3,
            range          : arg1,
            index          : arg2,
            removed        : arg4,
            fees_collected : false,
        };
        0x1::vector::push_back<PositionInfo>(&mut arg0.items, v0);
    }

    public fun active_id<T0: store + key>(arg0: &Vault<T0>) : 0x2::object::ID {
        latest<T0>(arg0)
    }

    public(friend) fun assert_active<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) {
        let v0 = current<T0>(arg0, arg1);
        assert!(!v0.removed, 6);
    }

    public(friend) fun assert_idle<T0: store + key>(arg0: &Vault<T0>) {
        assert!(0x1::vector::is_empty<PositionInfo>(&arg0.items), 2);
    }

    public(friend) fun assert_removed<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) {
        let v0 = current<T0>(arg0, arg1);
        assert!(v0.removed, 4);
    }

    public(friend) fun borrow_current<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID) : &mut T0 {
        let v0 = current<T0>(arg0, arg1);
        borrow_range<T0>(arg0, v0.range, v0.index)
    }

    public(friend) fun borrow_range<T0: store + key>(arg0: &mut Vault<T0>, arg1: RangeKey, arg2: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(0x2::table::borrow_mut<RangeKey, vector<T0>>(&mut arg0.ranges, arg1), arg2)
    }

    public(friend) fun check<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.pool_id == arg1, 7);
    }

    public(friend) fun check_intent<T0: store + key>(arg0: &Vault<T0>, arg1: address) {
        assert!(!0x1::vector::is_empty<PositionInfo>(&arg0.items), 1);
        assert!(0x1::vector::borrow<PositionInfo>(&arg0.items, 0).intent == arg1, 8);
    }

    public fun create<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0>(arg0, arg1));
    }

    public(friend) fun current<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : PositionInfo {
        assert!(!0x1::vector::is_empty<PositionInfo>(&arg0.items), 1);
        let v0 = *0x1::vector::borrow<PositionInfo>(&arg0.items, 0);
        assert!(v0.id == arg1, 3);
        v0
    }

    public(friend) fun fees_collected<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = current<T0>(arg0, arg1);
        v0.fees_collected
    }

    public(friend) fun finish<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID) {
        assert_removed<T0>(arg0, arg1);
        assert!(fees_collected<T0>(arg0, arg1), 5);
        0x1::vector::pop_back<PositionInfo>(&mut arg0.items);
    }

    public(friend) fun has_range<T0: store + key>(arg0: &Vault<T0>, arg1: RangeKey) : bool {
        0x2::table::contains<RangeKey, vector<T0>>(&arg0.ranges, arg1) && !0x1::vector::is_empty<T0>(0x2::table::borrow<RangeKey, vector<T0>>(&arg0.ranges, arg1))
    }

    public fun key(arg0: u32, arg1: u32) : RangeKey {
        RangeKey{
            lower : arg0,
            upper : arg1,
        }
    }

    public(friend) fun latest<T0: store + key>(arg0: &Vault<T0>) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<PositionInfo>(&arg0.items), 1);
        0x1::vector::borrow<PositionInfo>(&arg0.items, 0).id
    }

    public(friend) fun mark_fees_collected<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID) {
        assert_removed<T0>(arg0, arg1);
        0x1::vector::borrow_mut<PositionInfo>(&mut arg0.items, 0).fees_collected = true;
    }

    public(friend) fun mark_removed<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID) {
        assert_active<T0>(arg0, arg1);
        0x1::vector::borrow_mut<PositionInfo>(&mut arg0.items, 0).removed = true;
        0x1::vector::borrow_mut<PositionInfo>(&mut arg0.items, 0).fees_collected = true;
    }

    public fun owner<T0: store + key>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun pool_id<T0: store + key>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun range_count<T0: store + key>(arg0: &Vault<T0>) : u64 {
        0x2::table::length<RangeKey, vector<T0>>(&arg0.ranges)
    }

    public fun range_ids<T0: store + key>(arg0: &Vault<T0>, arg1: u32, arg2: u32) : vector<0x2::object::ID> {
        let v0 = key(arg1, arg2);
        if (!0x2::table::contains<RangeKey, vector<T0>>(&arg0.ranges, v0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v1 = 0x2::table::borrow<RangeKey, vector<T0>>(&arg0.ranges, v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<T0>(v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<T0>(0x1::vector::borrow<T0>(v1, v3)));
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun store<T0: store + key>(arg0: &mut Vault<T0>, arg1: RangeKey, arg2: T0) : u64 {
        assert_idle<T0>(arg0);
        if (!0x2::table::contains<RangeKey, vector<T0>>(&arg0.ranges, arg1)) {
            0x2::table::add<RangeKey, vector<T0>>(&mut arg0.ranges, arg1, 0x1::vector::empty<T0>());
        };
        let v0 = 0x2::table::borrow_mut<RangeKey, vector<T0>>(&mut arg0.ranges, arg1);
        0x1::vector::push_back<T0>(v0, arg2);
        0x1::vector::length<T0>(v0)
    }

    public fun withdraw<T0: store + key>(arg0: &mut Vault<T0>, arg1: u32, arg2: u32, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        check<T0>(arg0, arg0.pool_id, arg4);
        assert_idle<T0>(arg0);
        0x2::transfer::public_transfer<T0>(0x1::vector::remove<T0>(0x2::table::borrow_mut<RangeKey, vector<T0>>(&mut arg0.ranges, key(arg1, arg2)), arg3), arg0.owner);
    }

    // decompiled from Move bytecode v7
}


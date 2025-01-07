module 0xc2e0daa2eec2265a8401c45b57f9ef7f71a29be1a81abda3c4ddff8c388aa4b9::assets {
    struct Assets has key {
        id: 0x2::object::UID,
        data: 0x2::bag::Bag,
        version: u16,
    }

    struct AddressBalanceKey<phantom T0> has copy, drop, store {
        addr: address,
    }

    struct AllocatedToken<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        holder_id: u64,
        withdraw_allowed: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_balance<T0>(arg0: &AdminCap, arg1: &mut Assets, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<T0>) {
        assert_version_is_valid(arg1);
        let v0 = AddressBalanceKey<T0>{addr: arg2};
        assert!(!0x2::bag::contains<AddressBalanceKey<T0>>(&arg1.data, v0), 6);
        let v1 = AllocatedToken<T0>{
            balance          : 0x2::coin::into_balance<T0>(arg4),
            holder_id        : arg3,
            withdraw_allowed : false,
        };
        0x2::bag::add<AddressBalanceKey<T0>, AllocatedToken<T0>>(&mut arg1.data, v0, v1);
    }

    fun assert_balance_exists<T0>(arg0: &Assets, arg1: address) {
        let v0 = AddressBalanceKey<T0>{addr: arg1};
        assert!(0x2::bag::contains<AddressBalanceKey<T0>>(&arg0.data, v0), 4);
    }

    fun assert_version_is_valid(arg0: &Assets) {
        assert!(arg0.version == 1, 1);
    }

    public fun clean_up(arg0: AdminCap, arg1: Assets) {
        assert_version_is_valid(&arg1);
        assert!(0x2::bag::is_empty(&arg1.data), 5);
        let Assets {
            id      : v0,
            data    : v1,
            version : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v1);
        let AdminCap { id: v3 } = arg0;
        0x2::object::delete(v3);
    }

    public fun disable_withdrawals<T0>(arg0: &AdminCap, arg1: &mut Assets, arg2: address, arg3: u64) {
        assert_version_is_valid(arg1);
        assert_balance_exists<T0>(arg1, arg2);
        let v0 = AddressBalanceKey<T0>{addr: arg2};
        let v1 = 0x2::bag::borrow_mut<AddressBalanceKey<T0>, AllocatedToken<T0>>(&mut arg1.data, v0);
        validate_holder_match<T0>(v1, arg3);
        v1.withdraw_allowed = false;
    }

    public fun enable_withdrawals<T0>(arg0: &AdminCap, arg1: &mut Assets, arg2: address, arg3: u64) {
        assert_version_is_valid(arg1);
        assert_balance_exists<T0>(arg1, arg2);
        let v0 = AddressBalanceKey<T0>{addr: arg2};
        let v1 = 0x2::bag::borrow_mut<AddressBalanceKey<T0>, AllocatedToken<T0>>(&mut arg1.data, v0);
        validate_holder_match<T0>(v1, arg3);
        v1.withdraw_allowed = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Assets{
            id      : 0x2::object::new(arg0),
            data    : 0x2::bag::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Assets>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun revoke_balance<T0>(arg0: &AdminCap, arg1: &mut Assets, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_is_valid(arg1);
        assert_balance_exists<T0>(arg1, arg2);
        let v0 = AddressBalanceKey<T0>{addr: arg2};
        let AllocatedToken {
            balance          : v1,
            holder_id        : v2,
            withdraw_allowed : _,
        } = 0x2::bag::remove<AddressBalanceKey<T0>, AllocatedToken<T0>>(&mut arg1.data, v0);
        assert!(v2 == arg3, 2);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut Assets, arg2: u16) {
        arg1.version = arg2;
    }

    fun validate_holder_match<T0>(arg0: &AllocatedToken<T0>, arg1: u64) {
        assert!(arg0.holder_id == arg1, 2);
    }

    public fun withdraw<T0>(arg0: &mut Assets, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_is_valid(arg0);
        assert_balance_exists<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v0 = AddressBalanceKey<T0>{addr: 0x2::tx_context::sender(arg1)};
        let AllocatedToken {
            balance          : v1,
            holder_id        : _,
            withdraw_allowed : v3,
        } = 0x2::bag::remove<AddressBalanceKey<T0>, AllocatedToken<T0>>(&mut arg0.data, v0);
        assert!(v3, 3);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}


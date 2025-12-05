module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::vesting_factory {
    struct VESTING_FACTORY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VestingFactory has key {
        id: 0x2::object::UID,
        wallets: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>,
    }

    public fun claim(arg0: &mut VestingFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::claim<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(wallet_mut(arg0, arg1), arg2, arg1, arg3)
    }

    public fun all_cap_ids(arg0: &VestingFactory) : vector<0x2::object::ID> {
        let v0 = 0x2::linked_table::front<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&arg0.wallets);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            if (0x1::option::is_some<0x2::object::ID>(v0)) {
                let v2 = 0x1::option::borrow<0x2::object::ID>(v0);
                0x1::vector::push_back<0x2::object::ID>(&mut v1, *v2);
                v0 = 0x2::linked_table::next<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&arg0.wallets, *v2);
            };
        };
        v1
    }

    public fun create_vesting_wallet(arg0: &mut VestingFactory, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap {
        let (v0, v1) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::new_wallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg1, arg2, arg3, arg4, arg6);
        let v2 = v1;
        0x2::linked_table::push_back<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&mut arg0.wallets, 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap>(&v2), v0);
        v2
    }

    public fun destroy_wallet(arg0: &mut VestingFactory, arg1: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap) {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::delete_wallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::linked_table::remove<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&mut arg0.wallets, 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap>(&arg1)), arg1);
    }

    fun init(arg0: VESTING_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingFactory{
            id      : 0x2::object::new(arg1),
            wallets : 0x2::linked_table::new<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(arg1),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<VestingFactory>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun total_vested(arg0: &VestingFactory) : u64 {
        let v0 = 0;
        let v1 = all_cap_ids(arg0);
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            v0 = v0 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::linked_table::borrow<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&arg0.wallets, 0x1::vector::pop_back<0x2::object::ID>(&mut v1)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        v0
    }

    public fun wallet(arg0: &VestingFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap) : &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        0x2::linked_table::borrow<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&arg0.wallets, 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap>(arg1))
    }

    fun wallet_mut(arg0: &mut VestingFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap) : &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        0x2::linked_table::borrow_mut<0x2::object::ID, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::VestingWallet<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>>(&mut arg0.wallets, 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting::ClaimCap>(arg1))
    }

    // decompiled from Move bytecode v6
}


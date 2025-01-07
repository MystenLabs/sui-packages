module 0x20ad762229be37b6718de8c07fc7fab0e1368035f2f1d923d9c2dd6de560b832::treasury_lock {
    struct TreasuryLock<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        banned_mint_authorities: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct LockAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_mint_per_epoch: u64,
        last_epoch: u64,
        minted_in_epoch: u64,
    }

    public fun mint_balance<T0>(arg0: &mut TreasuryLock<T0>, arg1: &mut MintCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.banned_mint_authorities, 0x2::object::uid_as_inner(&arg1.id)), 0);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (arg1.last_epoch != v0) {
            arg1.last_epoch = v0;
            arg1.minted_in_epoch = 0;
        };
        assert!(arg1.minted_in_epoch + arg2 <= arg1.max_mint_per_epoch, 1);
        arg1.minted_in_epoch = arg1.minted_in_epoch + arg2;
        0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg2)
    }

    public fun ban_mint_cap_id<T0>(arg0: &LockAdminCap<T0>, arg1: &mut TreasuryLock<T0>, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.banned_mint_authorities, arg2);
    }

    public entry fun ban_mint_cap_id_<T0>(arg0: &LockAdminCap<T0>, arg1: &mut TreasuryLock<T0>, arg2: 0x2::object::ID) {
        ban_mint_cap_id<T0>(arg0, arg1, arg2);
    }

    public fun create_and_transfer_mint_cap<T0>(arg0: &LockAdminCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MintCap<T0>>(create_mint_cap<T0>(arg0, arg1, arg3), arg2);
    }

    public fun create_mint_cap<T0>(arg0: &LockAdminCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap<T0> {
        MintCap<T0>{
            id                 : 0x2::object::new(arg2),
            max_mint_per_epoch : arg1,
            last_epoch         : 0x2::tx_context::epoch(arg2),
            minted_in_epoch    : 0,
        }
    }

    public entry fun mint_and_transfer<T0>(arg0: &mut TreasuryLock<T0>, arg1: &mut MintCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_balance<T0>(arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), arg3);
    }

    public fun new_lock<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : LockAdminCap<T0> {
        let v0 = TreasuryLock<T0>{
            id                      : 0x2::object::new(arg1),
            treasury_cap            : arg0,
            banned_mint_authorities : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TreasuryLock<T0>>(v0);
        LockAdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public entry fun new_lock_<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_lock<T0>(arg0, arg1);
        0x2::transfer::public_transfer<LockAdminCap<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun treasury_cap_mut<T0>(arg0: &LockAdminCap<T0>, arg1: &mut TreasuryLock<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg1.treasury_cap
    }

    public fun unban_mint_cap_id<T0>(arg0: &LockAdminCap<T0>, arg1: &mut TreasuryLock<T0>, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.banned_mint_authorities, &arg2);
    }

    public entry fun unban_mint_cap_id_<T0>(arg0: &LockAdminCap<T0>, arg1: &mut TreasuryLock<T0>, arg2: 0x2::object::ID) {
        unban_mint_cap_id<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


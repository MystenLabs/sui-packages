module 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::sub_delegate {
    struct ScopedCap has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
        policy_version: u64,
        coin: 0x1::type_name::TypeName,
        remaining: u64,
        depth: u8,
        max_depth: u8,
        parent: 0x1::option::Option<0x2::object::ID>,
    }

    struct ScopedAuth has drop {
        dummy_field: bool,
    }

    struct ScopedBudget has drop {
        dummy_field: bool,
    }

    struct ScopedCapMinted has copy, drop {
        wallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        budget: u64,
        depth: u8,
        max_depth: u8,
        parent: 0x1::option::Option<0x2::object::ID>,
    }

    struct ScopedSpent has copy, drop {
        wallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        remaining: u64,
    }

    public fun burn(arg0: ScopedCap) {
        let ScopedCap {
            id             : v0,
            wallet_id      : _,
            policy_version : _,
            coin           : _,
            remaining      : _,
            depth          : _,
            max_depth      : _,
            parent         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun coin(arg0: &ScopedCap) : 0x1::type_name::TypeName {
        arg0.coin
    }

    public fun depth(arg0: &ScopedCap) : u8 {
        arg0.depth
    }

    fun emit_minted(arg0: &ScopedCap) {
        let v0 = ScopedCapMinted{
            wallet_id : arg0.wallet_id,
            cap_id    : 0x2::object::id<ScopedCap>(arg0),
            coin      : arg0.coin,
            budget    : arg0.remaining,
            depth     : arg0.depth,
            max_depth : arg0.max_depth,
            parent    : arg0.parent,
        };
        0x2::event::emit<ScopedCapMinted>(v0);
    }

    public fun max_depth(arg0: &ScopedCap) : u8 {
        arg0.max_depth
    }

    public fun mint_root<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : ScopedCap {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg3);
        let v0 = ScopedCap{
            id             : 0x2::object::new(arg3),
            wallet_id      : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            policy_version : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::version(arg0),
            coin           : 0x1::type_name::with_defining_ids<T0>(),
            remaining      : arg1,
            depth          : 0,
            max_depth      : arg2,
            parent         : 0x1::option::none<0x2::object::ID>(),
        };
        emit_minted(&v0);
        v0
    }

    public fun mint_root_and_transfer<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ScopedCap>(mint_root<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun parent(arg0: &ScopedCap) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public fun policy_version(arg0: &ScopedCap) : u64 {
        arg0.policy_version
    }

    public fun remaining(arg0: &ScopedCap) : u64 {
        arg0.remaining
    }

    public fun spend(arg0: &mut ScopedCap, arg1: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::SpendRequest) {
        assert!(arg0.wallet_id == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_wallet_id(arg1), 1);
        assert!(arg0.policy_version == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_policy_version(arg1), 2);
        assert!(arg0.coin == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_coin(arg1), 3);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_amount(arg1);
        assert!(arg0.remaining >= v0, 4);
        arg0.remaining = arg0.remaining - v0;
        let v1 = ScopedAuth{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::add_auth_receipt<ScopedAuth>(v1, arg1);
        let v2 = ScopedBudget{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::add_caveat_receipt<ScopedBudget>(v2, arg1);
        let v3 = ScopedSpent{
            wallet_id : arg0.wallet_id,
            cap_id    : 0x2::object::id<ScopedCap>(arg0),
            coin      : arg0.coin,
            amount    : v0,
            remaining : arg0.remaining,
        };
        0x2::event::emit<ScopedSpent>(v3);
    }

    public fun subdelegate(arg0: &mut ScopedCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ScopedCap {
        assert!(arg0.depth < arg0.max_depth, 5);
        assert!(arg0.remaining >= arg1, 4);
        arg0.remaining = arg0.remaining - arg1;
        let v0 = ScopedCap{
            id             : 0x2::object::new(arg2),
            wallet_id      : arg0.wallet_id,
            policy_version : arg0.policy_version,
            coin           : arg0.coin,
            remaining      : arg1,
            depth          : arg0.depth + 1,
            max_depth      : arg0.max_depth,
            parent         : 0x1::option::some<0x2::object::ID>(0x2::object::id<ScopedCap>(arg0)),
        };
        emit_minted(&v0);
        v0
    }

    public fun subdelegate_and_transfer(arg0: &mut ScopedCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ScopedCap>(subdelegate(arg0, arg1, arg3), arg2);
    }

    public fun wallet_id(arg0: &ScopedCap) : 0x2::object::ID {
        arg0.wallet_id
    }

    // decompiled from Move bytecode v7
}


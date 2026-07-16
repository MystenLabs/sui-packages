module 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::cap_auth {
    struct DelegateCap has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
        policy_version: u64,
    }

    struct CapAuth has drop {
        dummy_field: bool,
    }

    struct DelegateCapMinted has copy, drop {
        wallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        policy_version: u64,
    }

    struct DelegateCapBurned has copy, drop {
        wallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public fun burn(arg0: DelegateCap) {
        let DelegateCap {
            id             : v0,
            wallet_id      : v1,
            policy_version : _,
        } = arg0;
        let v3 = v0;
        let v4 = DelegateCapBurned{
            wallet_id : v1,
            cap_id    : 0x2::object::uid_to_inner(&v3),
        };
        0x2::event::emit<DelegateCapBurned>(v4);
        0x2::object::delete(v3);
    }

    public fun cap_policy_version(arg0: &DelegateCap) : u64 {
        arg0.policy_version
    }

    public fun cap_wallet_id(arg0: &DelegateCap) : 0x2::object::ID {
        arg0.wallet_id
    }

    public fun is_current(arg0: &DelegateCap, arg1: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : bool {
        arg0.wallet_id == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg1) && arg0.policy_version == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::version(arg1)
    }

    public fun mint(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x2::tx_context::TxContext) : DelegateCap {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::version(arg0);
        let v2 = DelegateCap{
            id             : 0x2::object::new(arg1),
            wallet_id      : v0,
            policy_version : v1,
        };
        let v3 = DelegateCapMinted{
            wallet_id      : v0,
            cap_id         : 0x2::object::id<DelegateCap>(&v2),
            policy_version : v1,
        };
        0x2::event::emit<DelegateCapMinted>(v3);
        v2
    }

    public fun mint_and_transfer(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DelegateCap>(mint(arg0, arg2), arg1);
    }

    public fun prove(arg0: &DelegateCap, arg1: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::SpendRequest) {
        assert!(arg0.wallet_id == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_wallet_id(arg1), 1);
        assert!(arg0.policy_version == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::spend_policy_version(arg1), 2);
        let v0 = CapAuth{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy::add_auth_receipt<CapAuth>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}


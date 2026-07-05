module 0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::vesting {
    struct VestingVault has key {
        id: 0x2::object::UID,
        admin: address,
        beneficiary: address,
        balance: 0x2::balance::Balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>,
        total_amount: u64,
        claimed_amount: u64,
        start_ms: u64,
        revoked: bool,
    }

    struct VestingCreated has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        total_amount: u64,
    }

    struct VestingClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        total_claimed: u64,
    }

    struct VestingRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        returned_amount: u64,
    }

    public fun claim(arg0: &mut VestingVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(!arg0.revoked, 3);
        let v0 = claimable_amount(arg0, arg1);
        assert!(v0 > 0, 2);
        arg0.claimed_amount = arg0.claimed_amount + v0;
        let v1 = VestingClaimed{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            beneficiary   : 0x2::tx_context::sender(arg2),
            amount        : v0,
            total_claimed : arg0.claimed_amount,
        };
        0x2::event::emit<VestingClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(0x2::coin::from_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(0x2::balance::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg0.balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun claimable_amount(arg0: &VestingVault, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.revoked) {
            return 0
        };
        let v0 = vested_amount(arg0, arg1);
        if (v0 > arg0.claimed_amount) {
            v0 - arg0.claimed_amount
        } else {
            0
        }
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0);
        let v1 = 0x2::object::new(arg3);
        let v2 = VestingVault{
            id             : v1,
            admin          : 0x2::tx_context::sender(arg3),
            beneficiary    : arg1,
            balance        : 0x2::coin::into_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg0),
            total_amount   : v0,
            claimed_amount : 0,
            start_ms       : 0x2::clock::timestamp_ms(arg2),
            revoked        : false,
        };
        let v3 = VestingCreated{
            vault_id     : 0x2::object::uid_to_inner(&v1),
            beneficiary  : arg1,
            total_amount : v0,
        };
        0x2::event::emit<VestingCreated>(v3);
        0x2::transfer::share_object<VestingVault>(v2);
    }

    public fun revoke(arg0: &mut VestingVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        assert!(!arg0.revoked, 3);
        arg0.revoked = true;
        let v0 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.balance);
        let v1 = VestingRevoked{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            returned_amount : v0,
        };
        0x2::event::emit<VestingRevoked>(v1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(0x2::coin::from_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(0x2::balance::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg0.balance, v0), arg1), arg0.admin);
        };
    }

    public fun vested_amount(arg0: &VestingVault, arg1: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.start_ms) / 2592000000;
        if (v0 < 12) {
            return 0
        };
        let v1 = if (v0 >= 12 + 24) {
            24
        } else {
            v0 - 12
        };
        arg0.total_amount * v1 / 24
    }

    // decompiled from Move bytecode v7
}


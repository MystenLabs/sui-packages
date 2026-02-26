module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::vesting {
    struct VestingVault<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        total_amount: u64,
        released_amount: u64,
        start_epoch: u64,
        cliff_epochs: u64,
        vesting_epochs: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VestingCreated has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        total_amount: u64,
        start_epoch: u64,
        cliff_epochs: u64,
        vesting_epochs: u64,
    }

    struct VestingClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        claimed_amount: u64,
        total_released: u64,
        remaining: u64,
    }

    fun calculate_vested_amount<T0>(arg0: &VestingVault<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_epoch + arg0.cliff_epochs) {
            return 0
        };
        if (arg1 >= arg0.start_epoch + arg0.vesting_epochs) {
            return arg0.total_amount
        };
        arg0.total_amount * (arg1 - arg0.start_epoch - arg0.cliff_epochs) / (arg0.vesting_epochs - arg0.cliff_epochs)
    }

    public entry fun claim<T0>(arg0: &mut VestingVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.beneficiary, 100);
        let v1 = calculate_vested_amount<T0>(arg0, 0x2::tx_context::epoch(arg1)) - arg0.released_amount;
        assert!(v1 > 0, 102);
        arg0.released_amount = arg0.released_amount + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg1), v0);
        let v2 = VestingClaimed{
            vault_id       : 0x2::object::id<VestingVault<T0>>(arg0),
            beneficiary    : v0,
            claimed_amount : v1,
            total_released : arg0.released_amount,
            remaining      : arg0.total_amount - arg0.released_amount,
        };
        0x2::event::emit<VestingClaimed>(v2);
    }

    public fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 103);
        assert!(arg3 > arg2, 104);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = VestingVault<T0>{
            id              : 0x2::object::new(arg4),
            beneficiary     : arg1,
            total_amount    : v0,
            released_amount : 0,
            start_epoch     : v1,
            cliff_epochs    : arg2,
            vesting_epochs  : arg3,
            balance         : 0x2::coin::into_balance<T0>(arg0),
        };
        let v3 = VestingCreated{
            vault_id       : 0x2::object::id<VestingVault<T0>>(&v2),
            beneficiary    : arg1,
            total_amount   : v0,
            start_epoch    : v1,
            cliff_epochs   : arg2,
            vesting_epochs : arg3,
        };
        0x2::event::emit<VestingCreated>(v3);
        0x2::transfer::transfer<VestingVault<T0>>(v2, arg1);
    }

    public fun get_claimable<T0>(arg0: &VestingVault<T0>, arg1: u64) : u64 {
        let v0 = calculate_vested_amount<T0>(arg0, arg1);
        if (v0 > arg0.released_amount) {
            v0 - arg0.released_amount
        } else {
            0
        }
    }

    public fun get_progress_bps<T0>(arg0: &VestingVault<T0>, arg1: u64) : u64 {
        if (arg0.total_amount == 0) {
            return 0
        };
        calculate_vested_amount<T0>(arg0, arg1) * 10000 / arg0.total_amount
    }

    public fun get_vesting_info<T0>(arg0: &VestingVault<T0>) : (address, u64, u64, u64, u64, u64) {
        (arg0.beneficiary, arg0.total_amount, arg0.released_amount, arg0.start_epoch, arg0.cliff_epochs, arg0.vesting_epochs)
    }

    // decompiled from Move bytecode v6
}


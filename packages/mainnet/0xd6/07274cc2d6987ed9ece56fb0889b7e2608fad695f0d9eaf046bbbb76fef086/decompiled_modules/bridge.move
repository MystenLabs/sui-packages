module 0xd607274cc2d6987ed9ece56fb0889b7e2608fad695f0d9eaf046bbbb76fef086::bridge {
    struct DepositEvent has copy, drop {
        sender: address,
        evm_destination: vector<u8>,
        amount: u64,
        deposit_id: u64,
        action: u8,
    }

    struct Bridge<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<T0>,
        next_deposit_id: u64,
        max_per_deposit: u64,
        paused: bool,
        owner: address,
    }

    struct BRIDGE has drop {
        dummy_field: bool,
    }

    public fun create_bridge<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge<T0>{
            id              : 0x2::object::new(arg1),
            treasury        : 0x2::balance::zero<T0>(),
            next_deposit_id : 0,
            max_per_deposit : arg0,
            paused          : false,
            owner           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Bridge<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Bridge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 <= arg0.max_per_deposit, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 20, 3);
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(arg1));
        let v1 = arg0.next_deposit_id;
        arg0.next_deposit_id = v1 + 1;
        let v2 = DepositEvent{
            sender          : 0x2::tx_context::sender(arg4),
            evm_destination : arg2,
            amount          : v0,
            deposit_id      : v1,
            action          : arg3,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun is_paused<T0>(arg0: &Bridge<T0>) : bool {
        arg0.paused
    }

    public fun max_per_deposit<T0>(arg0: &Bridge<T0>) : u64 {
        arg0.max_per_deposit
    }

    public fun next_deposit_id<T0>(arg0: &Bridge<T0>) : u64 {
        arg0.next_deposit_id
    }

    public fun set_max_per_deposit<T0>(arg0: &mut Bridge<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.max_per_deposit = arg1;
    }

    public fun set_paused<T0>(arg0: &mut Bridge<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.paused = arg1;
    }

    public fun treasury_balance<T0>(arg0: &Bridge<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun withdraw<T0>(arg0: &mut Bridge<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}


module 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_collateral_vault {
    struct CollateralVault<phantom T0> has key {
        id: 0x2::object::UID,
        request_id: u64,
        borrower: address,
        collateral_token: address,
        required: u64,
        escrow: 0x2::balance::Balance<T0>,
        locked: bool,
        seized: bool,
        released: bool,
    }

    public(friend) fun cancel_unlocked<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.locked, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        assert!(!arg0.seized, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::already_finalized());
        arg0.released = true;
        take_all_escrow<T0>(arg0, arg1)
    }

    public(friend) fun claim_collateral<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        seize_collateral<T0>(arg0, arg1)
    }

    public fun create_collateral_vault<T0>(arg0: u64, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        create_collateral_vault_with_token<T0>(arg0, arg1, @0x0, arg2, arg3);
    }

    public fun create_collateral_vault_with_token<T0>(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        share<T0>(new_collateral_vault_with_token<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun get_collateral_token<T0>(arg0: &CollateralVault<T0>) : address {
        arg0.collateral_token
    }

    public fun get_posted<T0>(arg0: &CollateralVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun get_request_id<T0>(arg0: &CollateralVault<T0>) : u64 {
        arg0.request_id
    }

    public fun get_required<T0>(arg0: &CollateralVault<T0>) : u64 {
        arg0.required
    }

    public fun is_locked<T0>(arg0: &CollateralVault<T0>) : bool {
        arg0.locked
    }

    public fun is_released<T0>(arg0: &CollateralVault<T0>) : bool {
        arg0.released
    }

    public fun is_seized<T0>(arg0: &CollateralVault<T0>) : bool {
        arg0.seized
    }

    public(friend) fun lock_collateral<T0>(arg0: &mut CollateralVault<T0>) {
        assert!(!arg0.locked, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        assert!(0x2::balance::value<T0>(&arg0.escrow) >= arg0.required, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::insufficient_collateral());
        arg0.locked = true;
    }

    public fun lock_for_request<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        post_collateral<T0>(arg0, arg1, arg2);
    }

    public(friend) fun new_collateral_vault_with_token<T0>(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : CollateralVault<T0> {
        CollateralVault<T0>{
            id               : 0x2::object::new(arg4),
            request_id       : arg0,
            borrower         : arg1,
            collateral_token : arg2,
            required         : arg3,
            escrow           : 0x2::balance::zero<T0>(),
            locked           : false,
            seized           : false,
            released         : false,
        }
    }

    public(friend) fun pledge<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) : u64 {
        post_collateral<T0>(arg0, arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg0.escrow) >= arg0.required, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::insufficient_collateral());
        arg0.locked = true;
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun post_collateral<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        assert!(!arg0.locked, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun release_collateral<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.locked, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        assert!(!arg0.seized, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::already_finalized());
        arg0.released = true;
        arg0.locked = false;
        take_all_escrow<T0>(arg0, arg1)
    }

    public(friend) fun release_for_request<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        cancel_unlocked<T0>(arg0, arg1)
    }

    public(friend) fun seize_collateral<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.locked, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        assert!(!arg0.released, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::already_finalized());
        arg0.seized = true;
        arg0.locked = false;
        take_all_escrow<T0>(arg0, arg1)
    }

    public(friend) fun share<T0>(arg0: CollateralVault<T0>) {
        0x2::transfer::share_object<CollateralVault<T0>>(arg0);
    }

    fun take_all_escrow<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, 0x2::balance::value<T0>(&arg0.escrow)), arg1)
    }

    public(friend) fun unwind<T0>(arg0: &mut CollateralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.seized, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::already_finalized());
        arg0.released = true;
        arg0.locked = false;
        take_all_escrow<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}


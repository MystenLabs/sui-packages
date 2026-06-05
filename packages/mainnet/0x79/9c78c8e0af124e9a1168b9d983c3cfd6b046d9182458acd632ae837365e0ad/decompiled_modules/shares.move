module 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::shares {
    struct ShareReceipt has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u128,
    }

    public fun shares(arg0: &ShareReceipt) : u128 {
        arg0.shares
    }

    public(friend) fun credit(arg0: &mut ShareReceipt, arg1: u128) {
        arg0.shares = arg0.shares + arg1;
    }

    public(friend) fun deduct(arg0: &mut ShareReceipt, arg1: u128) {
        assert!(arg0.shares >= arg1, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::insufficient_shares());
        arg0.shares = arg0.shares - arg1;
    }

    public(friend) fun destroy_receipt_forcibly(arg0: ShareReceipt) {
        let ShareReceipt {
            id       : v0,
            vault_id : _,
            shares   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_zero(arg0: ShareReceipt) {
        let ShareReceipt {
            id       : v0,
            vault_id : _,
            shares   : v2,
        } = arg0;
        assert!(v2 == 0, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::share_receipt_not_empty());
        0x2::object::delete(v0);
    }

    public fun is_empty(arg0: &ShareReceipt) : bool {
        arg0.shares == 0
    }

    public fun join(arg0: &mut ShareReceipt, arg1: ShareReceipt) {
        let ShareReceipt {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        assert!(v1 == arg0.vault_id, 0x799c78c8e0af124e9a1168b9d983c3cfd6b046d9182458acd632ae837365e0ad::errors::wrong_vault_id());
        arg0.shares = arg0.shares + v2;
        0x2::object::delete(v0);
    }

    public(friend) fun new_receipt(arg0: 0x2::object::ID, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : ShareReceipt {
        ShareReceipt{
            id       : 0x2::object::new(arg2),
            vault_id : arg0,
            shares   : arg1,
        }
    }

    public(friend) fun transfer_receipt(arg0: ShareReceipt, arg1: address) {
        0x2::transfer::transfer<ShareReceipt>(arg0, arg1);
    }

    public fun vault_id(arg0: &ShareReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}


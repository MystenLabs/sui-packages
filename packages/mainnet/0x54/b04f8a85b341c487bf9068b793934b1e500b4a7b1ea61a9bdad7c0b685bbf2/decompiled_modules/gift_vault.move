module 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault {
    struct GiftVault has drop, store {
        creator: address,
        x_user_id_hash: vector<u8>,
        display_handle: vector<u8>,
        status: u8,
        created_at_ms: u64,
        claimed_at_ms: u64,
        owner_wallet: 0x1::option::Option<address>,
        payout_sui_address: 0x1::option::Option<address>,
        claimed_amount: u64,
    }

    public fun add_claimed_amount(arg0: &mut GiftVault, arg1: u64) {
        arg0.claimed_amount = arg0.claimed_amount + arg1;
    }

    public fun claim(arg0: &mut GiftVault, arg1: address, arg2: address, arg3: u64) {
        assert!(arg0.status == 0, 300);
        arg0.status = 1;
        arg0.claimed_at_ms = arg3;
        arg0.owner_wallet = 0x1::option::some<address>(arg1);
        arg0.payout_sui_address = 0x1::option::some<address>(arg2);
    }

    public fun creator(arg0: &GiftVault) : address {
        arg0.creator
    }

    public fun display_handle(arg0: &GiftVault) : &vector<u8> {
        &arg0.display_handle
    }

    public fun forfeit(arg0: &mut GiftVault, arg1: u64, arg2: u64) {
        assert!(arg0.status == 0, 303);
        assert!(arg1 >= arg0.created_at_ms + arg2, 304);
        arg0.status = 2;
    }

    public fun is_claimed(arg0: &GiftVault) : bool {
        arg0.status == 1
    }

    public fun is_forfeited(arg0: &GiftVault) : bool {
        arg0.status == 2
    }

    public fun is_pending(arg0: &GiftVault) : bool {
        arg0.status == 0
    }

    public fun new_pending(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : GiftVault {
        GiftVault{
            creator            : arg0,
            x_user_id_hash     : arg1,
            display_handle     : arg2,
            status             : 0,
            created_at_ms      : arg3,
            claimed_at_ms      : 0,
            owner_wallet       : 0x1::option::none<address>(),
            payout_sui_address : 0x1::option::none<address>(),
            claimed_amount     : 0,
        }
    }

    public fun owner_wallet(arg0: &GiftVault) : address {
        *0x1::option::borrow<address>(&arg0.owner_wallet)
    }

    public fun payout_sui_address(arg0: &GiftVault) : address {
        *0x1::option::borrow<address>(&arg0.payout_sui_address)
    }

    public fun update_payout(arg0: &mut GiftVault, arg1: address, arg2: address) {
        assert!(arg0.status == 1, 301);
        assert!(*0x1::option::borrow<address>(&arg0.owner_wallet) == arg1, 302);
        arg0.payout_sui_address = 0x1::option::some<address>(arg2);
    }

    public fun x_user_id_hash(arg0: &GiftVault) : &vector<u8> {
        &arg0.x_user_id_hash
    }

    // decompiled from Move bytecode v7
}


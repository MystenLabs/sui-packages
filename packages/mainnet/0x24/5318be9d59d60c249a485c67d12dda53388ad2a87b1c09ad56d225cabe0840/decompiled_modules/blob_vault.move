module 0x245318be9d59d60c249a485c67d12dda53388ad2a87b1c09ad56d225cabe0840::blob_vault {
    struct BlobEntry has copy, drop, store {
        blob_id: u256,
        paid_through_epoch: u64,
        renewal_count: u64,
        active: bool,
    }

    struct BlobVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        label: vector<u8>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        blobs: vector<BlobEntry>,
        total_spent: u64,
        total_renewals: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        label: vector<u8>,
    }

    struct BlobRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        paid_through_epoch: u64,
    }

    struct BlobRenewed has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        keeper: address,
        new_paid_through_epoch: u64,
        cost: u64,
        keeper_reward: u64,
    }

    struct VaultLowFunds has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        remaining: u64,
        blobs_count: u64,
    }

    public fun blob_count(arg0: &BlobVault) : u64 {
        0x1::vector::length<BlobEntry>(&arg0.blobs)
    }

    fun check_vault_health(arg0: &BlobVault) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.funds);
        let v1 = count_active(arg0);
        if (v1 == 0) {
            return
        };
        let v2 = v1 * (10000000 + 1000000);
        let v3 = if (v2 > 0) {
            v0 / v2
        } else {
            0
        };
        if (v3 < 5) {
            let v4 = VaultLowFunds{
                vault_id    : 0x2::object::id<BlobVault>(arg0),
                owner       : arg0.owner,
                remaining   : v0,
                blobs_count : v1,
            };
            0x2::event::emit<VaultLowFunds>(v4);
        };
    }

    fun count_active(arg0: &BlobVault) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BlobEntry>(&arg0.blobs)) {
            if (0x1::vector::borrow<BlobEntry>(&arg0.blobs, v1).active) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_vault(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : BlobVault {
        let v0 = BlobVault{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            label          : arg0,
            funds          : 0x2::balance::zero<0x2::sui::SUI>(),
            blobs          : 0x1::vector::empty<BlobEntry>(),
            total_spent    : 0,
            total_renewals : 0,
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::id<BlobVault>(&v0),
            owner    : 0x2::tx_context::sender(arg1),
            label    : v0.label,
        };
        0x2::event::emit<VaultCreated>(v1);
        v0
    }

    public fun deactivate_blob(arg0: &mut BlobVault, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<BlobEntry>(&arg0.blobs)) {
            let v2 = 0x1::vector::borrow_mut<BlobEntry>(&mut arg0.blobs, v0);
            if (v2.blob_id == arg1) {
                v2.active = false;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 1);
    }

    public fun register_blob(arg0: &mut BlobVault, arg1: u256, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(0x1::vector::length<BlobEntry>(&arg0.blobs) < 100, 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<BlobEntry>(&arg0.blobs)) {
            assert!(0x1::vector::borrow<BlobEntry>(&arg0.blobs, v0).blob_id != arg1, 2);
            v0 = v0 + 1;
        };
        let v1 = BlobEntry{
            blob_id            : arg1,
            paid_through_epoch : arg2,
            renewal_count      : 0,
            active             : true,
        };
        0x1::vector::push_back<BlobEntry>(&mut arg0.blobs, v1);
        let v2 = BlobRegistered{
            vault_id           : 0x2::object::id<BlobVault>(arg0),
            blob_id            : arg1,
            paid_through_epoch : arg2,
        };
        0x2::event::emit<BlobRegistered>(v2);
    }

    public fun renew_blob(arg0: &mut BlobVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x1::vector::length<BlobEntry>(&arg0.blobs), 1);
        let v0 = 0x1::vector::borrow<BlobEntry>(&arg0.blobs, arg1);
        assert!(v0.active, 1);
        assert!(v0.paid_through_epoch <= 0x2::tx_context::epoch(arg3) + 2, 4);
        let v1 = 10000000 * arg2 + 1000000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) >= v1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, 1000000), arg3), 0x2::tx_context::sender(arg3));
        let v2 = 0x1::vector::borrow_mut<BlobEntry>(&mut arg0.blobs, arg1);
        v2.paid_through_epoch = v2.paid_through_epoch + arg2;
        v2.renewal_count = v2.renewal_count + 1;
        arg0.total_spent = arg0.total_spent + v1;
        arg0.total_renewals = arg0.total_renewals + 1;
        let v3 = BlobRenewed{
            vault_id               : 0x2::object::id<BlobVault>(arg0),
            blob_id                : v2.blob_id,
            keeper                 : 0x2::tx_context::sender(arg3),
            new_paid_through_epoch : v2.paid_through_epoch,
            cost                   : 10000000 * arg2,
            keeper_reward          : 1000000,
        };
        0x2::event::emit<BlobRenewed>(v3);
        check_vault_health(arg0);
    }

    public fun top_up(arg0: &mut BlobVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun vault_balance(arg0: &BlobVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun vault_owner(arg0: &BlobVault) : address {
        arg0.owner
    }

    public fun withdraw(arg0: &mut BlobVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) >= arg1, 3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}


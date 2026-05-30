module 0x63545be54d514fd136e6595c283609e94112235e3df8f03605dc0768cf41b3ad::core {
    struct Vault has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        policy_hash: vector<u8>,
        price: u64,
        content_hash: vector<u8>,
        owner: address,
        is_active: bool,
    }

    struct AccessRequest has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        buyer: address,
        request_blob_id: 0x1::string::String,
        proof_hash: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_granted: bool,
        key_blob_id: 0x1::option::Option<0x1::string::String>,
        is_delivered: bool,
        is_confirmed: bool,
        is_disputed: bool,
        arbitrator: address,
    }

    struct VaultRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        policy_hash: vector<u8>,
        price: u64,
        content_hash: vector<u8>,
        owner: address,
    }

    struct AccessRequested has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        buyer: address,
        request_blob_id: 0x1::string::String,
        proof_hash: vector<u8>,
        price: u64,
    }

    struct AccessGranted has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        buyer: address,
        key_blob_id: 0x1::string::String,
        owner_ephemeral_pk: vector<u8>,
    }

    struct AccessConfirmed has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        buyer: address,
        owner: address,
        amount: u64,
    }

    struct AccessDisputed has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        buyer: address,
        owner: address,
    }

    struct AccessArbitrated has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        buyer: address,
        owner: address,
        refunded: bool,
        amount: u64,
    }

    public entry fun arbitrate_dispute(arg0: &Vault, arg1: &mut AccessRequest, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.arbitrator, 10);
        assert!(arg1.is_disputed, 11);
        arg1.is_confirmed = true;
        arg1.is_disputed = false;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), arg1.buyer);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), arg0.owner);
        };
        let v1 = AccessArbitrated{
            request_id : 0x2::object::id<AccessRequest>(arg1),
            vault_id   : 0x2::object::id<Vault>(arg0),
            buyer      : arg1.buyer,
            owner      : arg0.owner,
            refunded   : arg2,
            amount     : v0,
        };
        0x2::event::emit<AccessArbitrated>(v1);
    }

    public entry fun confirm_delivery(arg0: &Vault, arg1: &mut AccessRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.buyer, 6);
        assert!(arg1.is_delivered, 7);
        assert!(!arg1.is_confirmed, 8);
        assert!(!arg1.is_disputed, 9);
        arg1.is_confirmed = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), arg0.owner);
        let v1 = AccessConfirmed{
            request_id : 0x2::object::id<AccessRequest>(arg1),
            vault_id   : 0x2::object::id<Vault>(arg0),
            buyer      : arg1.buyer,
            owner      : arg0.owner,
            amount     : v0,
        };
        0x2::event::emit<AccessConfirmed>(v1);
    }

    public entry fun dispute_access(arg0: &Vault, arg1: &mut AccessRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.buyer, 6);
        assert!(arg1.is_delivered, 7);
        assert!(!arg1.is_confirmed, 8);
        assert!(!arg1.is_disputed, 9);
        arg1.is_disputed = true;
        let v0 = AccessDisputed{
            request_id : 0x2::object::id<AccessRequest>(arg1),
            vault_id   : 0x2::object::id<Vault>(arg0),
            buyer      : arg1.buyer,
            owner      : arg0.owner,
        };
        0x2::event::emit<AccessDisputed>(v0);
    }

    public entry fun grant_access(arg0: &Vault, arg1: &mut AccessRequest, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        assert!(!arg1.is_granted, 3);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        arg1.is_granted = true;
        arg1.is_delivered = true;
        0x1::option::fill<0x1::string::String>(&mut arg1.key_blob_id, arg2);
        let v0 = AccessGranted{
            request_id         : 0x2::object::id<AccessRequest>(arg1),
            vault_id           : 0x2::object::id<Vault>(arg0),
            buyer              : arg1.buyer,
            key_blob_id        : arg2,
            owner_ephemeral_pk : arg3,
        };
        0x2::event::emit<AccessGranted>(v0);
    }

    public entry fun register_vault(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Vault{
            id           : v0,
            blob_id      : arg0,
            policy_hash  : arg1,
            price        : arg2,
            content_hash : arg3,
            owner        : 0x2::tx_context::sender(arg4),
            is_active    : true,
        };
        let v2 = VaultRegistered{
            vault_id     : 0x2::object::uid_to_inner(&v0),
            blob_id      : arg0,
            policy_hash  : arg1,
            price        : arg2,
            content_hash : arg3,
            owner        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<VaultRegistered>(v2);
        0x2::transfer::share_object<Vault>(v1);
    }

    public entry fun request_access(arg0: &Vault, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg0.price, 1);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg4, &arg5), 4);
        let v0 = 0x2::object::new(arg8);
        let v1 = AccessRequest{
            id              : v0,
            vault_id        : 0x2::object::id<Vault>(arg0),
            buyer           : 0x2::tx_context::sender(arg8),
            request_blob_id : arg1,
            proof_hash      : arg2,
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg6),
            is_granted      : false,
            key_blob_id     : 0x1::option::none<0x1::string::String>(),
            is_delivered    : false,
            is_confirmed    : false,
            is_disputed     : false,
            arbitrator      : arg7,
        };
        let v2 = AccessRequested{
            request_id      : 0x2::object::uid_to_inner(&v0),
            vault_id        : 0x2::object::id<Vault>(arg0),
            buyer           : 0x2::tx_context::sender(arg8),
            request_blob_id : arg1,
            proof_hash      : arg2,
            price           : arg0.price,
        };
        0x2::event::emit<AccessRequested>(v2);
        0x2::transfer::share_object<AccessRequest>(v1);
    }

    // decompiled from Move bytecode v6
}


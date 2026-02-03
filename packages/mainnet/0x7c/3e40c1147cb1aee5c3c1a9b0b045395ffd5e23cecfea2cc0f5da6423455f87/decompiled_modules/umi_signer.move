module 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::umi_signer {
    struct ChainId has copy, drop, store {
        name: vector<u8>,
    }

    struct WalletKey has copy, drop, store {
        pos0: ChainId,
    }

    struct LockKey has copy, drop, store {
        pos0: ChainId,
    }

    struct WalletMetaKey has copy, drop, store {
        pos0: ChainId,
    }

    struct UserShareKey has copy, drop, store {
        pos0: ChainId,
        pos1: address,
    }

    struct BorrowedWallet has drop, store {
        wallet_id: 0x2::object::ID,
        locked: bool,
    }

    struct WalletMeta has copy, drop, store {
        dwallet_id: 0x2::object::ID,
        is_zero_trust: bool,
    }

    struct UmiSignerOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct BorrowReceipt {
        signer_id: 0x2::object::ID,
        chain_id: ChainId,
        wallet_id: 0x2::object::ID,
    }

    struct UmiSigner has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        wallet_count: u32,
        last_owner_activity_ts: u64,
        last_signing_activity_ts: u64,
    }

    public fun approve_with_tx(arg0: &mut UmiSigner, arg1: ChainId, arg2: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg3: 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningRequest, arg4: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : (0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval, BorrowReceipt) {
        assert!(has_wallet(arg0, arg1), 3);
        assert!(0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::signer_id(&arg3) == 0x2::object::id<UmiSigner>(arg0), 7);
        assert!(0x2::object::id<0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy>(arg2) == arg0.policy_id, 8);
        assert!(0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::requires_message_binding(arg2), 10);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::enforce_request(arg2, &arg3);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::destroy_request(arg3);
        let v0 = WalletKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::remove<WalletKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v0);
        let v2 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v1);
        let v3 = LockKey{pos0: arg1};
        let v4 = WalletKey{pos0: arg1};
        let v5 = BorrowedWallet{
            wallet_id : v2,
            locked    : 0x2::dynamic_field::exists_<LockKey>(&arg0.id, v3),
        };
        0x2::dynamic_field::add<WalletKey, BorrowedWallet>(&mut arg0.id, v4, v5);
        arg0.last_signing_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg8);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::signing_occurred(0x2::object::id<UmiSigner>(arg0), arg1.name, v2, 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::intent_hash(&arg3));
        let v6 = BorrowReceipt{
            signer_id : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg1,
            wallet_id : v2,
        };
        (v1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg4, &v1, arg5, arg6, arg7), v6)
    }

    public fun borrow_for_signing(arg0: &mut UmiSigner, arg1: ChainId, arg2: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg3: 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningRequest, arg4: &mut 0x2::tx_context::TxContext) : (0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, BorrowReceipt) {
        assert!(has_wallet(arg0, arg1), 3);
        assert!(0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::signer_id(&arg3) == 0x2::object::id<UmiSigner>(arg0), 7);
        assert!(0x2::object::id<0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy>(arg2) == arg0.policy_id, 8);
        assert!(!0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::requires_message_binding(arg2), 9);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::enforce_request(arg2, &arg3);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::destroy_request(arg3);
        let v0 = WalletKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::remove<WalletKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v0);
        let v2 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v1);
        let v3 = LockKey{pos0: arg1};
        let v4 = WalletKey{pos0: arg1};
        let v5 = BorrowedWallet{
            wallet_id : v2,
            locked    : 0x2::dynamic_field::exists_<LockKey>(&arg0.id, v3),
        };
        0x2::dynamic_field::add<WalletKey, BorrowedWallet>(&mut arg0.id, v4, v5);
        arg0.last_signing_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg4);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::signing_occurred(0x2::object::id<UmiSigner>(arg0), arg1.name, v2, 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::intent_hash(&arg3));
        let v6 = BorrowReceipt{
            signer_id : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg1,
            wallet_id : v2,
        };
        (v1, v6)
    }

    public fun close(arg0: UmiSigner, arg1: UmiSignerOwnerCap) {
        let UmiSigner {
            id                       : v0,
            owner                    : _,
            policy_id                : _,
            wallet_count             : v3,
            last_owner_activity_ts   : _,
            last_signing_activity_ts : _,
        } = arg0;
        let v6 = v0;
        let UmiSignerOwnerCap {
            id  : v7,
            for : v8,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&v6) == v8, 0);
        assert!(v3 == 0, 2);
        0x2::object::delete(v7);
        0x2::object::delete(v6);
    }

    entry fun default(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2, v3, v4) = new_with_policy(v0, arg0);
        0x2::transfer::share_object<UmiSigner>(v1);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::share(v3);
        0x2::transfer::transfer<UmiSignerOwnerCap>(v2, v0);
        0x2::transfer::public_transfer<0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap>(v4, v0);
    }

    public fun get_dwallet_id(arg0: &UmiSigner, arg1: ChainId) : 0x2::object::ID {
        assert!(has_wallet(arg0, arg1), 3);
        let v0 = WalletMetaKey{pos0: arg1};
        0x2::dynamic_field::borrow<WalletMetaKey, WalletMeta>(&arg0.id, v0).dwallet_id
    }

    public fun get_user_share_id(arg0: &UmiSigner, arg1: ChainId, arg2: address) : 0x2::object::ID {
        assert!(has_user_share(arg0, arg1, arg2), 11);
        let v0 = UserShareKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        *0x2::dynamic_field::borrow<UserShareKey, 0x2::object::ID>(&arg0.id, v0)
    }

    public fun has_access(arg0: &UmiSigner, arg1: &UmiSignerOwnerCap) : bool {
        0x2::object::id<UmiSigner>(arg0) == arg1.for
    }

    public fun has_user_share(arg0: &UmiSigner, arg1: ChainId, arg2: address) : bool {
        let v0 = UserShareKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::dynamic_field::exists_<UserShareKey>(&arg0.id, v0)
    }

    public fun has_wallet(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = WalletKey{pos0: arg1};
        0x2::dynamic_field::exists_<WalletKey>(&arg0.id, v0)
    }

    public fun is_borrowed(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = WalletKey{pos0: arg1};
        0x2::dynamic_field::exists_with_type<WalletKey, BorrowedWallet>(&arg0.id, v0)
    }

    public fun is_locked(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = LockKey{pos0: arg1};
        0x2::dynamic_field::exists_<LockKey>(&arg0.id, v0)
    }

    public fun is_zero_trust(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = WalletMetaKey{pos0: arg1};
        if (!0x2::dynamic_field::exists_<WalletMetaKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = WalletMetaKey{pos0: arg1};
        0x2::dynamic_field::borrow<WalletMetaKey, WalletMeta>(&arg0.id, v1).is_zero_trust
    }

    public fun last_owner_activity_ts(arg0: &UmiSigner) : u64 {
        arg0.last_owner_activity_ts
    }

    public fun last_signing_activity_ts(arg0: &UmiSigner) : u64 {
        arg0.last_signing_activity_ts
    }

    public fun lock(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: 0x2::object::ID, arg4: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(!has_wallet(arg0, arg2), 4);
        let v0 = 0x1::option::is_some<0x2::object::ID>(&arg6);
        place_internal(arg0, arg2, arg5, true, arg3, v0);
        if (v0) {
            let v1 = arg0.owner;
            let v2 = 0x1::option::destroy_some<0x2::object::ID>(arg6);
            let v3 = UserShareKey{
                pos0 : arg2,
                pos1 : v1,
            };
            0x2::dynamic_field::add<UserShareKey, 0x2::object::ID>(&mut arg0.id, v3, v2);
            0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::user_share_registered(0x2::object::id<UmiSigner>(arg0), arg2.name, v1, v2);
        } else {
            0x1::option::destroy_none<0x2::object::ID>(arg6);
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg7);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::wallet_placed(0x2::object::id<UmiSigner>(arg0), arg2.name, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg5), true);
    }

    public fun new_chain_id(arg0: vector<u8>) : ChainId {
        ChainId{name: arg0}
    }

    public fun new_with_policy(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (UmiSigner, UmiSignerOwnerCap, 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap) {
        let (v0, v1) = 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = UmiSigner{
            id                       : 0x2::object::new(arg1),
            owner                    : arg0,
            policy_id                : 0x2::object::id<0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy>(&v3),
            wallet_count             : 0,
            last_owner_activity_ts   : 0x2::tx_context::epoch_timestamp_ms(arg1),
            last_signing_activity_ts : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v5 = UmiSignerOwnerCap{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::id<UmiSigner>(&v4),
        };
        let v6 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v6, arg0);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::authorization_rule::add(&mut v3, &v2, v6);
        (v4, v5, v3, v2)
    }

    public fun owner(arg0: &UmiSigner) : address {
        arg0.owner
    }

    public fun place(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: 0x2::object::ID, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(!has_wallet(arg0, arg2), 4);
        let v0 = 0x1::option::is_some<0x2::object::ID>(&arg5);
        place_internal(arg0, arg2, arg4, false, arg3, v0);
        if (v0) {
            let v1 = arg0.owner;
            let v2 = 0x1::option::destroy_some<0x2::object::ID>(arg5);
            let v3 = UserShareKey{
                pos0 : arg2,
                pos1 : v1,
            };
            0x2::dynamic_field::add<UserShareKey, 0x2::object::ID>(&mut arg0.id, v3, v2);
            0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::user_share_registered(0x2::object::id<UmiSigner>(arg0), arg2.name, v1, v2);
        } else {
            0x1::option::destroy_none<0x2::object::ID>(arg5);
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg6);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::wallet_placed(0x2::object::id<UmiSigner>(arg0), arg2.name, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg4), false);
    }

    fun place_internal(arg0: &mut UmiSigner, arg1: ChainId, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: bool, arg4: 0x2::object::ID, arg5: bool) {
        if (arg3) {
            let v0 = LockKey{pos0: arg1};
            0x2::dynamic_field::add<LockKey, bool>(&mut arg0.id, v0, true);
        };
        let v1 = WalletKey{pos0: arg1};
        0x2::dynamic_field::add<WalletKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v1, arg2);
        let v2 = WalletMetaKey{pos0: arg1};
        let v3 = WalletMeta{
            dwallet_id    : arg4,
            is_zero_trust : arg5,
        };
        0x2::dynamic_field::add<WalletMetaKey, WalletMeta>(&mut arg0.id, v2, v3);
        arg0.wallet_count = arg0.wallet_count + 1;
    }

    public fun policy_id(arg0: &UmiSigner) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun register_user_share(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: address, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_wallet(arg0, arg2), 3);
        assert!(is_zero_trust(arg0, arg2), 16);
        assert!(!has_user_share(arg0, arg2, arg3), 12);
        let v0 = UserShareKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        0x2::dynamic_field::add<UserShareKey, 0x2::object::ID>(&mut arg0.id, v0, arg4);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg5);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::user_share_registered(0x2::object::id<UmiSigner>(arg0), arg2.name, arg3, arg4);
    }

    public fun return_wallet(arg0: &mut UmiSigner, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: BorrowReceipt) {
        let BorrowReceipt {
            signer_id : v0,
            chain_id  : v1,
            wallet_id : v2,
        } = arg2;
        assert!(0x2::object::id<UmiSigner>(arg0) == v0, 6);
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg1) == v2, 5);
        let v3 = WalletKey{pos0: v1};
        0x2::dynamic_field::remove<WalletKey, BorrowedWallet>(&mut arg0.id, v3);
        let v4 = WalletKey{pos0: v1};
        0x2::dynamic_field::add<WalletKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v4, arg1);
    }

    public fun set_owner(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.owner = 0x2::tx_context::sender(arg2);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun signer_owner_cap_for(arg0: &UmiSignerOwnerCap) : 0x2::object::ID {
        arg0.for
    }

    public fun touch(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun uid(arg0: &UmiSigner) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut UmiSigner) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_as_owner(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap) : &mut 0x2::object::UID {
        assert!(has_access(arg0, arg1), 0);
        &mut arg0.id
    }

    public fun unregister_user_share(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_user_share(arg0, arg2, arg3), 11);
        assert!(arg3 != arg0.owner, 17);
        let v0 = UserShareKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg4);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::user_share_unregistered(0x2::object::id<UmiSigner>(arg0), arg2.name, arg3, 0x2::dynamic_field::remove<UserShareKey, 0x2::object::ID>(&mut arg0.id, v0));
    }

    public fun wallet_count(arg0: &UmiSigner) : u32 {
        arg0.wallet_count
    }

    public fun withdraw(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: &0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_wallet(arg0, arg2), 3);
        assert!(!is_locked(arg0, arg2), 1);
        let v0 = WalletKey{pos0: arg2};
        let v1 = 0x2::dynamic_field::remove<WalletKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v0);
        let v2 = WalletMetaKey{pos0: arg2};
        0x2::dynamic_field::remove<WalletMetaKey, WalletMeta>(&mut arg0.id, v2);
        arg0.wallet_count = arg0.wallet_count - 1;
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::events::wallet_withdrawn(0x2::object::id<UmiSigner>(arg0), arg2.name, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v1));
        v1
    }

    // decompiled from Move bytecode v6
}


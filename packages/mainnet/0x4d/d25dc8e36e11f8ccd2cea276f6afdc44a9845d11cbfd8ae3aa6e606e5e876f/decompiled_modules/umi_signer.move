module 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::umi_signer {
    struct ChainId has copy, drop, store {
        name: vector<u8>,
    }

    struct LockedWallet has drop, store {
        wallet_id: 0x2::object::ID,
        locked: bool,
    }

    struct UmiSigner has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        wallet_count: u32,
        last_owner_activity_ts: u64,
    }

    struct UmiSignerOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct BorrowReceipt<phantom T0: store + key> {
        signer_id: 0x2::object::ID,
        chain_id: ChainId,
        wallet_id: 0x2::object::ID,
    }

    struct Wallet has copy, drop, store {
        chain_id: ChainId,
    }

    struct Lock has copy, drop, store {
        chain_id: ChainId,
    }

    struct WalletPlaced has copy, drop {
        signer: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
        locked: bool,
    }

    struct WalletWithdrawn has copy, drop {
        signer: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
    }

    struct SigningOccurred has copy, drop {
        signer: 0x2::object::ID,
        chain_id: vector<u8>,
        wallet_id: 0x2::object::ID,
        intent_hash: vector<u8>,
    }

    public fun borrow_for_signing<T0: store + key>(arg0: &mut UmiSigner, arg1: ChainId, arg2: &0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy, arg3: 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningRequest, arg4: &mut 0x2::tx_context::TxContext) : (T0, BorrowReceipt<T0>) {
        assert!(has_wallet(arg0, arg1), 3);
        assert!(0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::signer_id(&arg3) == 0x2::object::id<UmiSigner>(arg0), 8);
        assert!(0x2::object::id<0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy>(arg2) == arg0.policy_id, 9);
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::verify_request<UmiSigner>(&arg3, arg2, arg0, arg4);
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::destroy_request(arg3);
        let v0 = Wallet{chain_id: arg1};
        let v1 = 0x2::dynamic_field::remove<Wallet, T0>(&mut arg0.id, v0);
        let v2 = 0x2::object::id<T0>(&v1);
        let v3 = Lock{chain_id: arg1};
        let v4 = BorrowReceipt<T0>{
            signer_id : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg1,
            wallet_id : v2,
        };
        let v5 = Wallet{chain_id: arg1};
        let v6 = LockedWallet{
            wallet_id : v2,
            locked    : 0x2::dynamic_field::exists_<Lock>(&arg0.id, v3),
        };
        0x2::dynamic_field::add<Wallet, LockedWallet>(&mut arg0.id, v5, v6);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v7 = SigningOccurred{
            signer      : 0x2::object::id<UmiSigner>(arg0),
            chain_id    : arg1.name,
            wallet_id   : v2,
            intent_hash : 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::intent_hash(&arg3),
        };
        0x2::event::emit<SigningOccurred>(v7);
        (v1, v4)
    }

    public fun close(arg0: UmiSigner, arg1: UmiSignerOwnerCap) {
        let UmiSigner {
            id                     : v0,
            owner                  : _,
            policy_id              : _,
            wallet_count           : v3,
            last_owner_activity_ts : _,
        } = arg0;
        let v5 = v0;
        let UmiSignerOwnerCap {
            id  : v6,
            for : v7,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&v5) == v7, 0);
        assert!(v3 == 0, 2);
        0x2::object::delete(v6);
        0x2::object::delete(v5);
    }

    entry fun default(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2, v3, v4) = new_with_policy(v0, arg0);
        0x2::transfer::share_object<UmiSigner>(v1);
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::share(v3);
        0x2::transfer::transfer<UmiSignerOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicyCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun has_access(arg0: &UmiSigner, arg1: &UmiSignerOwnerCap) : bool {
        0x2::object::id<UmiSigner>(arg0) == arg1.for
    }

    public fun has_wallet(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = Wallet{chain_id: arg1};
        0x2::dynamic_field::exists_<Wallet>(&arg0.id, v0)
    }

    public fun is_locked(arg0: &UmiSigner, arg1: ChainId) : bool {
        let v0 = Lock{chain_id: arg1};
        0x2::dynamic_field::exists_<Lock>(&arg0.id, v0)
    }

    public fun last_owner_activity_ts(arg0: &UmiSigner) : u64 {
        arg0.last_owner_activity_ts
    }

    public fun lock<T0: store + key>(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: &0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy, arg4: T0, arg5: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(!has_wallet(arg0, arg2), 4);
        place_internal<T0>(arg0, arg2, arg4, true);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v0 = WalletPlaced{
            signer    : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg2.name,
            wallet_id : 0x2::object::id<T0>(&arg4),
            locked    : true,
        };
        0x2::event::emit<WalletPlaced>(v0);
    }

    public fun new_chain_id(arg0: vector<u8>) : ChainId {
        ChainId{name: arg0}
    }

    fun new_internal(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x2::object::ID, arg2: address) : (UmiSigner, UmiSignerOwnerCap) {
        let v0 = UmiSigner{
            id                     : 0x2::object::new(arg0),
            owner                  : arg2,
            policy_id              : arg1,
            wallet_count           : 0,
            last_owner_activity_ts : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v1 = UmiSignerOwnerCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<UmiSigner>(&v0),
        };
        (v0, v1)
    }

    public fun new_with_policy(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (UmiSigner, UmiSignerOwnerCap, 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy, 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicyCap) {
        let (v0, v1) = 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = new_internal(arg1, 0x2::object::id<0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy>(&v3), arg0);
        let v6 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v6, arg0);
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::authorization_rule::add(&mut v3, &v2, v6);
        (v4, v5, v3, v2)
    }

    public fun owner(arg0: &UmiSigner) : address {
        arg0.owner
    }

    public fun place<T0: store + key>(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: T0, arg4: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        assert!(!has_wallet(arg0, arg2), 4);
        let v0 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v0) == 0x1::ascii::string(b"0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap"), 7);
        place_internal<T0>(arg0, arg2, arg3, false);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v1 = WalletPlaced{
            signer    : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg2.name,
            wallet_id : 0x2::object::id<T0>(&arg3),
            locked    : false,
        };
        0x2::event::emit<WalletPlaced>(v1);
    }

    fun place_internal<T0: store + key>(arg0: &mut UmiSigner, arg1: ChainId, arg2: T0, arg3: bool) {
        if (arg3) {
            let v0 = Lock{chain_id: arg1};
            0x2::dynamic_field::add<Lock, bool>(&mut arg0.id, v0, true);
        };
        let v1 = Wallet{chain_id: arg1};
        0x2::dynamic_field::add<Wallet, T0>(&mut arg0.id, v1, arg2);
        arg0.wallet_count = arg0.wallet_count + 1;
    }

    public fun policy_id(arg0: &UmiSigner) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun return_wallet<T0: store + key>(arg0: &mut UmiSigner, arg1: T0, arg2: BorrowReceipt<T0>) {
        let BorrowReceipt {
            signer_id : v0,
            chain_id  : v1,
            wallet_id : v2,
        } = arg2;
        assert!(0x2::object::id<UmiSigner>(arg0) == v0, 6);
        assert!(0x2::object::id<T0>(&arg1) == v2, 5);
        let v3 = Wallet{chain_id: v1};
        0x2::dynamic_field::remove<Wallet, LockedWallet>(&mut arg0.id, v3);
        let v4 = Wallet{chain_id: v1};
        0x2::dynamic_field::add<Wallet, T0>(&mut arg0.id, v4, arg1);
    }

    public fun set_owner(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.owner = 0x2::tx_context::sender(arg2);
    }

    public fun signer_owner_cap_for(arg0: &UmiSignerOwnerCap) : 0x2::object::ID {
        arg0.for
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

    public fun wallet_count(arg0: &UmiSigner) : u32 {
        arg0.wallet_count
    }

    public fun withdraw<T0: store + key>(arg0: &mut UmiSigner, arg1: &UmiSignerOwnerCap, arg2: ChainId, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_wallet(arg0, arg2), 3);
        assert!(!is_locked(arg0, arg2), 1);
        let v0 = Wallet{chain_id: arg2};
        let v1 = 0x2::dynamic_field::remove<Wallet, T0>(&mut arg0.id, v0);
        arg0.wallet_count = arg0.wallet_count - 1;
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = WalletWithdrawn{
            signer    : 0x2::object::id<UmiSigner>(arg0),
            chain_id  : arg2.name,
            wallet_id : 0x2::object::id<T0>(&v1),
        };
        0x2::event::emit<WalletWithdrawn>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}


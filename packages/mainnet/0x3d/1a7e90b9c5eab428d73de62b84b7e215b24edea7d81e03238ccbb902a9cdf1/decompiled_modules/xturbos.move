module 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos {
    struct XTURBOS has drop {
        dummy_field: bool,
    }

    struct XturbosManager has key {
        id: 0x2::object::UID,
        index: u64,
        has_venft: 0x2::table::Table<address, bool>,
        nfts: 0x2::linked_table::LinkedTable<0x2::object::ID, VeNftInfo>,
        treasury: 0x2::coin::TreasuryCap<XTURBOS>,
        total_locked: u64,
    }

    struct VeNftInfo has drop, store {
        id: 0x2::object::ID,
        xturbos_amount: u64,
        lock_amount: u64,
    }

    struct VeNFT has key {
        id: 0x2::object::UID,
        index: u64,
        xturbos_balance: 0x2::balance::Balance<XTURBOS>,
    }

    struct TransferVeNFTRequest has drop, store {
        venft_id: 0x2::object::ID,
        target_owner: address,
    }

    struct InitEvent has copy, drop, store {
        xturbos_manager: 0x2::object::ID,
        metadata: 0x2::object::ID,
    }

    struct MintVeNFTEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        index: u64,
    }

    struct BurnVeNFTEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct BurnEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct RequestTransferEvent has copy, drop, store {
        venft: 0x2::object::ID,
        target_owner: address,
    }

    struct CancelTransferRequestEvent has copy, drop, store {
        venft: 0x2::object::ID,
    }

    struct ApproveTransferEvent has copy, drop, store {
        venft: 0x2::object::ID,
        source_owner: address,
        target_owner: address,
    }

    public fun value(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager, arg2: &VeNFT) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg1.nfts, 0x2::object::uid_to_inner(&arg2.id));
        assert!(v0.xturbos_amount == 0x2::balance::value<XTURBOS>(&arg2.xturbos_balance), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::amount_mismatch());
        v0.xturbos_amount
    }

    public(friend) fun burn(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &mut VeNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::coin::burn<XTURBOS>(&mut arg1.treasury, 0x2::coin::from_balance<XTURBOS>(0x2::balance::split<XTURBOS>(&mut arg2.xturbos_balance, arg3), arg4));
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, 0x2::object::id<VeNFT>(arg2));
        v0.xturbos_amount = v0.xturbos_amount - arg3;
        let v1 = BurnEvent{
            nft_id : 0x2::object::id<VeNFT>(arg2),
            amount : arg3,
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public(friend) fun approve_transfer_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: VeNFT, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::object::id<VeNFT>(&arg2);
        assert!(0x2::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg1.nfts, v0).lock_amount == 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::venft_is_locked());
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, v0), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::transfer_request_not_exists());
        let v1 = 0x2::dynamic_field::remove<0x2::object::ID, TransferVeNFTRequest>(&mut arg1.id, v0);
        assert!(v0 == v1.venft_id, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::venft_id_mismatch());
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::table::remove<address, bool>(&mut arg1.has_venft, v2);
        assert!(v1.target_owner == arg3, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::target_owner_mismatch());
        assert!(!0x2::table::contains<address, bool>(&arg1.has_venft, v1.target_owner), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::user_already_has_venft());
        0x2::table::add<address, bool>(&mut arg1.has_venft, v1.target_owner, true);
        0x2::transfer::transfer<VeNFT>(arg2, v1.target_owner);
        let v3 = ApproveTransferEvent{
            venft        : v0,
            source_owner : v2,
            target_owner : arg3,
        };
        0x2::event::emit<ApproveTransferEvent>(v3);
    }

    public fun available_value(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager, arg2: &VeNFT) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg1.nfts, 0x2::object::uid_to_inner(&arg2.id));
        assert!(v0.xturbos_amount == 0x2::balance::value<XTURBOS>(&arg2.xturbos_balance), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::amount_mismatch());
        v0.xturbos_amount - v0.lock_amount
    }

    public fun burn_by_admin(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &mut VeNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_xturbos_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(available_value(arg0, arg1, arg2) >= arg3, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_available_value());
        burn(arg0, arg1, arg2, arg3, arg4);
    }

    public fun burn_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: VeNFT, arg3: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        assert!(0x2::balance::value<XTURBOS>(&arg2.xturbos_balance) == 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::venft_balance_not_zero());
        let VeNFT {
            id              : v0,
            index           : _,
            xturbos_balance : v2,
        } = arg2;
        let v3 = v0;
        let v4 = 0x2::object::uid_to_inner(&v3);
        assert!(0x2::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg1.nfts, v4).xturbos_amount == 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::venft_amount_not_zero());
        0x2::object::delete(v3);
        0x2::balance::destroy_zero<XTURBOS>(v2);
        0x2::linked_table::remove<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, v4);
        0x2::table::remove<address, bool>(&mut arg1.has_venft, 0x2::tx_context::sender(arg3));
        let v5 = BurnVeNFTEvent{nft_id: v4};
        0x2::event::emit<BurnVeNFTEvent>(v5);
    }

    public(friend) fun cancel_transfer_venft_request_by_admin(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: 0x2::object::ID) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::transfer_request_not_exists());
        0x2::dynamic_field::remove<0x2::object::ID, TransferVeNFTRequest>(&mut arg1.id, arg2);
        let v0 = CancelTransferRequestEvent{venft: arg2};
        0x2::event::emit<CancelTransferRequestEvent>(v0);
    }

    fun init(arg0: XTURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTURBOS>(arg0, 9, b"xTURBOS", b"Turbos Escrowed Token", b"xTURBOS is a non-transferable escrowed governance token, corresponding to staked TURBOS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7rgiihm5sisgewirofazpjddkpvmlwphumcg5lulriu6okgf5krq.arweave.net/_EyEHZ2SJGJZEXFBl6RjU-rF2eejBG6ui4op5yjF6qM")), arg1);
        let v2 = v1;
        let v3 = XturbosManager{
            id           : 0x2::object::new(arg1),
            index        : 0,
            has_venft    : 0x2::table::new<address, bool>(arg1),
            nfts         : 0x2::linked_table::new<0x2::object::ID, VeNftInfo>(arg1),
            treasury     : v0,
            total_locked : 0,
        };
        0x2::transfer::share_object<XturbosManager>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTURBOS>>(v2);
        let v4 = InitEvent{
            xturbos_manager : 0x2::object::id<XturbosManager>(&v3),
            metadata        : 0x2::object::id<0x2::coin::CoinMetadata<XTURBOS>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    public fun lock_amount(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &VeNftInfo) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        arg1.lock_amount
    }

    public(friend) fun mint(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &mut VeNFT, arg3: u64) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::balance::join<XTURBOS>(&mut arg2.xturbos_balance, 0x2::coin::mint_balance<XTURBOS>(&mut arg1.treasury, arg3));
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, 0x2::object::id<VeNFT>(arg2));
        v0.xturbos_amount = v0.xturbos_amount + arg3;
        let v1 = MintEvent{
            nft_id : 0x2::object::id<VeNFT>(arg2),
            amount : arg3,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun mint_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &mut 0x2::tx_context::TxContext) : VeNFT {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        arg1.index = arg1.index + 1;
        let v0 = arg1.index;
        let v1 = new_venft(v0, arg2);
        let v2 = 0x2::object::id<VeNFT>(&v1);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg1.has_venft, v3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::user_already_has_venft());
        let v4 = VeNftInfo{
            id             : v2,
            xturbos_amount : 0,
            lock_amount    : 0,
        };
        0x2::linked_table::push_back<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, v2, v4);
        0x2::table::add<address, bool>(&mut arg1.has_venft, v3, true);
        let v5 = MintVeNFTEvent{
            nft_id : v2,
            index  : v0,
        };
        0x2::event::emit<MintVeNFTEvent>(v5);
        v1
    }

    fun new_venft(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : VeNFT {
        VeNFT{
            id              : 0x2::object::new(arg1),
            index           : arg0,
            xturbos_balance : 0x2::balance::zero<XTURBOS>(),
        }
    }

    public fun nfts(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager) : &0x2::linked_table::LinkedTable<0x2::object::ID, VeNftInfo> {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        &arg1.nfts
    }

    public(friend) fun request_transfer_venft_by_admin(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: 0x2::object::ID, arg3: address) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        assert!(0x2::linked_table::contains<0x2::object::ID, VeNftInfo>(&arg1.nfts, arg2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::venft_not_found());
        assert!(!0x2::table::contains<address, bool>(&arg1.has_venft, arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::user_already_has_venft());
        let v0 = TransferVeNFTRequest{
            venft_id     : arg2,
            target_owner : arg3,
        };
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::transfer_request_exists());
        0x2::dynamic_field::add<0x2::object::ID, TransferVeNFTRequest>(&mut arg1.id, arg2, v0);
        let v1 = RequestTransferEvent{
            venft        : arg2,
            target_owner : arg3,
        };
        0x2::event::emit<RequestTransferEvent>(v1);
    }

    public fun total_amount(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::coin::total_supply<XTURBOS>(&arg1.treasury)
    }

    public fun total_holder(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::linked_table::length<0x2::object::ID, VeNftInfo>(&arg1.nfts)
    }

    public fun total_locked(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &XturbosManager) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        arg1.total_locked
    }

    public(friend) fun transfer_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: VeNFT, arg2: &0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::transfer::transfer<VeNFT>(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun update_locked(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &VeNFT, arg3: u64) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, 0x2::object::uid_to_inner(&arg2.id));
        arg1.total_locked = arg1.total_locked + arg3;
        v0.lock_amount = v0.lock_amount + arg3;
    }

    public(friend) fun update_unlocked(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut XturbosManager, arg2: &VeNFT, arg3: u64) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg1.nfts, 0x2::object::uid_to_inner(&arg2.id));
        arg1.total_locked = arg1.total_locked - arg3;
        v0.lock_amount = v0.lock_amount - arg3;
    }

    public fun xturbos_amount(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &VeNftInfo) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        arg1.xturbos_amount
    }

    // decompiled from Move bytecode v6
}


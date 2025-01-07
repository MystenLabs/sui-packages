module 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus {
    struct XCETUS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct XcetusManager has key {
        id: 0x2::object::UID,
        index: u64,
        has_venft: 0x2::table::Table<address, bool>,
        nfts: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, VeNftInfo>,
        treasury: 0x2::coin::TreasuryCap<XCETUS>,
        total_locked: u64,
    }

    struct VeNftInfo has drop, store {
        id: 0x2::object::ID,
        xcetus_amount: u64,
        lock_amount: u64,
    }

    struct VeNFT has key {
        id: 0x2::object::UID,
        index: u64,
        xcetus_balance: 0x2::balance::Balance<XCETUS>,
    }

    struct TransferVeNFTRequest has drop, store {
        venft_id: 0x2::object::ID,
        target_owner: address,
    }

    struct InitEvent has copy, drop, store {
        xcetus_manager: 0x2::object::ID,
        metadata: 0x2::object::ID,
        admin_id: 0x2::object::ID,
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

    struct TransferEvent has copy, drop, store {
        from_venft: 0x2::object::ID,
        to_venft: 0x2::object::ID,
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

    public fun value(arg0: &XcetusManager, arg1: &VeNFT) : u64 {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg0.nfts, 0x2::object::uid_to_inner(&arg1.id));
        assert!(v0.xcetus_amount == 0x2::balance::value<XCETUS>(&arg1.xcetus_balance), 3);
        v0.xcetus_amount
    }

    public(friend) fun burn(arg0: &mut XcetusManager, arg1: &mut VeNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<XCETUS>(&mut arg0.treasury, 0x2::coin::from_balance<XCETUS>(0x2::balance::split<XCETUS>(&mut arg1.xcetus_balance, arg2), arg3));
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, 0x2::object::id<VeNFT>(arg1));
        v0.xcetus_amount = v0.xcetus_amount - arg2;
        let v1 = BurnEvent{
            nft_id : 0x2::object::id<VeNFT>(arg1),
            amount : arg2,
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public(friend) fun approve_transfer_venft(arg0: &mut XcetusManager, arg1: VeNFT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<VeNFT>(&arg1);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg0.nfts, v0).lock_amount == 0, 6);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::remove<0x2::object::ID, TransferVeNFTRequest>(&mut arg0.id, v0);
        assert!(v0 == v1.venft_id, 10);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::table::remove<address, bool>(&mut arg0.has_venft, v2);
        assert!(v1.target_owner == arg2, 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_venft, v1.target_owner), 5);
        0x2::table::add<address, bool>(&mut arg0.has_venft, v1.target_owner, true);
        0x2::transfer::transfer<VeNFT>(arg1, v1.target_owner);
        let v3 = ApproveTransferEvent{
            venft        : v0,
            source_owner : v2,
            target_owner : arg2,
        };
        0x2::event::emit<ApproveTransferEvent>(v3);
    }

    public fun available_value(arg0: &XcetusManager, arg1: &VeNFT) : u64 {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg0.nfts, 0x2::object::uid_to_inner(&arg1.id));
        assert!(v0.xcetus_amount == 0x2::balance::value<XCETUS>(&arg1.xcetus_balance), 3);
        v0.xcetus_amount - v0.lock_amount
    }

    public entry fun burn_by_admin(arg0: &AdminCap, arg1: &mut XcetusManager, arg2: &mut VeNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(available_value(arg1, arg2) >= arg3, 4);
        burn(arg1, arg2, arg3, arg4);
    }

    public fun burn_venft(arg0: &mut XcetusManager, arg1: VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<XCETUS>(&arg1.xcetus_balance) == 0, 1);
        let VeNFT {
            id             : v0,
            index          : _,
            xcetus_balance : v2,
        } = arg1;
        let v3 = v0;
        let v4 = 0x2::object::uid_to_inner(&v3);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, VeNftInfo>(&arg0.nfts, v4).xcetus_amount == 0, 2);
        0x2::object::delete(v3);
        0x2::balance::destroy_zero<XCETUS>(v2);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, v4);
        0x2::table::remove<address, bool>(&mut arg0.has_venft, 0x2::tx_context::sender(arg2));
        let v5 = BurnVeNFTEvent{nft_id: v4};
        0x2::event::emit<BurnVeNFTEvent>(v5);
    }

    public(friend) fun cancel_transfer_venft_request_by_admin(arg0: &AdminCap, arg1: &mut XcetusManager, arg2: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg2), 9);
        0x2::dynamic_field::remove<0x2::object::ID, TransferVeNFTRequest>(&mut arg1.id, arg2);
        let v0 = CancelTransferRequestEvent{venft: arg2};
        0x2::event::emit<CancelTransferRequestEvent>(v0);
    }

    fun init(arg0: XCETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCETUS>(arg0, 9, b"xCETUS", b"Cetus Escrowed Token", b"xCETUS is a non-transferable escrowed governance token, corresponding to staked CETUS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7rgiihm5sisgewirofazpjddkpvmlwphumcg5lulriu6okgf5krq.arweave.net/_EyEHZ2SJGJZEXFBl6RjU-rF2eejBG6ui4op5yjF6qM")), arg1);
        let v2 = v1;
        let v3 = XcetusManager{
            id           : 0x2::object::new(arg1),
            index        : 0,
            has_venft    : 0x2::table::new<address, bool>(arg1),
            nfts         : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, VeNftInfo>(arg1),
            treasury     : v0,
            total_locked : 0,
        };
        0x2::transfer::share_object<XcetusManager>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCETUS>>(v2);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = InitEvent{
            xcetus_manager : 0x2::object::id<XcetusManager>(&v3),
            metadata       : 0x2::object::id<0x2::coin::CoinMetadata<XCETUS>>(&v2),
            admin_id       : 0x2::object::id<AdminCap>(&v4),
        };
        0x2::event::emit<InitEvent>(v5);
    }

    public fun lock_amount(arg0: &VeNftInfo) : u64 {
        arg0.lock_amount
    }

    public(friend) fun mint(arg0: &mut XcetusManager, arg1: &mut VeNFT, arg2: u64) {
        0x2::balance::join<XCETUS>(&mut arg1.xcetus_balance, 0x2::coin::mint_balance<XCETUS>(&mut arg0.treasury, arg2));
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, 0x2::object::id<VeNFT>(arg1));
        v0.xcetus_amount = v0.xcetus_amount + arg2;
        let v1 = MintEvent{
            nft_id : 0x2::object::id<VeNFT>(arg1),
            amount : arg2,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun mint_venft(arg0: &mut XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        arg0.index = arg0.index + 1;
        let v0 = arg0.index;
        let v1 = new_venft(v0, arg1);
        let v2 = 0x2::object::id<VeNFT>(&v1);
        let v3 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_venft, v3), 5);
        0x2::transfer::transfer<VeNFT>(v1, 0x2::tx_context::sender(arg1));
        let v4 = VeNftInfo{
            id            : v2,
            xcetus_amount : 0,
            lock_amount   : 0,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, v2, v4);
        0x2::table::add<address, bool>(&mut arg0.has_venft, v3, true);
        let v5 = MintVeNFTEvent{
            nft_id : v2,
            index  : v0,
        };
        0x2::event::emit<MintVeNFTEvent>(v5);
        v2
    }

    public(friend) fun mint_venft_object(arg0: &mut XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : VeNFT {
        arg0.index = arg0.index + 1;
        let v0 = arg0.index;
        let v1 = new_venft(v0, arg1);
        let v2 = 0x2::object::id<VeNFT>(&v1);
        let v3 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_venft, v3), 5);
        let v4 = VeNftInfo{
            id            : v2,
            xcetus_amount : 0,
            lock_amount   : 0,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, v2, v4);
        0x2::table::add<address, bool>(&mut arg0.has_venft, v3, true);
        let v5 = MintVeNFTEvent{
            nft_id : v2,
            index  : v0,
        };
        0x2::event::emit<MintVeNFTEvent>(v5);
        v1
    }

    fun new_venft(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : VeNFT {
        VeNFT{
            id             : 0x2::object::new(arg1),
            index          : arg0,
            xcetus_balance : 0x2::balance::zero<XCETUS>(),
        }
    }

    public fun nfts(arg0: &XcetusManager) : &0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, VeNftInfo> {
        &arg0.nfts
    }

    public(friend) fun request_transfer_venft_by_admin(arg0: &AdminCap, arg1: &mut XcetusManager, arg2: 0x2::object::ID, arg3: address) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, VeNftInfo>(&arg1.nfts, arg2), 7);
        assert!(!0x2::table::contains<address, bool>(&arg1.has_venft, arg3), 5);
        let v0 = TransferVeNFTRequest{
            venft_id     : arg2,
            target_owner : arg3,
        };
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg2), 8);
        0x2::dynamic_field::add<0x2::object::ID, TransferVeNFTRequest>(&mut arg1.id, arg2, v0);
        let v1 = RequestTransferEvent{
            venft        : arg2,
            target_owner : arg3,
        };
        0x2::event::emit<RequestTransferEvent>(v1);
    }

    public fun total_holder(arg0: &XcetusManager) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, VeNftInfo>(&arg0.nfts)
    }

    public fun total_locked(arg0: &XcetusManager) : u64 {
        arg0.total_locked
    }

    public fun totol_amount(arg0: &XcetusManager) : u64 {
        0x2::coin::total_supply<XCETUS>(&arg0.treasury)
    }

    public(friend) fun transfer_venft(arg0: VeNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VeNFT>(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun update_locked(arg0: &mut XcetusManager, arg1: &VeNFT, arg2: u64) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, 0x2::object::uid_to_inner(&arg1.id));
        arg0.total_locked = arg0.total_locked + arg2;
        v0.lock_amount = v0.lock_amount + arg2;
    }

    public(friend) fun update_unlocked(arg0: &mut XcetusManager, arg1: &VeNFT, arg2: u64) {
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, VeNftInfo>(&mut arg0.nfts, 0x2::object::uid_to_inner(&arg1.id));
        arg0.total_locked = arg0.total_locked - arg2;
        v0.lock_amount = v0.lock_amount - arg2;
    }

    public fun xcetus_amount(arg0: &VeNftInfo) : u64 {
        arg0.xcetus_amount
    }

    // decompiled from Move bytecode v6
}


module 0x7366b8fdf827bcb1273cc74cebe7a951f3b4d4fc0d6cfa9443d965640e38de92::dulicoin {
    struct DULICOIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryStore has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DULICOIN>,
        total_minted: u64,
        total_burned: u64,
        max_supply: u64,
        minting_paused: bool,
        admin: address,
        pending_admin: address,
    }

    struct TokensMinted has copy, drop {
        recipient: address,
        amount: u64,
        total_minted: u64,
        current_supply: u64,
        minter: address,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        total_burned: u64,
        current_supply: u64,
        burner: address,
    }

    struct MintingPaused has copy, drop {
        paused_by: address,
    }

    struct MintingResumed has copy, drop {
        resumed_by: address,
    }

    struct AdminTransferInitiated has copy, drop {
        current_admin: address,
        pending_admin: address,
    }

    struct AdminTransferCompleted has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminTransferCancelled has copy, drop {
        cancelled_by: address,
        cancelled_pending: address,
    }

    struct DenyListUpdated has copy, drop {
        action: 0x1::string::String,
        addr: address,
        updated_by: address,
    }

    public fun burn(arg0: &mut TreasuryStore, arg1: 0x2::coin::Coin<DULICOIN>, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::coin::value<DULICOIN>(&arg1) > 0, 3);
        let v0 = 0x2::coin::burn<DULICOIN>(&mut arg0.cap, arg1);
        arg0.total_burned = arg0.total_burned + v0;
        let v1 = TokensBurned{
            amount         : v0,
            total_burned   : arg0.total_burned,
            current_supply : arg0.total_minted - arg0.total_burned,
            burner         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TokensBurned>(v1);
        v0
    }

    public fun accept_admin(arg0: &mut TreasuryStore, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.pending_admin != @0x0, 5);
        assert!(v0 == arg0.pending_admin, 6);
        arg0.admin = v0;
        arg0.pending_admin = @0x0;
        let v1 = AdminTransferCompleted{
            old_admin : arg0.admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminTransferCompleted>(v1);
        arg1
    }

    public fun accept_admin_and_keep(arg0: &mut TreasuryStore, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = accept_admin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun admin(arg0: &TreasuryStore) : address {
        arg0.admin
    }

    public fun burn_tokens(arg0: &mut TreasuryStore, arg1: 0x2::coin::Coin<DULICOIN>, arg2: &0x2::tx_context::TxContext) {
        burn(arg0, arg1, arg2);
    }

    public fun cancel_admin_transfer(arg0: &mut TreasuryStore, arg1: &AdminCap) {
        let v0 = arg0.pending_admin;
        assert!(v0 != @0x0, 5);
        arg0.pending_admin = @0x0;
        let v1 = AdminTransferCancelled{
            cancelled_by      : arg0.admin,
            cancelled_pending : v0,
        };
        0x2::event::emit<AdminTransferCancelled>(v1);
    }

    public fun current_supply(arg0: &TreasuryStore) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public fun denylist_add(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DULICOIN>, arg2: &AdminCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DULICOIN>(arg0, arg1, arg3, arg4);
        let v0 = DenyListUpdated{
            action     : 0x1::string::utf8(b"added"),
            addr       : arg3,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DenyListUpdated>(v0);
    }

    public fun denylist_remove(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DULICOIN>, arg2: &AdminCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DULICOIN>(arg0, arg1, arg3, arg4);
        let v0 = DenyListUpdated{
            action     : 0x1::string::utf8(b"removed"),
            addr       : arg3,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DenyListUpdated>(v0);
    }

    public fun has_pending_admin_transfer(arg0: &TreasuryStore) : bool {
        arg0.pending_admin != @0x0
    }

    fun init(arg0: DULICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DULICOIN>(arg0, 6, 0x1::string::utf8(b"DLC"), 0x1::string::utf8(b"Dulicoin"), 0x1::string::utf8(b"Dulicoin - Token seguro para pagos"), 0x1::string::utf8(b"https://example.com/dulicoin.png"), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = TreasuryStore{
            id             : 0x2::object::new(arg1),
            cap            : v1,
            total_minted   : 0,
            total_burned   : 0,
            max_supply     : 1000000000000000,
            minting_paused : false,
            admin          : v3,
            pending_admin  : @0x0,
        };
        0x2::transfer::share_object<TreasuryStore>(v5);
        0x2::transfer::transfer<AdminCap>(v4, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DULICOIN>>(0x2::coin_registry::make_regulated<DULICOIN>(&mut v2, true, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DULICOIN>>(0x2::coin_registry::finalize<DULICOIN>(v2, arg1), v3);
    }

    public fun initiate_admin_transfer(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: address) {
        assert!(arg2 != @0x0, 4);
        arg0.pending_admin = arg2;
        let v0 = AdminTransferInitiated{
            current_admin : arg0.admin,
            pending_admin : arg2,
        };
        0x2::event::emit<AdminTransferInitiated>(v0);
    }

    public fun is_minting_paused(arg0: &TreasuryStore) : bool {
        arg0.minting_paused
    }

    public fun max_supply(arg0: &TreasuryStore) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.minting_paused, 2);
        assert!(arg3 > 0, 3);
        assert!(arg2 != @0x0, 4);
        assert!(arg0.total_minted - arg0.total_burned + arg3 <= arg0.max_supply, 1);
        0x2::coin::mint_and_transfer<DULICOIN>(&mut arg0.cap, arg3, arg2, arg4);
        arg0.total_minted = arg0.total_minted + arg3;
        let v0 = TokensMinted{
            recipient      : arg2,
            amount         : arg3,
            total_minted   : arg0.total_minted,
            current_supply : arg0.total_minted - arg0.total_burned,
            minter         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public fun mint_batch(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        let v1 = 0;
        while (v1 < v0) {
            mint(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg4);
            v1 = v1 + 1;
        };
    }

    public fun pause_minting(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        arg0.minting_paused = true;
        let v0 = MintingPaused{paused_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<MintingPaused>(v0);
    }

    public fun pending_admin(arg0: &TreasuryStore) : address {
        arg0.pending_admin
    }

    public fun remaining_mintable(arg0: &TreasuryStore) : u64 {
        let v0 = arg0.total_minted - arg0.total_burned;
        if (v0 >= arg0.max_supply) {
            0
        } else {
            arg0.max_supply - v0
        }
    }

    public fun resume_minting(arg0: &mut TreasuryStore, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        arg0.minting_paused = false;
        let v0 = MintingResumed{resumed_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<MintingResumed>(v0);
    }

    public fun total_burned(arg0: &TreasuryStore) : u64 {
        arg0.total_burned
    }

    public fun total_minted(arg0: &TreasuryStore) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}


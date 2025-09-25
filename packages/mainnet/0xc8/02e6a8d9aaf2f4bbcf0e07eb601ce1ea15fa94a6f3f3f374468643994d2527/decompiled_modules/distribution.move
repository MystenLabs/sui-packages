module 0xc802e6a8d9aaf2f4bbcf0e07eb601ce1ea15fa94a6f3f3f374468643994d2527::distribution {
    struct Distribution<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        items: 0x2::table_vec::TableVec<T0>,
        og_price: u64,
        whitelist_price: u64,
        public_price: u64,
        og_minted: u64,
        whitelist_minted: u64,
        total_minted: u64,
        phase: u8,
        admin: address,
    }

    struct DistributionCap has store, key {
        id: 0x2::object::UID,
    }

    struct OGCap has store, key {
        id: 0x2::object::UID,
        max_mint: u64,
        current_mint: u64,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
        max_mint: u64,
        current_mint: u64,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        creator: address,
    }

    public fun new<T0: store + key>(arg0: address, arg1: &DistributionCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Distribution<T0>{
            id               : 0x2::object::new(arg2),
            items            : 0x2::table_vec::empty<T0>(arg2),
            og_price         : 3000000000,
            whitelist_price  : 6000000000,
            public_price     : 8000000000,
            og_minted        : 0,
            whitelist_minted : 0,
            total_minted     : 0,
            phase            : 0,
            admin            : arg0,
        };
        0x2::transfer::share_object<Distribution<T0>>(v0);
    }

    public(friend) fun add_nft<T0: store + key>(arg0: &mut Distribution<T0>, arg1: T0) {
        0x2::table_vec::push_back<T0>(&mut arg0.items, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DistributionCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun items_length<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        0x2::table_vec::length<T0>(&arg0.items)
    }

    entry fun mint<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 3, 13906834676854554623);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.public_price * arg3, 13906834681149521919);
        mint_internal<T0>(arg0, arg2, arg1, arg3, arg4, arg5);
        arg0.total_minted = arg0.total_minted + arg3;
    }

    fun mint_internal<T0: store + key>(arg0: &mut Distribution<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg4, arg5);
        assert!(0x2::table_vec::length<T0>(&arg0.items) >= arg3, 13906835230905335807);
        let (v1, v2) = 0x2::kiosk::new(arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0;
        while (v5 < arg3) {
            let v6 = 0x2::table_vec::swap_remove<T0>(&mut arg0.items, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x2::table_vec::length<T0>(&arg0.items) - 1));
            let v7 = NFTMinted{
                id      : 0x2::object::id<T0>(&v6),
                creator : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<NFTMinted>(v7);
            0x2::kiosk::lock<T0>(&mut v4, &v3, arg2, v6);
            v5 = v5 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    public fun new_og_cap(arg0: &DistributionCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OGCap{
            id           : 0x2::object::new(arg3),
            max_mint     : arg1,
            current_mint : 0,
        };
        0x2::transfer::public_transfer<OGCap>(v0, arg2);
    }

    public fun new_whitelist_cap(arg0: &DistributionCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistCap{
            id           : 0x2::object::new(arg3),
            max_mint     : arg1,
            current_mint : 0,
        };
        0x2::transfer::public_transfer<WhitelistCap>(v0, arg2);
    }

    public fun og_cost<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.og_price
    }

    public fun og_current_mint(arg0: &OGCap) : u64 {
        arg0.current_mint
    }

    entry fun og_mint<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut OGCap, arg4: u64, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1, 13906834749868998655);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.og_price * arg4, 13906834754163965951);
        assert!(arg3.current_mint + arg4 <= arg3.max_mint, 13906834758458933247);
        mint_internal<T0>(arg0, arg2, arg1, arg4, arg5, arg6);
        arg0.og_minted = arg0.og_minted + arg4;
        arg0.total_minted = arg0.total_minted + arg4;
        arg3.current_mint = arg3.current_mint + arg4;
    }

    public fun og_minted<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.og_minted
    }

    public fun public_cost<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.public_price
    }

    public fun total_minted<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.total_minted
    }

    public fun update_og_price<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &DistributionCap, arg2: u64) {
        arg0.og_price = arg2;
    }

    public fun update_phase<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &DistributionCap, arg2: u8) {
        arg0.phase = arg2;
    }

    public fun update_public_price<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &DistributionCap, arg2: u64) {
        arg0.public_price = arg2;
    }

    public fun update_whitelist_price<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &DistributionCap, arg2: u64) {
        arg0.whitelist_price = arg2;
    }

    public fun whitelist_cost<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.whitelist_price
    }

    public fun whitelist_current_mint(arg0: &WhitelistCap) : u64 {
        arg0.current_mint
    }

    entry fun whitelist_mint<T0: store + key>(arg0: &mut Distribution<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut WhitelistCap, arg4: u64, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.current_mint + arg4 <= arg3.max_mint, 13906834835768344575);
        assert!(arg0.phase == 2, 13906834840063311871);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.whitelist_price * arg4, 13906834844358279167);
        mint_internal<T0>(arg0, arg2, arg1, arg4, arg5, arg6);
        arg0.whitelist_minted = arg0.whitelist_minted + arg4;
        arg0.total_minted = arg0.total_minted + arg4;
        arg3.current_mint = arg3.current_mint + arg4;
    }

    public fun whitelist_minted<T0: store + key>(arg0: &Distribution<T0>) : u64 {
        arg0.whitelist_minted
    }

    // decompiled from Move bytecode v6
}


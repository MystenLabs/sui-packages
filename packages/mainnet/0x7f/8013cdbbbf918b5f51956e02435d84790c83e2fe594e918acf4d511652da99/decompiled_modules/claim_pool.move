module 0x7f8013cdbbbf918b5f51956e02435d84790c83e2fe594e918acf4d511652da99::claim_pool {
    struct ClaimPool has key {
        id: 0x2::object::UID,
        admin: address,
        nft_ids: vector<0x2::object::ID>,
        claims: 0x2::table::Table<address, bool>,
        authorized_depositors: 0x2::table::Table<address, bool>,
        claiming_enabled: bool,
        total_claimed: u64,
    }

    struct NFTClaimed has copy, drop {
        claimer: address,
        nft_id: 0x2::object::ID,
        pool_remaining: u64,
    }

    struct NFTAddedToPool has copy, drop {
        nft_id: 0x2::object::ID,
        pool_size: u64,
    }

    struct PoolStatusChanged has copy, drop {
        claiming_enabled: bool,
    }

    struct CLAIM_POOL has drop {
        dummy_field: bool,
    }

    public entry fun add_authorized_depositor(arg0: &mut ClaimPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::table::contains<address, bool>(&arg0.authorized_depositors, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.authorized_depositors, arg1, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.authorized_depositors, arg1) = true;
        };
    }

    public entry fun add_nft_to_pool<T0: store + key>(arg0: &mut ClaimPool, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || 0x2::table::contains<address, bool>(&arg0.authorized_depositors, v0) && *0x2::table::borrow<address, bool>(&arg0.authorized_depositors, v0), 1);
        let v1 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_ids, v1);
        let v2 = NFTAddedToPool{
            nft_id    : v1,
            pool_size : 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids),
        };
        0x2::event::emit<NFTAddedToPool>(v2);
    }

    public entry fun batch_add_authorized_depositors(arg0: &mut ClaimPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.authorized_depositors, v1)) {
                0x2::table::add<address, bool>(&mut arg0.authorized_depositors, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun can_claim(arg0: &ClaimPool, arg1: address) : bool {
        if (arg0.claiming_enabled) {
            if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids)) {
                !0x2::table::contains<address, bool>(&arg0.claims, arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut ClaimPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claiming_enabled, 4);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids), 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.claims, v0), 3);
        let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids);
        0x2::table::add<address, bool>(&mut arg0.claims, v0, true);
        arg0.total_claimed = arg0.total_claimed + 1;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v1), v0);
        let v2 = NFTClaimed{
            claimer        : v0,
            nft_id         : v1,
            pool_remaining : 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids),
        };
        0x2::event::emit<NFTClaimed>(v2);
    }

    public fun get_pool_info(arg0: &ClaimPool) : (u64, u64, bool, address) {
        (0x1::vector::length<0x2::object::ID>(&arg0.nft_ids), arg0.total_claimed, arg0.claiming_enabled, arg0.admin)
    }

    public fun has_claimed(arg0: &ClaimPool, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claims, arg1)
    }

    fun init(arg0: CLAIM_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimPool{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            nft_ids               : 0x1::vector::empty<0x2::object::ID>(),
            claims                : 0x2::table::new<address, bool>(arg1),
            authorized_depositors : 0x2::table::new<address, bool>(arg1),
            claiming_enabled      : false,
            total_claimed         : 0,
        };
        0x2::transfer::share_object<ClaimPool>(v0);
    }

    public fun is_authorized_depositor(arg0: &ClaimPool, arg1: address) : bool {
        arg1 == arg0.admin || 0x2::table::contains<address, bool>(&arg0.authorized_depositors, arg1) && *0x2::table::borrow<address, bool>(&arg0.authorized_depositors, arg1)
    }

    public entry fun remove_all_nfts_from_pool<T0: store + key>(arg0: &mut ClaimPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids)) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids)), arg1);
        };
    }

    public entry fun remove_authorized_depositor(arg0: &mut ClaimPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::table::contains<address, bool>(&arg0.authorized_depositors, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.authorized_depositors, arg1);
        };
    }

    public entry fun remove_nfts_from_pool<T0: store + key>(arg0: &mut ClaimPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = arg1;
        if (arg1 > 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            v0 = 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids);
        };
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids)), arg2);
            v1 = v1 + 1;
        };
    }

    public entry fun set_claiming_enabled(arg0: &mut ClaimPool, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.claiming_enabled = arg1;
        let v0 = PoolStatusChanged{claiming_enabled: arg1};
        0x2::event::emit<PoolStatusChanged>(v0);
    }

    public entry fun transfer_admin(arg0: &mut ClaimPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}


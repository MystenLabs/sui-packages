module 0xf5ed5d657e7d10cff827da0b8f971b71e77dfa124cea20e796cb9e626caf717a::marketplace {
    struct ItemKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct ListKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct ProtocolFeeKey has copy, drop, store {
        nft_type: 0x1::type_name::TypeName,
    }

    struct RoyaltyKey has copy, drop, store {
        nft_type: 0x1::type_name::TypeName,
    }

    struct WalletKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Default has drop {
        dummy_field: bool,
    }

    struct Marketplace has store, key {
        id: 0x2::object::UID,
        version: u64,
        index: u256,
        wallet: 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet,
        access: 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::Access,
    }

    struct Rate has copy, drop, store {
        max_amount: u64,
        bp_amount: u64,
        min_amount: u64,
    }

    struct Ask has drop, store {
        index: u256,
        maker: address,
        coin: 0x1::type_name::TypeName,
        ask: u64,
    }

    struct CreateMarketplaceEvent has copy, drop {
        marketplace: 0x2::object::ID,
        version: u64,
    }

    struct SetProtocolFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        max_amount: u64,
        bp_amount: u64,
        min_amount: u64,
    }

    struct SetRoyaltyFeeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        max_amount: u64,
        bp_amount: u64,
        min_amount: u64,
    }

    struct WithdrawRoyaltyEvent has copy, drop {
        marketplace: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        to_account: address,
        amount: u64,
    }

    struct GrantRolesEvent has copy, drop {
        marketplace: 0x2::object::ID,
        account: address,
        roles: vector<0x2::object::ID>,
    }

    struct RevokeRolesEvent has copy, drop {
        marketplace: 0x2::object::ID,
        account: address,
        roles: vector<0x2::object::ID>,
    }

    struct WithdrawEvent has copy, drop {
        marketplace: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        to_account: address,
        amount: u64,
    }

    struct ListEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
        ask: u64,
    }

    struct DelistEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
    }

    struct BuyEvent has copy, drop {
        marketplace: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
        ask: u64,
        protocol_fee: u64,
        royalty_fee: u64,
    }

    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &Marketplace) : u64 {
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::balance<T0>(&arg0.wallet)
    }

    public entry fun withdraw<T0>(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"withdraw_protocol_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg3), v0);
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::withdraw<T0>(&mut arg0.wallet, arg1, arg2, arg3);
        let v2 = WithdrawEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            coin_type   : 0x1::type_name::get<T0>(),
            to_account  : arg1,
            amount      : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    public fun assert_version(arg0: &Marketplace) {
        assert!(arg0.version == 1, 10001);
    }

    public fun balance_of_royalty<T0, T1>(arg0: &Marketplace) : u64 {
        let v0 = WalletKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<WalletKey<T0>>(&arg0.id, v0)) {
            let v2 = WalletKey<T0>{dummy_field: false};
            0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::balance<T1>(0x2::dynamic_field::borrow<WalletKey<T0>, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&arg0.id, v2))
        } else {
            0
        }
    }

    public entry fun buy_and_take<T0: store + key, T1>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = ListKey{id: arg1};
        let Ask {
            index : v1,
            maker : v2,
            coin  : v3,
            ask   : v4,
        } = 0x2::dynamic_field::remove<ListKey, Ask>(&mut arg0.id, v0);
        assert!(v2 != 0x2::tx_context::sender(arg3), 10004);
        assert!(v3 == 0x1::type_name::get<T1>(), 10005);
        assert!(0x2::coin::value<T1>(&arg2) == v4, 10006);
        let v5 = calculate_protocol_fee<T0, T1>(arg0, v4);
        if (v5 > 0) {
            0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::deposit<T1>(&mut arg0.wallet, 0x2::coin::split<T1>(&mut arg2, v5, arg3), arg3);
        };
        let v6 = calculate_royalty_fee<T0, T1>(arg0, v4);
        if (v6 > 0) {
            let v7 = 0x2::coin::split<T1>(&mut arg2, v6, arg3);
            deposit_royalty<T0, T1>(arg0, v7, arg3);
        };
        let v8 = ItemKey{id: arg1};
        let v9 = BuyEvent{
            marketplace  : 0x2::object::id<Marketplace>(arg0),
            listing_id   : 0x2::object::id_from_address(0x2::address::from_u256(v1)),
            coin_type    : 0x1::type_name::get<T1>(),
            target_type  : 0x1::type_name::get<T0>(),
            item_id      : arg1,
            ask          : v4,
            protocol_fee : v5,
            royalty_fee  : v6,
        };
        0x2::event::emit<BuyEvent>(v9);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<ItemKey, T0>(&mut arg0.id, v8), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
    }

    public fun calculate_protocol_fee<T0, T1>(arg0: &Marketplace, arg1: u64) : u64 {
        let (_, v1, v2, v3) = get_protocol_fee<T0, T1>(arg0);
        let v4 = arg1 * v2 / 10000;
        let v5 = v4;
        if (v1 > 0 && v4 > v1) {
            v5 = v1;
        } else if (v4 < v3) {
            v5 = v3;
        };
        v5
    }

    public fun calculate_royalty_fee<T0, T1>(arg0: &Marketplace, arg1: u64) : u64 {
        let (_, v1, v2, v3) = get_royalty<T0, T1>(arg0);
        let v4 = arg1 * v2 / 10000;
        let v5 = v4;
        if (v1 > 0 && v4 > v1) {
            v5 = v1;
        } else if (v4 < v3) {
            v5 = v3;
        };
        v5
    }

    public fun contains_protocol_fee<T0, T1>(arg0: &Marketplace) : bool {
        let v0 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v0)) {
            let v2 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
            let v3 = 0x1::type_name::get<T1>();
            0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(0x2::dynamic_field::borrow<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v2), &v3)
        } else {
            false
        }
    }

    public fun contains_royalty_fee<T0, T1>(arg0: &Marketplace) : bool {
        let v0 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<RoyaltyKey>(&arg0.id, v0)) {
            let v2 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
            let v3 = 0x1::type_name::get<T1>();
            0x2::vec_map::contains<0x1::type_name::TypeName, u16>(0x2::dynamic_field::borrow<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u16>>(&arg0.id, v2), &v3)
        } else {
            false
        }
    }

    public entry fun create_marketplace(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Marketplace>(arg0), 10003);
        let v0 = Marketplace{
            id      : 0x2::object::new(arg1),
            version : 1,
            index   : 0,
            wallet  : 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::init_wallet(arg1),
            access  : 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::init_access(arg1),
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::grant_roles_for_sender(&mut v0.access, 0x2::tx_context::sender(arg1), v1, arg1);
        let v2 = CreateMarketplaceEvent{
            marketplace : 0x2::object::id<Marketplace>(&v0),
            version     : v0.version,
        };
        0x2::event::emit<CreateMarketplaceEvent>(v2);
        0x2::transfer::public_share_object<Marketplace>(v0);
    }

    public entry fun delist_and_take<T0: store + key, T1>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = ListKey{id: arg1};
        let Ask {
            index : v1,
            maker : v2,
            coin  : _,
            ask   : _,
        } = 0x2::dynamic_field::remove<ListKey, Ask>(&mut arg0.id, v0);
        assert!(v2 == 0x2::tx_context::sender(arg2), 10003);
        let v5 = ItemKey{id: arg1};
        let v6 = 0x2::dynamic_field::remove<ItemKey, T0>(&mut arg0.id, v5);
        let v7 = DelistEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            listing_id  : 0x2::object::id_from_address(0x2::address::from_u256(v1)),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
            item_id     : 0x2::object::id<T0>(&v6),
        };
        0x2::event::emit<DelistEvent>(v7);
        0x2::transfer::public_transfer<T0>(v6, 0x2::tx_context::sender(arg2));
    }

    fun deposit_royalty<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WalletKey<T0>>(&arg0.id, v0)) {
            let v1 = WalletKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<WalletKey<T0>, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&mut arg0.id, v1, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::init_wallet(arg2));
        };
        let v2 = WalletKey<T0>{dummy_field: false};
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::deposit<T1>(0x2::dynamic_field::borrow_mut<WalletKey<T0>, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&mut arg0.id, v2), arg1, arg2);
    }

    public fun get_index(arg0: &Marketplace) : u256 {
        arg0.index
    }

    public fun get_protocol_fee<T0, T1>(arg0: &Marketplace) : (u8, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v4)) {
            let v5 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
            let v6 = 0x2::dynamic_field::borrow<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v5);
            let v7 = 0x1::type_name::get<T1>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v6, &v7)) {
                let v8 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v6, &v7);
                v1 = v8.max_amount;
                v2 = v8.bp_amount;
                v3 = v8.min_amount;
                v0 = 4;
            } else {
                let v9 = 0x1::type_name::get<Default>();
                if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v6, &v9)) {
                    let v10 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v6, &v9);
                    v1 = v10.max_amount;
                    v2 = v10.bp_amount;
                    v3 = v10.min_amount;
                    v0 = 3;
                };
            };
        } else {
            let v11 = ProtocolFeeKey{nft_type: 0x1::type_name::get<Default>()};
            if (0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v11)) {
                let v12 = ProtocolFeeKey{nft_type: 0x1::type_name::get<Default>()};
                let v13 = 0x2::dynamic_field::borrow<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v12);
                let v14 = 0x1::type_name::get<T1>();
                if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v13, &v14)) {
                    let v15 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v13, &v14);
                    v1 = v15.max_amount;
                    v2 = v15.bp_amount;
                    v3 = v15.min_amount;
                    v0 = 2;
                } else {
                    let v16 = 0x1::type_name::get<Default>();
                    if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v13, &v16)) {
                        let v17 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v13, &v16);
                        v1 = v17.max_amount;
                        v2 = v17.bp_amount;
                        v3 = v17.min_amount;
                        v0 = 1;
                    };
                };
            };
        };
        (v0, v1, v2, v3)
    }

    public fun get_protocol_fee_info<T0>(arg0: &Marketplace) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate> {
        let v0 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v0)) {
            let v2 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
            *0x2::dynamic_field::borrow<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v2)
        } else {
            0x2::vec_map::empty<0x1::type_name::TypeName, Rate>()
        }
    }

    public fun get_royalty<T0, T1>(arg0: &Marketplace) : (u8, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<RoyaltyKey>(&arg0.id, v4)) {
            let v5 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
            let v6 = 0x2::dynamic_field::borrow<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v5);
            let v7 = 0x1::type_name::get<T1>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v6, &v7)) {
                let v8 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v6, &v7);
                v1 = v8.max_amount;
                v2 = v8.bp_amount;
                v3 = v8.min_amount;
                v0 = 4;
            } else {
                let v9 = 0x1::type_name::get<Default>();
                if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v6, &v9)) {
                    let v10 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v6, &v9);
                    v1 = v10.max_amount;
                    v2 = v10.bp_amount;
                    v3 = v10.min_amount;
                    v0 = 3;
                };
            };
        } else {
            let v11 = RoyaltyKey{nft_type: 0x1::type_name::get<Default>()};
            if (0x2::dynamic_field::exists_<RoyaltyKey>(&arg0.id, v11)) {
                let v12 = RoyaltyKey{nft_type: 0x1::type_name::get<Default>()};
                let v13 = 0x2::dynamic_field::borrow<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v12);
                let v14 = 0x1::type_name::get<T1>();
                if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v13, &v14)) {
                    let v15 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v13, &v14);
                    v1 = v15.max_amount;
                    v2 = v15.bp_amount;
                    v3 = v15.min_amount;
                    v0 = 2;
                } else {
                    let v16 = 0x1::type_name::get<Default>();
                    if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v13, &v16)) {
                        let v17 = 0x2::vec_map::get<0x1::type_name::TypeName, Rate>(v13, &v16);
                        v1 = v17.max_amount;
                        v2 = v17.bp_amount;
                        v3 = v17.min_amount;
                        v0 = 1;
                    };
                };
            };
        };
        (v0, v1, v2, v3)
    }

    public fun get_royalty_info<T0>(arg0: &Marketplace) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate> {
        let v0 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
        if (0x2::dynamic_field::exists_<RoyaltyKey>(&arg0.id, v0)) {
            let v2 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
            *0x2::dynamic_field::borrow<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&arg0.id, v2)
        } else {
            0x2::vec_map::empty<0x1::type_name::TypeName, Rate>()
        }
    }

    public fun get_version(arg0: &Marketplace) : u64 {
        arg0.version
    }

    public entry fun grant_roles(arg0: &mut Marketplace, arg1: address, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"grant_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg3), v0);
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::grant_roles_for_sender(&mut arg0.access, arg1, arg2, arg3);
        let v2 = GrantRolesEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            account     : arg1,
            roles       : arg2,
        };
        0x2::event::emit<GrantRolesEvent>(v2);
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = ItemKey{id: v0};
        0x2::dynamic_field::add<ItemKey, T0>(&mut arg0.id, v1, arg1);
        arg0.index = arg0.index + 1;
        let v2 = ListKey{id: v0};
        let v3 = Ask{
            index : arg0.index,
            maker : 0x2::tx_context::sender(arg3),
            coin  : 0x1::type_name::get<T1>(),
            ask   : arg2,
        };
        0x2::dynamic_field::add<ListKey, Ask>(&mut arg0.id, v2, v3);
        let v4 = ListEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            listing_id  : 0x2::object::id_from_address(0x2::address::from_u256(arg0.index)),
            coin_type   : 0x1::type_name::get<T1>(),
            target_type : 0x1::type_name::get<T0>(),
            item_id     : v0,
            ask         : arg2,
        };
        0x2::event::emit<ListEvent>(v4);
    }

    public entry fun migrate(arg0: &mut 0x2::package::Publisher, arg1: &mut Marketplace) {
        assert!(0x2::package::from_package<Marketplace>(arg0), 10003);
        assert!(arg1.version < 1, 10002);
        arg1.version = 1;
    }

    public entry fun revoke_roles(arg0: &mut Marketplace, arg1: address, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"revoke_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg3), v0);
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::revoke_roles_for_sender(&mut arg0.access, arg1, arg2);
        let v2 = RevokeRolesEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            account     : arg1,
            roles       : arg2,
        };
        0x2::event::emit<RevokeRolesEvent>(v2);
    }

    public entry fun set_protocol_fee<T0, T1>(arg0: &mut Marketplace, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"set_protocol_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg4), v0);
        let v2 = ProtocolFeeKey{nft_type: 0x1::type_name::get<T0>()};
        if (!0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v2)) {
            0x2::dynamic_field::add<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&mut arg0.id, v2, 0x2::vec_map::empty<0x1::type_name::TypeName, Rate>());
        };
        let v3 = 0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&mut arg0.id, v2);
        let v4 = 0x1::type_name::get<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v3, &v4)) {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Rate>(v3, &v4);
            v5.max_amount = arg1;
            v5.bp_amount = arg2;
            v5.min_amount = arg3;
        } else {
            let v6 = Rate{
                max_amount : arg1,
                bp_amount  : arg2,
                min_amount : arg3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Rate>(v3, v4, v6);
        };
        let v7 = SetProtocolFeeEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            nft_type    : 0x1::type_name::get<T0>(),
            coin_type   : 0x1::type_name::get<T1>(),
            max_amount  : arg1,
            bp_amount   : arg2,
            min_amount  : arg3,
        };
        0x2::event::emit<SetProtocolFeeEvent>(v7);
    }

    public entry fun set_royalty<T0, T1>(arg0: &mut Marketplace, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"set_royalty_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg4), v0);
        let v2 = RoyaltyKey{nft_type: 0x1::type_name::get<T0>()};
        if (!0x2::dynamic_field::exists_<RoyaltyKey>(&arg0.id, v2)) {
            0x2::dynamic_field::add<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&mut arg0.id, v2, 0x2::vec_map::empty<0x1::type_name::TypeName, Rate>());
        };
        let v3 = 0x2::dynamic_field::borrow_mut<RoyaltyKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Rate>>(&mut arg0.id, v2);
        let v4 = 0x1::type_name::get<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Rate>(v3, &v4)) {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Rate>(v3, &v4);
            v5.max_amount = arg1;
            v5.bp_amount = arg2;
            v5.min_amount = arg3;
        } else {
            let v6 = Rate{
                max_amount : arg1,
                bp_amount  : arg2,
                min_amount : arg3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Rate>(v3, v4, v6);
        };
        let v7 = SetRoyaltyFeeEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            nft_type    : 0x1::type_name::get<T0>(),
            coin_type   : 0x1::type_name::get<T1>(),
            max_amount  : arg1,
            bp_amount   : arg2,
            min_amount  : arg3,
        };
        0x2::event::emit<SetRoyaltyFeeEvent>(v7);
    }

    public fun version() : u64 {
        1
    }

    public entry fun withdraw_royalty<T0, T1>(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"withdraw_royalty_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg3), v0);
        let v2 = WalletKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<WalletKey<T0>>(&arg0.id, v2), 10007);
        let v3 = WalletKey<T0>{dummy_field: false};
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::withdraw<T1>(0x2::dynamic_field::borrow_mut<WalletKey<T0>, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&mut arg0.id, v3), arg1, arg2, arg3);
        let v4 = WithdrawRoyaltyEvent{
            marketplace : 0x2::object::id<Marketplace>(arg0),
            coin_type   : 0x1::type_name::get<T1>(),
            to_account  : arg1,
            amount      : arg2,
        };
        0x2::event::emit<WithdrawRoyaltyEvent>(v4);
    }

    // decompiled from Move bytecode v6
}


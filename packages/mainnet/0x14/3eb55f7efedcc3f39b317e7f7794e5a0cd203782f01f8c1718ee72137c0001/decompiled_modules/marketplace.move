module 0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::marketplace {
    struct MarketplaceCreationEvent has copy, drop {
        marketplace_id: 0x2::object::ID,
    }

    struct CollectionWhitelistEvent has copy, drop {
        collection_address: 0x1::ascii::String,
    }

    struct RemoveWhitelistEvent has copy, drop {
        collection_address: 0x1::ascii::String,
    }

    struct CollectionDelistEvent has copy, drop {
        item_id: vector<0x2::object::ID>,
    }

    struct ListingEvent has copy, drop {
        item_id: vector<0x2::object::ID>,
        ask: vector<u64>,
    }

    struct MarketplaceInformationEvent has copy, drop {
        collection_whitelist_id: 0x2::object::ID,
        signer_id: 0x2::object::ID,
        nonce_id: 0x2::object::ID,
    }

    struct ListingBoughtEvent has copy, drop {
        item_id: vector<0x2::object::ID>,
        ask: vector<u64>,
    }

    struct TreasuryAccountSetEvent has copy, drop {
        new_treasury_account: address,
    }

    struct AdminSetEvent has copy, drop {
        admin_obj: 0x2::object::ID,
        new_admin: address,
    }

    struct NFTAdminChangedEvent has copy, drop {
        admin: address,
    }

    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    struct MarketInfo has store, key {
        id: 0x2::object::UID,
        treasury_account: address,
    }

    struct CollectionWhitelist has store, key {
        id: 0x2::object::UID,
        collection_address: vector<0x1::ascii::String>,
    }

    struct ListBuyMessage has copy, drop {
        item_id: vector<0x2::object::ID>,
        counter: u64,
    }

    struct MintBuyMessage has copy, drop {
        coin_value: u64,
        receiver: address,
        counter: u64,
    }

    struct Signer has store, key {
        id: 0x2::object::UID,
        signer_public_key_bytes: vector<u8>,
    }

    struct Nonce has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public fun buy<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(v1 == 0x2::coin::value<T1>(&arg2), 0);
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, v2)) {
            0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<address, 0x2::coin::Coin<T1>>(&mut arg0.id, v2), arg2);
        } else {
            0x2::dynamic_object_field::add<address, 0x2::coin::Coin<T1>>(&mut arg0.id, v2, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::dynamic_object_field::remove<address, 0x2::coin::Coin<T1>>(&mut arg0.id, v2), v2);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun buy_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: vector<0x2::object::ID>, arg2: vector<0x2::coin::Coin<T1>>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Signer>(&mut arg0.id, b"signer").signer_public_key_bytes;
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Nonce>(&mut arg0.id, b"nonce");
        let v2 = ListBuyMessage{
            item_id : arg1,
            counter : v1.counter,
        };
        let v3 = 0x2::bcs::to_bytes<ListBuyMessage>(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0, &v3), 4);
        v1.counter = v1.counter + 1;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v4 == 0x1::vector::length<0x2::coin::Coin<T1>>(&arg2), 2);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = vector[];
        while (v4 != 0) {
            let v7 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v7);
            let v8 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg2);
            0x1::vector::push_back<u64>(&mut v6, 0x2::coin::value<T1>(&v8));
            0x2::transfer::public_transfer<T0>(buy<T0, T1>(arg0, v7, v8), 0x2::tx_context::sender(arg4));
            v4 = v4 - 1;
        };
        let v9 = ListingBoughtEvent{
            item_id : v5,
            ask     : v6,
        };
        0x2::event::emit<ListingBoughtEvent>(v9);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg2);
    }

    public entry fun change_admin(arg0: &Admin, arg1: Admin, arg2: address) {
        0x2::transfer::transfer<Admin>(arg1, arg2);
        let v0 = NFTAdminChangedEvent{admin: arg2};
        0x2::event::emit<NFTAdminChangedEvent>(v0);
    }

    public entry fun create<T0>(arg0: &Admin, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = MarketplaceCreationEvent{marketplace_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<MarketplaceCreationEvent>(v1);
        let v2 = Marketplace<T0>{id: v0};
        0x2::transfer::share_object<Marketplace<T0>>(v2);
    }

    public entry fun create_admin(arg0: &Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg2)};
        let v1 = AdminSetEvent{
            admin_obj : 0x2::object::uid_to_inner(&v0.id),
            new_admin : arg1,
        };
        0x2::event::emit<AdminSetEvent>(v1);
        0x2::transfer::transfer<Admin>(v0, arg1);
    }

    public fun delist<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : _,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun delist_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: vector<0x2::object::ID>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 != 0) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v2);
            0x2::transfer::public_transfer<T0>(delist<T0, T1>(arg0, v2, arg2), 0x2::tx_context::sender(arg2));
            v0 = v0 - 1;
        };
        let v3 = CollectionDelistEvent{item_id: v1};
        0x2::event::emit<CollectionDelistEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketInfo{
            id               : 0x2::object::new(arg0),
            treasury_account : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<MarketInfo>(v0);
        let v1 = Owner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Owner>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: vector<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x1::vector::contains<0x1::ascii::String>(&0x2::dynamic_object_field::borrow<vector<u8>, CollectionWhitelist>(&arg0.id, b"whitelist").collection_address, &v1), 3);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = vector[];
        let v4 = 0x1::vector::length<T0>(&arg1);
        while (v4 != 0) {
            let v5 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v6 = 0x2::object::id<T0>(&v5);
            let v7 = 0x1::vector::pop_back<u64>(&mut arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v6);
            0x1::vector::push_back<u64>(&mut v3, v7);
            let v8 = Listing{
                id    : 0x2::object::new(arg3),
                ask   : v7,
                owner : 0x2::tx_context::sender(arg3),
            };
            0x2::dynamic_object_field::add<bool, T0>(&mut v8.id, true, v5);
            0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v6, v8);
            v4 = v4 - 1;
        };
        let v9 = ListingEvent{
            item_id : v2,
            ask     : v3,
        };
        0x2::event::emit<ListingEvent>(v9);
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public entry fun mint_and_buy<T0>(arg0: &mut 0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::nft::MembershipCap, arg1: &mut Marketplace<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::nft::CollectionDetails, arg4: &mut 0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::nft::QuestionInfo, arg5: &mut MarketInfo, arg6: &mut 0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::nft::Supply, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::ascii::String, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: vector<u8>, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 == 0x2::coin::value<T0>(&arg2), 0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Signer>(&mut arg1.id, b"signer").signer_public_key_bytes;
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Nonce>(&mut arg1.id, b"nonce");
        let v2 = MintBuyMessage{
            coin_value : 0x2::coin::value<T0>(&arg2),
            receiver   : arg14,
            counter    : v1.counter,
        };
        let v3 = 0x2::bcs::to_bytes<MintBuyMessage>(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg15, &v0, &v3), 4);
        v1.counter = v1.counter + 1;
        0x143eb55f7efedcc3f39b317e7f7794e5a0cd203782f01f8c1718ee72137c0001::nft::batch_mint(arg0, arg3, arg6, arg4, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg16);
        if (0x2::dynamic_object_field::exists_<address>(&arg1.id, arg5.treasury_account)) {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<address, 0x2::coin::Coin<T0>>(&mut arg1.id, arg5.treasury_account), arg2);
        } else {
            0x2::dynamic_object_field::add<address, 0x2::coin::Coin<T0>>(&mut arg1.id, arg5.treasury_account, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<address, 0x2::coin::Coin<T0>>(&mut arg1.id, arg5.treasury_account), arg5.treasury_account);
    }

    public entry fun remove_whitelist<T0>(arg0: &Admin, arg1: &mut Marketplace<T0>, arg2: 0x1::ascii::String) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, CollectionWhitelist>(&mut arg1.id, b"whitelist");
        let (v1, v2) = 0x1::vector::index_of<0x1::ascii::String>(&v0.collection_address, &arg2);
        assert!(v1, 3);
        0x1::vector::remove<0x1::ascii::String>(&mut v0.collection_address, v2);
        let v3 = RemoveWhitelistEvent{collection_address: arg2};
        0x2::event::emit<RemoveWhitelistEvent>(v3);
    }

    public entry fun set_market_info<T0>(arg0: &Admin, arg1: &mut Marketplace<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionWhitelist{
            id                 : 0x2::object::new(arg3),
            collection_address : 0x1::vector::empty<0x1::ascii::String>(),
        };
        let v1 = Signer{
            id                      : 0x2::object::new(arg3),
            signer_public_key_bytes : arg2,
        };
        let v2 = Nonce{
            id      : 0x2::object::new(arg3),
            counter : 0,
        };
        let v3 = MarketplaceInformationEvent{
            collection_whitelist_id : 0x2::object::uid_to_inner(&v0.id),
            signer_id               : 0x2::object::uid_to_inner(&v1.id),
            nonce_id                : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<MarketplaceInformationEvent>(v3);
        0x2::dynamic_object_field::add<vector<u8>, CollectionWhitelist>(&mut arg1.id, b"whitelist", v0);
        0x2::dynamic_object_field::add<vector<u8>, Signer>(&mut arg1.id, b"signer", v1);
        0x2::dynamic_object_field::add<vector<u8>, Nonce>(&mut arg1.id, b"nonce", v2);
    }

    public entry fun set_treasury_account(arg0: &Admin, arg1: &mut MarketInfo, arg2: address) {
        let v0 = TreasuryAccountSetEvent{new_treasury_account: arg2};
        0x2::event::emit<TreasuryAccountSetEvent>(v0);
        arg1.treasury_account = arg2;
    }

    public fun take_profits<T0>(arg0: &mut Marketplace<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::dynamic_object_field::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg1))
    }

    public entry fun take_profits_and_keep<T0>(arg0: &mut Marketplace<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take_profits<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun whitelist<T0>(arg0: &Admin, arg1: &mut Marketplace<T0>, arg2: 0x1::ascii::String) {
        0x1::vector::push_back<0x1::ascii::String>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, CollectionWhitelist>(&mut arg1.id, b"whitelist").collection_address, arg2);
        let v0 = CollectionWhitelistEvent{collection_address: arg2};
        0x2::event::emit<CollectionWhitelistEvent>(v0);
    }

    // decompiled from Move bytecode v6
}


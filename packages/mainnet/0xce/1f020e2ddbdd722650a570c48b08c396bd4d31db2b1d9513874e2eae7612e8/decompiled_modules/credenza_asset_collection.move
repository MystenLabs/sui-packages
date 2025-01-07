module 0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::credenza_asset_collection {
    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        assets: 0x2::table_vec::TableVec<AssetMetadata>,
        ownership: 0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::CredenzaOwnership,
    }

    struct CollectionCapCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct AssetMinted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        asset_id: u64,
        amount: u64,
    }

    struct AssetBurned has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        asset_id: u64,
        amount: u64,
    }

    struct CREDENZA_ASSET_COLLECTION has drop {
        dummy_field: bool,
    }

    struct CREDENZA_ASSET_COLLECTION_ITEM has drop {
        dummy_field: bool,
    }

    struct AssetMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        meta_url: 0x1::string::String,
        supply: 0x2::balance::Supply<CREDENZA_ASSET_COLLECTION_ITEM>,
        asset_id: u64,
    }

    struct TokenizedAsset has store, key {
        id: 0x2::object::UID,
        asset_id: u64,
        balance: 0x2::balance::Balance<CREDENZA_ASSET_COLLECTION_ITEM>,
    }

    struct AssetCreated has copy, drop {
        asset_id: u64,
    }

    public fun join(arg0: &mut TokenizedAsset, arg1: TokenizedAsset) : 0x2::object::ID {
        assert!(arg0.asset_id == arg1.asset_id, 1);
        let TokenizedAsset {
            id       : v0,
            asset_id : _,
            balance  : v2,
        } = arg1;
        0x2::balance::join<CREDENZA_ASSET_COLLECTION_ITEM>(&mut arg0.balance, v2);
        0x2::object::delete(v0);
        0x2::object::id<TokenizedAsset>(&arg1)
    }

    public fun split(arg0: &mut TokenizedAsset, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TokenizedAsset {
        let v0 = value(arg0);
        assert!(v0 > 1 && arg1 < v0, 3);
        assert!(arg1 > 0, 4);
        TokenizedAsset{
            id       : 0x2::object::new(arg2),
            asset_id : arg0.asset_id,
            balance  : 0x2::balance::split<CREDENZA_ASSET_COLLECTION_ITEM>(&mut arg0.balance, arg1),
        }
    }

    public fun value(arg0: &TokenizedAsset) : u64 {
        0x2::balance::value<CREDENZA_ASSET_COLLECTION_ITEM>(&arg0.balance)
    }

    public fun add_asset(arg0: &mut CollectionCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::table_vec::length<AssetMetadata>(&arg0.assets) + 1;
        let v1 = CREDENZA_ASSET_COLLECTION_ITEM{dummy_field: false};
        let v2 = AssetMetadata{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            meta_url    : arg3,
            supply      : 0x2::balance::create_supply<CREDENZA_ASSET_COLLECTION_ITEM>(v1),
            asset_id    : v0,
        };
        let v3 = AssetCreated{asset_id: v0};
        0x2::event::emit<AssetCreated>(v3);
        0x2::table_vec::push_back<AssetMetadata>(&mut arg0.assets, v2);
    }

    public fun burn(arg0: &mut CollectionCap, arg1: TokenizedAsset, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetBurned{
            id       : 0x2::object::id<TokenizedAsset>(&arg1),
            owner    : 0x2::tx_context::sender(arg2),
            asset_id : arg1.asset_id,
            amount   : value(&arg1),
        };
        0x2::event::emit<AssetBurned>(v0);
        let TokenizedAsset {
            id       : v1,
            asset_id : v2,
            balance  : v3,
        } = arg1;
        0x2::balance::decrease_supply<CREDENZA_ASSET_COLLECTION_ITEM>(&mut 0x2::table_vec::borrow_mut<AssetMetadata>(&mut arg0.assets, v2 - 1).supply, v3);
        0x2::object::delete(v1);
    }

    public fun buy_asset<T0>(arg0: &mut CollectionCap, arg1: &0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::sellable::CredenzaSellableConfig<CREDENZA_ASSET_COLLECTION>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::sellable::accept_asset_payment_coin<CREDENZA_ASSET_COLLECTION, T0>(arg1, arg3, arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg5);
        mint_(arg0, v0, arg3, arg4, arg5);
    }

    fun init(arg0: CREDENZA_ASSET_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = CollectionCap{
            id          : v0,
            symbol      : 0x1::string::utf8(b"CAC"),
            name        : 0x1::string::utf8(b"Credenza Asset Collection"),
            description : 0x1::string::utf8(b""),
            assets      : 0x2::table_vec::empty<AssetMetadata>(arg1),
            ownership   : 0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::create_ownership(0x2::object::uid_to_inner(&v0), arg1),
        };
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::add_owner(&mut v1.ownership, 0x2::tx_context::sender(arg1));
        let v2 = CollectionCapCreated{id: 0x2::object::id<CollectionCap>(&v1)};
        0x2::event::emit<CollectionCapCreated>(v2);
        let (_, v4) = 0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::sellable::create_config<CREDENZA_ASSET_COLLECTION>(arg0, arg1);
        0x2::transfer::public_share_object<CollectionCap>(v1);
        0x2::transfer::public_share_object<0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::sellable::CredenzaSellableConfig<CREDENZA_ASSET_COLLECTION>>(v4);
    }

    public fun mint(arg0: &mut CollectionCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        mint_(arg0, arg1, arg2, arg3, arg4);
    }

    fun mint_(arg0: &mut CollectionCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::length<AssetMetadata>(&arg0.assets) > arg2 - 1, 2);
        let v0 = TokenizedAsset{
            id       : 0x2::object::new(arg4),
            asset_id : arg2,
            balance  : 0x2::balance::increase_supply<CREDENZA_ASSET_COLLECTION_ITEM>(&mut 0x2::table_vec::borrow_mut<AssetMetadata>(&mut arg0.assets, arg2 - 1).supply, arg3),
        };
        let v1 = AssetMinted{
            id       : 0x2::object::id<TokenizedAsset>(&v0),
            owner    : arg1,
            asset_id : arg2,
            amount   : arg3,
        };
        0x2::event::emit<AssetMinted>(v1);
        0x2::transfer::public_transfer<TokenizedAsset>(v0, arg1);
    }

    public fun set_owner(arg0: &mut CollectionCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::set_owner(&mut arg0.ownership, arg1, arg2);
    }

    public fun update_collection_metadata(arg0: &mut CollectionCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        arg0.symbol = arg3;
        arg0.name = arg1;
        arg0.description = arg2;
    }

    public fun update_metadata(arg0: &mut CollectionCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0xce1f020e2ddbdd722650a570c48b08c396bd4d31db2b1d9513874e2eae7612e8::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg5));
        assert!(0x2::table_vec::length<AssetMetadata>(&arg0.assets) > arg1 - 1, 2);
        let v0 = 0x2::table_vec::borrow_mut<AssetMetadata>(&mut arg0.assets, arg1 - 1);
        v0.meta_url = arg4;
        v0.name = arg2;
        v0.description = arg3;
    }

    // decompiled from Move bytecode v6
}


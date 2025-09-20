module 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset {
    struct TOKENIZED_ASSET has drop {
        dummy_field: bool,
    }

    struct AssetCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        total_supply: u64,
        burnable: bool,
    }

    struct AssetMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        total_supply: u64,
        symbol: 0x1::ascii::String,
        description: 0x1::ascii::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct TokenizedAsset<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        metadata: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
        image_url: 0x1::ascii::String,
    }

    struct PlatformCap has store, key {
        id: 0x2::object::UID,
    }

    struct AssetCreated has copy, drop {
        asset_metadata: 0x2::object::ID,
        name: 0x1::ascii::String,
    }

    public fun join<T0>(arg0: &mut TokenizedAsset<T0>, arg1: TokenizedAsset<T0>) : 0x2::object::ID {
        assert!(0x2::vec_map::is_empty<0x1::ascii::String, 0x1::ascii::String>(&arg0.metadata) == true && 0x2::vec_map::is_empty<0x1::ascii::String, 0x1::ascii::String>(&arg1.metadata) == true, 3);
        let TokenizedAsset {
            id        : v0,
            balance   : v1,
            metadata  : _,
            image_url : _,
        } = arg1;
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
        0x2::object::id<TokenizedAsset<T0>>(&arg1)
    }

    public fun split<T0>(arg0: &mut TokenizedAsset<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TokenizedAsset<T0> {
        assert!(0x2::vec_map::is_empty<0x1::ascii::String, 0x1::ascii::String>(&arg0.metadata), 3);
        let v0 = value<T0>(arg0);
        assert!(v0 > 1 && arg1 < v0, 6);
        assert!(arg1 > 0, 7);
        TokenizedAsset<T0>{
            id        : 0x2::object::new(arg2),
            balance   : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            metadata  : arg0.metadata,
            image_url : 0x1::ascii::string(b""),
        }
    }

    public fun value<T0>(arg0: &TokenizedAsset<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun burn<T0>(arg0: &mut AssetCap<T0>, arg1: TokenizedAsset<T0>) {
        assert!(arg0.burnable == true, 4);
        let TokenizedAsset {
            id        : v0,
            balance   : v1,
            metadata  : _,
            image_url : _,
        } = arg1;
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, v1);
        0x2::object::delete(v0);
    }

    fun create_vec_map_from_arrays(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0) == 0x1::vector::length<0x1::ascii::String>(&arg1), 5);
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, *0x1::vector::borrow<0x1::ascii::String>(&arg0, v1), *0x1::vector::borrow<0x1::ascii::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: TOKENIZED_ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PlatformCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TOKENIZED_ASSET>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun metadata<T0>(arg0: &TokenizedAsset<T0>) : 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        arg0.metadata
    }

    public fun mint<T0>(arg0: &mut AssetCap<T0>, arg1: vector<0x1::ascii::String>, arg2: vector<0x1::ascii::String>, arg3: u64, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: &mut 0x2::tx_context::TxContext) : TokenizedAsset<T0> {
        assert!(supply<T0>(arg0) + arg3 <= arg0.total_supply, 1);
        let v0 = create_vec_map_from_arrays(arg1, arg2);
        assert!(!0x2::vec_map::is_empty<0x1::ascii::String, 0x1::ascii::String>(&v0) && arg3 == 1 || 0x2::vec_map::is_empty<0x1::ascii::String, 0x1::ascii::String>(&v0) && arg3 > 0, 3);
        let v1 = &mut arg4;
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(v1)) {
            0x1::option::extract<0x1::ascii::String>(v1)
        } else {
            0x1::ascii::string(b"")
        };
        TokenizedAsset<T0>{
            id        : 0x2::object::new(arg5),
            balance   : 0x2::balance::increase_supply<T0>(&mut arg0.supply, arg3),
            metadata  : v0,
            image_url : v2,
        }
    }

    public fun new_asset<T0: drop>(arg0: T0, arg1: u64, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (AssetCap<T0>, AssetMetadata<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 8);
        assert!(arg1 > 0, 2);
        let v0 = AssetCap<T0>{
            id           : 0x2::object::new(arg7),
            supply       : 0x2::balance::create_supply<T0>(arg0),
            total_supply : arg1,
            burnable     : arg6,
        };
        let v1 = AssetMetadata<T0>{
            id           : 0x2::object::new(arg7),
            name         : arg3,
            total_supply : arg1,
            symbol       : arg2,
            description  : arg4,
            icon_url     : arg5,
        };
        let v2 = AssetCreated{
            asset_metadata : 0x2::object::id<AssetMetadata<T0>>(&v1),
            name           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<AssetCreated>(v2);
        (v0, v1)
    }

    public fun supply<T0>(arg0: &AssetCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun total_supply<T0>(arg0: &AssetCap<T0>) : u64 {
        arg0.total_supply
    }

    public fun update_display<T0>(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        let v2 = 0x2::display::new_with_fields<TokenizedAsset<T0>>(arg0, v0, v1, arg1);
        0x2::display::update_version<TokenizedAsset<T0>>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<TokenizedAsset<T0>>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


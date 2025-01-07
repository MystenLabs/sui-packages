module 0xbce4fc3a1ee72284c7b321031af596ef9489841a6092eb5caa5bfe6e9257e598::havencompass {
    struct BasicEdition has drop {
        dummy_field: bool,
    }

    struct DeluxeEdition has drop {
        dummy_field: bool,
    }

    struct CollectorsEdition has drop {
        dummy_field: bool,
    }

    struct LaunchEdition has drop {
        dummy_field: bool,
    }

    struct GameKey<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct GameKeySupply<phantom T0> has store, key {
        id: 0x2::object::UID,
        max: u64,
        current: u64,
    }

    struct GameKeyMinted has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct HAVENCOMPASS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        max_mint: u64,
    }

    public fun burn_gamekey<T0>(arg0: GameKey<T0>, arg1: &mut GameKeySupply<T0>) {
        let GameKey {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        arg1.current = arg1.current - 1;
        0x2::object::delete(v0);
    }

    public fun burn_mintcap(arg0: MintCap) {
        let MintCap {
            id       : v0,
            max_mint : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun can_mint<T0>(arg0: &GameKeySupply<T0>) : bool {
        arg0.current < arg0.max
    }

    public fun currentSupply<T0>(arg0: &GameKeySupply<T0>) : u64 {
        arg0.current
    }

    public fun gamekey_description<T0>(arg0: &GameKey<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun gamekey_id<T0>(arg0: &GameKey<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun gamekey_name<T0>(arg0: &GameKey<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun gamekey_url<T0>(arg0: &GameKey<T0>) : 0x1::string::String {
        arg0.url
    }

    fun init(arg0: HAVENCOMPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HAVENCOMPASS>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = issue_mint_cap(&v1, 18446744073709551615, arg1);
        let v3 = GameKeySupply<BasicEdition>{
            id      : 0x2::object::new(arg1),
            max     : 10000,
            current : 0,
        };
        let v4 = GameKeySupply<DeluxeEdition>{
            id      : 0x2::object::new(arg1),
            max     : 7500,
            current : 0,
        };
        let v5 = GameKeySupply<CollectorsEdition>{
            id      : 0x2::object::new(arg1),
            max     : 5000,
            current : 0,
        };
        let v6 = GameKeySupply<LaunchEdition>{
            id      : 0x2::object::new(arg1),
            max     : 500,
            current : 0,
        };
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"url"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{img_url}"));
        let v11 = 0x2::display::new_with_fields<GameKey<BasicEdition>>(&v0, v7, v9, arg1);
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"url"));
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{img_url}"));
        let v16 = 0x2::display::new_with_fields<GameKey<DeluxeEdition>>(&v0, v12, v14, arg1);
        let v17 = 0x1::vector::empty<0x1::string::String>();
        let v18 = &mut v17;
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"url"));
        let v19 = 0x1::vector::empty<0x1::string::String>();
        let v20 = &mut v19;
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"{img_url}"));
        let v21 = 0x2::display::new_with_fields<GameKey<CollectorsEdition>>(&v0, v17, v19, arg1);
        let v22 = 0x1::vector::empty<0x1::string::String>();
        let v23 = &mut v22;
        0x1::vector::push_back<0x1::string::String>(v23, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v23, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v23, 0x1::string::utf8(b"url"));
        let v24 = 0x1::vector::empty<0x1::string::String>();
        let v25 = &mut v24;
        0x1::vector::push_back<0x1::string::String>(v25, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v25, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v25, 0x1::string::utf8(b"{img_url}"));
        let v26 = 0x2::display::new_with_fields<GameKey<LaunchEdition>>(&v0, v22, v24, arg1);
        0x2::display::update_version<GameKey<BasicEdition>>(&mut v11);
        0x2::display::update_version<GameKey<DeluxeEdition>>(&mut v16);
        0x2::display::update_version<GameKey<CollectorsEdition>>(&mut v21);
        0x2::display::update_version<GameKey<LaunchEdition>>(&mut v26);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameKey<BasicEdition>>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameKey<DeluxeEdition>>>(v16, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameKey<CollectorsEdition>>>(v21, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameKey<LaunchEdition>>>(v26, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GameKeySupply<BasicEdition>>(v3);
        0x2::transfer::share_object<GameKeySupply<DeluxeEdition>>(v4);
        0x2::transfer::share_object<GameKeySupply<CollectorsEdition>>(v5);
        0x2::transfer::share_object<GameKeySupply<LaunchEdition>>(v6);
    }

    public fun issue_mint_cap(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{
            id       : 0x2::object::new(arg2),
            max_mint : arg1,
        }
    }

    public fun maxSupply<T0>(arg0: &GameKeySupply<T0>) : u64 {
        arg0.max
    }

    public fun mint<T0>(arg0: &mut MintCap, arg1: &mut GameKeySupply<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : GameKey<T0> {
        assert!(arg0.max_mint > 0, 2);
        assert!(can_mint<T0>(arg1), 1);
        let v0 = GameKey<T0>{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            description : arg3,
            url         : arg4,
        };
        arg1.current = arg1.current + 1;
        arg0.max_mint = arg0.max_mint - 1;
        let v1 = GameKeyMinted{
            id      : 0x2::object::uid_to_inner(&v0.id),
            name    : v0.name,
            creator : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<GameKeyMinted>(v1);
        v0
    }

    public fun mintcap_max_mint(arg0: &MintCap) : u64 {
        arg0.max_mint
    }

    public fun reset_mintcap(arg0: &AdminCap, arg1: &mut MintCap, arg2: u64) {
        arg1.max_mint = arg2;
    }

    // decompiled from Move bytecode v6
}


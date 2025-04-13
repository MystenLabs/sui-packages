module 0xb8b16acf7c5edbbd659ad42e280d4e658f006408a5d594a3141f0a6ee76cdfd9::dynamic_nft {
    struct DYNAMIC_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TimeOracle has key {
        id: 0x2::object::UID,
        update_interval: u64,
    }

    struct DynamicNFT has store, key {
        id: 0x2::object::UID,
        current_state: u8,
        image_one: 0x1::string::String,
        image_two: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        last_updated: u64,
        current_image: 0x1::string::String,
        update_interval: u64,
        owner: address,
    }

    struct ColorChangeEvent has copy, drop {
        nft_id: address,
        new_state: u8,
        timestamp: u64,
    }

    struct UpdateIntervalEvent has copy, drop {
        nft_id: address,
        new_interval: u64,
        timestamp: u64,
    }

    public entry fun change_default_interval(arg0: &AdminCap, arg1: &mut TimeOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.update_interval = arg2;
    }

    public entry fun change_nft_interval(arg0: &mut DynamicNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        arg0.update_interval = arg1;
        let v0 = UpdateIntervalEvent{
            nft_id       : 0x2::object::id_address<DynamicNFT>(arg0),
            new_interval : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpdateIntervalEvent>(v0);
    }

    public fun get_current_image(arg0: &DynamicNFT) : 0x1::string::String {
        if (arg0.current_state == 0) {
            arg0.image_one
        } else {
            arg0.image_two
        }
    }

    public fun get_default_interval(arg0: &TimeOracle) : u64 {
        arg0.update_interval
    }

    public fun get_update_interval(arg0: &DynamicNFT) : u64 {
        arg0.update_interval
    }

    fun init(arg0: DYNAMIC_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeOracle{
            id              : 0x2::object::new(arg1),
            update_interval : 300,
        };
        0x2::transfer::share_object<TimeOracle>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::package::claim<DYNAMIC_NFT>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"current_state"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"update_interval"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{current_image}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{current_state}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{update_interval}"));
        let v7 = 0x2::display::new_with_fields<DynamicNFT>(&v2, v3, v5, arg1);
        0x2::display::update_version<DynamicNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<DynamicNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_update_due(arg0: &DynamicNFT, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_updated + arg0.update_interval * 1000
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &TimeOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = DynamicNFT{
            id              : 0x2::object::new(arg6),
            current_state   : 0,
            image_one       : v0,
            image_two       : 0x1::string::utf8(arg1),
            name            : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            last_updated    : 0x2::clock::timestamp_ms(arg5),
            current_image   : v0,
            update_interval : arg4.update_interval,
            owner           : 0x2::tx_context::sender(arg6),
        };
        0x2::transfer::transfer<DynamicNFT>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun update_nft_state(arg0: &mut DynamicNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_updated + arg0.update_interval * 1000, 1);
        let v1 = if (arg0.current_state == 0) {
            1
        } else {
            0
        };
        arg0.current_state = v1;
        arg0.last_updated = v0;
        let v2 = if (arg0.current_state == 0) {
            arg0.image_one
        } else {
            arg0.image_two
        };
        arg0.current_image = v2;
        let v3 = ColorChangeEvent{
            nft_id    : 0x2::object::id_address<DynamicNFT>(arg0),
            new_state : arg0.current_state,
            timestamp : v0,
        };
        0x2::event::emit<ColorChangeEvent>(v3);
    }

    // decompiled from Move bytecode v6
}


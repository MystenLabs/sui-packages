module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class {
    struct ItemCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        class: 0x2::object::ID,
    }

    struct Kind has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        minted: u64,
        burned: u64,
    }

    struct Class<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        game: 0x1::string::String,
        name: 0x1::string::String,
        issuer: vector<u8>,
        kinds: 0x2::table::Table<u64, Kind>,
        policy: 0x2::object::ID,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>,
        display: 0x2::display::Display<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>,
        lock: bool,
        paused: bool,
        minted: u64,
        burned: u64,
    }

    struct NonceKey has copy, drop, store {
        player: address,
        nonce: u64,
    }

    public fun display<T0>(arg0: &Class<T0>) : &0x2::display::Display<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>> {
        &arg0.display
    }

    public fun add_kind<T0>(arg0: &ItemCap<T0>, arg1: &mut Class<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) : u64 {
        assert_cap<T0>(arg1, arg0);
        assert!(arg1.version == 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::current(), 207);
        let v0 = if (0x1::string::length(&arg2) > 0) {
            if (0x1::string::length(&arg2) <= 128) {
                if (0x1::string::length(&arg3) <= 1024) {
                    0x1::string::length(&arg4) <= 512
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 204);
        let v1 = 0x2::table::length<u64, Kind>(&arg1.kinds);
        let v2 = Kind{
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            max_supply  : arg5,
            minted      : 0,
            burned      : 0,
        };
        0x2::table::add<u64, Kind>(&mut arg1.kinds, v1, v2);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::kind_added(0x2::object::id<Class<T0>>(arg1), v1, arg2, arg3, arg4, arg5);
        v1
    }

    public(friend) fun assert_cap<T0>(arg0: &Class<T0>, arg1: &ItemCap<T0>) {
        assert!(arg1.class == 0x2::object::id<Class<T0>>(arg0), 205);
    }

    public(friend) fun assert_live<T0>(arg0: &Class<T0>) {
        assert!(arg0.version == 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::current(), 207);
        assert!(!arg0.paused, 208);
    }

    public(friend) fun assert_policy<T0>(arg0: &Class<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>) {
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>>(arg1) == arg0.policy, 206);
    }

    public fun burned<T0>(arg0: &Class<T0>) : u64 {
        arg0.burned
    }

    public fun cap_class<T0>(arg0: &ItemCap<T0>) : 0x2::object::ID {
        arg0.class
    }

    fun check_key(arg0: &vector<u8>) {
        assert!(0x1::vector::is_empty<u8>(arg0) || 0x1::vector::length<u8>(arg0) == 32, 202);
    }

    public fun create<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::Config, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : (Class<T0>, ItemCap<T0>) {
        assert!(0x2::package::from_module<T0>(arg1), 201);
        let v0 = if (0x1::string::length(&arg2) > 0) {
            if (0x1::string::length(&arg2) <= 96) {
                if (0x1::string::length(&arg3) > 0) {
                    0x1::string::length(&arg3) <= 128
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 204);
        assert!(arg4 <= 10000, 203);
        check_key(&arg7);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::bind<T0>(arg0, v2);
        let (v3, v4) = 0x2::transfer_policy::new<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::publisher(arg0), arg8);
        let v5 = v4;
        let v6 = v3;
        if (arg4 > 0 || arg5 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v6, &v5, arg4, arg5);
        };
        if (arg6) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v6, &v5);
        };
        let v7 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>>(&v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>>(v6);
        let v8 = 0x1::string::utf8(b"https://rare.market/games/");
        0x1::string::append(&mut v8, arg2);
        let v9 = 0x2::display::new<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::publisher(arg0), arg8);
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"project_url"), v8);
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"creator"), arg3);
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attrs}"));
        0x2::display::add<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9, 0x1::string::utf8(b"serial"), 0x1::string::utf8(b"{serial}"));
        0x2::display::update_version<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&mut v9);
        let v10 = ItemCap<T0>{
            id    : 0x2::object::new(arg8),
            class : v2,
        };
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::class_created(v2, 0x2::object::id<ItemCap<T0>>(&v10), v7, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>()), arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::sender(arg8));
        let v11 = Class<T0>{
            id         : v1,
            version    : 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::current(),
            game       : arg2,
            name       : arg3,
            issuer     : arg7,
            kinds      : 0x2::table::new<u64, Kind>(arg8),
            policy     : v7,
            policy_cap : v5,
            display    : v9,
            lock       : arg6,
            paused     : false,
            minted     : 0,
            burned     : 0,
        };
        (v11, v10)
    }

    public fun game<T0>(arg0: &Class<T0>) : 0x1::string::String {
        arg0.game
    }

    public fun issuer<T0>(arg0: &Class<T0>) : vector<u8> {
        arg0.issuer
    }

    public(friend) fun issuer_ref<T0>(arg0: &Class<T0>) : &vector<u8> {
        &arg0.issuer
    }

    public fun kind<T0>(arg0: &Class<T0>, arg1: u64) : Kind {
        assert!(0x2::table::contains<u64, Kind>(&arg0.kinds, arg1), 209);
        *0x2::table::borrow<u64, Kind>(&arg0.kinds, arg1)
    }

    public fun kind_burned(arg0: &Kind) : u64 {
        arg0.burned
    }

    public fun kind_count<T0>(arg0: &Class<T0>) : u64 {
        0x2::table::length<u64, Kind>(&arg0.kinds)
    }

    public fun kind_description(arg0: &Kind) : 0x1::string::String {
        arg0.description
    }

    public fun kind_image_url(arg0: &Kind) : 0x1::string::String {
        arg0.image_url
    }

    public fun kind_max_supply(arg0: &Kind) : u64 {
        arg0.max_supply
    }

    public fun kind_minted(arg0: &Kind) : u64 {
        arg0.minted
    }

    public fun kind_name(arg0: &Kind) : 0x1::string::String {
        arg0.name
    }

    public fun lock<T0>(arg0: &Class<T0>) : bool {
        arg0.lock
    }

    public fun migrate<T0>(arg0: &mut Class<T0>) {
        assert!(arg0.version < 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::current(), 212);
        arg0.version = 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config::current();
    }

    public fun minted<T0>(arg0: &Class<T0>) : u64 {
        arg0.minted
    }

    public fun name<T0>(arg0: &Class<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun nonce_used<T0>(arg0: &Class<T0>, arg1: address, arg2: u64) : bool {
        let v0 = NonceKey{
            player : arg1,
            nonce  : arg2,
        };
        0x2::dynamic_field::exists<NonceKey>(&arg0.id, v0)
    }

    public fun paused<T0>(arg0: &Class<T0>) : bool {
        arg0.paused
    }

    public fun policy<T0>(arg0: &Class<T0>) : 0x2::object::ID {
        arg0.policy
    }

    public(friend) fun record_burn<T0>(arg0: &mut Class<T0>, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Kind>(&mut arg0.kinds, arg1);
        v0.burned = v0.burned + 1;
        arg0.burned = arg0.burned + 1;
    }

    public fun set_issuer<T0>(arg0: &ItemCap<T0>, arg1: &mut Class<T0>, arg2: vector<u8>) {
        assert_cap<T0>(arg1, arg0);
        check_key(&arg2);
        arg1.issuer = arg2;
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::issuer_set(0x2::object::id<Class<T0>>(arg1), arg2);
    }

    public fun set_paused<T0>(arg0: &ItemCap<T0>, arg1: &mut Class<T0>, arg2: bool) {
        assert_cap<T0>(arg1, arg0);
        arg1.paused = arg2;
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::class_paused(0x2::object::id<Class<T0>>(arg1), arg2);
    }

    public fun share<T0>(arg0: Class<T0>) {
        0x2::transfer::share_object<Class<T0>>(arg0);
    }

    public(friend) fun take_serial<T0>(arg0: &mut Class<T0>, arg1: u64) : (u64, Kind) {
        assert!(0x2::table::contains<u64, Kind>(&arg0.kinds, arg1), 209);
        let v0 = 0x2::table::borrow_mut<u64, Kind>(&mut arg0.kinds, arg1);
        assert!(v0.max_supply == 0 || v0.minted < v0.max_supply, 210);
        v0.minted = v0.minted + 1;
        let v1 = *v0;
        arg0.minted = arg0.minted + 1;
        (v1.minted, v1)
    }

    public(friend) fun use_nonce<T0>(arg0: &mut Class<T0>, arg1: address, arg2: u64) {
        let v0 = NonceKey{
            player : arg1,
            nonce  : arg2,
        };
        assert!(!0x2::dynamic_field::exists<NonceKey>(&arg0.id, v0), 211);
        0x2::dynamic_field::add<NonceKey, bool>(&mut arg0.id, v0, true);
    }

    public fun version<T0>(arg0: &Class<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_royalties<T0>(arg0: &ItemCap<T0>, arg1: &Class<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_cap<T0>(arg1, arg0);
        assert_policy<T0>(arg1, arg2);
        let v0 = 0x2::transfer_policy::withdraw<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(arg2, &arg1.policy_cap, 0x1::option::none<u64>(), arg3);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::royalties_withdrawn(0x2::object::id<Class<T0>>(arg1), 0x2::coin::value<0x2::sui::SUI>(&v0), 0x2::tx_context::sender(arg3));
        v0
    }

    // decompiled from Move bytecode v7
}


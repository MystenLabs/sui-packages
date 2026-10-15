module 0x9c756a9778e4e9a00f8206420b832a28336b24819a7b54db6be009dfb613dfb5::shop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CosmeticPrice has copy, drop, store {
        brawler: u8,
        sui: u64,
        hsui: u64,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        treasury: address,
        paused: bool,
        max_level: u8,
        base_price_sui: u64,
        base_price_hsui: u64,
        growth_bps: u64,
        hsui_type: 0x1::option::Option<0x1::type_name::TypeName>,
        cosmetics: 0x2::vec_map::VecMap<0x1::string::String, CosmeticPrice>,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        levels: vector<u8>,
        cosmetics: vector<0x1::string::String>,
    }

    struct ProfileCreated has copy, drop {
        profile: 0x2::object::ID,
        owner: address,
    }

    struct UpgradePurchased has copy, drop {
        profile: 0x2::object::ID,
        owner: address,
        brawler: u8,
        stat: u8,
        new_level: u8,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        treasury: address,
    }

    struct CosmeticPurchased has copy, drop {
        profile: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        treasury: address,
    }

    fun add_default(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, CosmeticPrice>, arg1: vector<u8>, arg2: u8, arg3: u64) {
        let v0 = CosmeticPrice{
            brawler : arg2,
            sui     : arg3,
            hsui    : 0,
        };
        0x2::vec_map::insert<0x1::string::String, CosmeticPrice>(arg0, 0x1::string::utf8(arg1), v0);
    }

    fun assert_hsui<T0>(arg0: &Shop) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.hsui_type), 8);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.hsui_type) == 0x1::type_name::with_defining_ids<T0>(), 4);
    }

    public fun buy_cosmetic_hsui<T0>(arg0: &Shop, arg1: &mut Profile, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>) {
        assert!(!arg0.paused, 7);
        assert_hsui<T0>(arg0);
        assert!(0x2::vec_map::contains<0x1::string::String, CosmeticPrice>(&arg0.cosmetics, &arg2), 5);
        let v0 = 0x2::vec_map::get<0x1::string::String, CosmeticPrice>(&arg0.cosmetics, &arg2).hsui;
        assert!(v0 > 0, 8);
        pay_cosmetic<T0>(arg0, arg1, arg2, v0, arg3);
    }

    public fun buy_cosmetic_sui(arg0: &Shop, arg1: &mut Profile, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.paused, 7);
        assert!(0x2::vec_map::contains<0x1::string::String, CosmeticPrice>(&arg0.cosmetics, &arg2), 5);
        let v0 = 0x2::vec_map::get<0x1::string::String, CosmeticPrice>(&arg0.cosmetics, &arg2).sui;
        assert!(v0 > 0, 4);
        pay_cosmetic<0x2::sui::SUI>(arg0, arg1, arg2, v0, arg3);
    }

    public fun buy_upgrade_hsui<T0>(arg0: &Shop, arg1: &mut Profile, arg2: u8, arg3: u8, arg4: 0x2::coin::Coin<T0>) {
        assert!(!arg0.paused, 7);
        assert_hsui<T0>(arg0);
        assert!(arg0.base_price_hsui > 0, 8);
        let v0 = current_level(arg1, arg2, arg3);
        assert!(v0 < arg0.max_level, 1);
        pay_upgrade<T0>(arg0, arg1, arg2, arg3, v0, price_at(arg0.base_price_hsui, arg0.growth_bps, v0), arg4);
    }

    public fun buy_upgrade_sui(arg0: &Shop, arg1: &mut Profile, arg2: u8, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.paused, 7);
        let v0 = current_level(arg1, arg2, arg3);
        assert!(v0 < arg0.max_level, 1);
        pay_upgrade<0x2::sui::SUI>(arg0, arg1, arg2, arg3, v0, price_at(arg0.base_price_sui, arg0.growth_bps, v0), arg4);
    }

    public fun create_profile(arg0: &mut Shop, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 9);
        let v1 = b"";
        let v2 = 0;
        while (v2 < (3 as u64) * (3 as u64)) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = Profile{
            id        : 0x2::object::new(arg1),
            owner     : v0,
            levels    : v1,
            cosmetics : 0x1::vector::empty<0x1::string::String>(),
        };
        let v4 = 0x2::object::id<Profile>(&v3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v4);
        let v5 = ProfileCreated{
            profile : v4,
            owner   : v0,
        };
        0x2::event::emit<ProfileCreated>(v5);
        0x2::transfer::transfer<Profile>(v3, v0);
    }

    fun current_level(arg0: &Profile, arg1: u8, arg2: u8) : u8 {
        *0x1::vector::borrow<u8>(&arg0.levels, index(arg1, arg2))
    }

    fun index(arg0: u8, arg1: u8) : u64 {
        assert!(arg0 < 3, 2);
        assert!(arg1 < 3, 3);
        (arg0 as u64) * (3 as u64) + (arg1 as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, CosmeticPrice>();
        let v1 = &mut v0;
        add_default(v1, b"ripple:sunset", 0, 1000000000);
        let v2 = &mut v0;
        add_default(v2, b"ripple:abyss", 0, 2000000000);
        let v3 = &mut v0;
        add_default(v3, b"brine:golden", 1, 1000000000);
        let v4 = &mut v0;
        add_default(v4, b"brine:frost", 1, 2000000000);
        let v5 = &mut v0;
        add_default(v5, b"mist:void", 2, 1000000000);
        let v6 = &mut v0;
        add_default(v6, b"mist:aurora", 2, 2000000000);
        let v7 = Shop{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::tx_context::sender(arg0),
            paused          : false,
            max_level       : 5,
            base_price_sui  : 500000000,
            base_price_hsui : 0,
            growth_bps      : 18000,
            hsui_type       : 0x1::option::none<0x1::type_name::TypeName>(),
            cosmetics       : v0,
            profiles        : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Shop>(v7);
        let v8 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg0));
    }

    public fun level(arg0: &Profile, arg1: u8, arg2: u8) : u8 {
        current_level(arg0, arg1, arg2)
    }

    public fun owns_cosmetic(arg0: &Profile, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.cosmetics, arg1)
    }

    fun pay_cosmetic<T0>(arg0: &Shop, arg1: &mut Profile, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<T0>) {
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.cosmetics, &arg2), 6);
        assert!(0x2::coin::value<T0>(&arg4) == arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg0.treasury);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.cosmetics, arg2);
        let v0 = CosmeticPurchased{
            profile   : 0x2::object::id<Profile>(arg1),
            owner     : arg1.owner,
            name      : arg2,
            amount    : arg3,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            treasury  : arg0.treasury,
        };
        0x2::event::emit<CosmeticPurchased>(v0);
    }

    fun pay_upgrade<T0>(arg0: &Shop, arg1: &mut Profile, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg6) == arg5, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, arg0.treasury);
        *0x1::vector::borrow_mut<u8>(&mut arg1.levels, index(arg2, arg3)) = arg4 + 1;
        let v0 = UpgradePurchased{
            profile   : 0x2::object::id<Profile>(arg1),
            owner     : arg1.owner,
            brawler   : arg2,
            stat      : arg3,
            new_level : arg4 + 1,
            amount    : arg5,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            treasury  : arg0.treasury,
        };
        0x2::event::emit<UpgradePurchased>(v0);
    }

    public fun price_at(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = (arg0 as u128);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = v0 * (arg1 as u128);
            v0 = v2 / 10000;
            v1 = v1 + 1;
        };
        (v0 as u64)
    }

    public fun remove_cosmetic(arg0: &AdminCap, arg1: &mut Shop, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, CosmeticPrice>(&arg1.cosmetics, &arg2), 5);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, CosmeticPrice>(&mut arg1.cosmetics, &arg2);
    }

    public fun set_cosmetic(arg0: &AdminCap, arg1: &mut Shop, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64) {
        assert!(arg3 < 3, 2);
        let v0 = CosmeticPrice{
            brawler : arg3,
            sui     : arg4,
            hsui    : arg5,
        };
        if (0x2::vec_map::contains<0x1::string::String, CosmeticPrice>(&arg1.cosmetics, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, CosmeticPrice>(&mut arg1.cosmetics, &arg2) = v0;
        } else {
            0x2::vec_map::insert<0x1::string::String, CosmeticPrice>(&mut arg1.cosmetics, arg2, v0);
        };
    }

    public fun set_hsui_type<T0>(arg0: &AdminCap, arg1: &mut Shop) {
        arg1.hsui_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Shop, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_prices(arg0: &AdminCap, arg1: &mut Shop, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = if (arg2 > 0) {
            if (arg4 >= 10000) {
                arg4 <= 50000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        assert!(arg5 > 0 && arg5 <= 10, 10);
        arg1.base_price_sui = arg2;
        arg1.base_price_hsui = arg3;
        arg1.growth_bps = arg4;
        arg1.max_level = arg5;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Shop, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun treasury(arg0: &Shop) : address {
        arg0.treasury
    }

    public fun upgrade_price_hsui(arg0: &Shop, arg1: &Profile, arg2: u8, arg3: u8) : u64 {
        price_at(arg0.base_price_hsui, arg0.growth_bps, current_level(arg1, arg2, arg3))
    }

    public fun upgrade_price_sui(arg0: &Shop, arg1: &Profile, arg2: u8, arg3: u8) : u64 {
        price_at(arg0.base_price_sui, arg0.growth_bps, current_level(arg1, arg2, arg3))
    }

    // decompiled from Move bytecode v7
}


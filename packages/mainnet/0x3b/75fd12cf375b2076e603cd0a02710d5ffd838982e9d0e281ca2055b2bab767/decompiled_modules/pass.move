module 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::pass {
    struct PassShopKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PassBookKey has copy, drop, store {
        pos0: address,
    }

    struct PassShop<phantom T0> has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x2::object::ID, u64>,
        treasury: address,
        paused: bool,
        version: u64,
    }

    struct PassBook has key {
        id: 0x2::object::UID,
        owner: address,
        passes: 0x2::table::Table<0x2::object::ID, u64>,
        total: u64,
        version: u64,
    }

    struct PassShopCreated has copy, drop {
        shop_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        treasury: address,
    }

    struct PassShopUpdated has copy, drop {
        shop_id: 0x2::object::ID,
        treasury: address,
        paused: bool,
        version: u64,
    }

    struct PassPriceSet has copy, drop {
        shop_id: 0x2::object::ID,
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        price: u64,
    }

    struct PassBookCreated has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
    }

    struct PassBought has copy, drop {
        shop_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        owner: address,
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        price: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PassRedeemed has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        sale_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        edition_serial: u64,
        passes_left: u64,
    }

    fun assert_book_version(arg0: &PassBook) {
        assert!(arg0.version == 1, 13906836089898926083);
    }

    fun assert_shop_version<T0>(arg0: &PassShop<T0>) {
        assert!(arg0.version == 1, 13906836072719056899);
    }

    public fun book_address(arg0: 0x2::object::ID, arg1: address) : address {
        let v0 = PassBookKey{pos0: arg1};
        0x2::derived_object::derive_address<PassBookKey>(arg0, v0)
    }

    public fun book_exists(arg0: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::ShopRegistry, arg1: address) : bool {
        let v0 = PassBookKey{pos0: arg1};
        0x2::derived_object::exists<PassBookKey>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid(arg0), v0)
    }

    public fun book_version(arg0: &PassBook) : u64 {
        arg0.version
    }

    public fun buy_pass<T0>(arg0: &PassShop<T0>, arg1: &mut PassBook, arg2: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_shop_version<T0>(arg0);
        assert_book_version(arg1);
        assert!(!arg0.paused, 13906835449949716497);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 13906835454244814867);
        let v0 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.prices, v0), 13906835462834880533);
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.prices, v0);
        assert!(v1 == arg4, 13906835471424946199);
        assert!(0x2::coin::value<T0>(arg3) >= v1, 13906835475720044569);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, v1, arg5), arg0.treasury);
        let v2 = pass_count(arg1, v0);
        if (v2 > 0) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.passes, v0) = v2 + 1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.passes, v0, 1);
        };
        arg1.total = arg1.total + 1;
        let v3 = PassBought{
            shop_id       : 0x2::object::id<PassShop<T0>>(arg0),
            book_id       : 0x2::object::id<PassBook>(arg1),
            owner         : arg1.owner,
            definition_id : v0,
            archetype_id  : 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::definition_archetype_id(arg2),
            price         : v1,
            coin_type     : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<PassBought>(v3);
    }

    public fun create_pass_shop<T0>(arg0: &mut 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::ShopRegistry, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 13906834951733116939);
        let v0 = PassShopKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<PassShopKey<T0>>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid(arg0), v0), 13906834956027822087);
        let v1 = PassShopKey<T0>{dummy_field: false};
        let v2 = PassShop<T0>{
            id       : 0x2::derived_object::claim<PassShopKey<T0>>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid_mut(arg0), v1),
            prices   : 0x2::table::new<0x2::object::ID, u64>(arg3),
            treasury : arg2,
            paused   : false,
            version  : 1,
        };
        let v3 = PassShopCreated{
            shop_id   : 0x2::object::id<PassShop<T0>>(&v2),
            coin_type : 0x1::type_name::with_original_ids<T0>(),
            treasury  : arg2,
        };
        0x2::event::emit<PassShopCreated>(v3);
        0x2::transfer::share_object<PassShop<T0>>(v2);
    }

    fun emit_shop_updated<T0>(arg0: &PassShop<T0>) {
        let v0 = PassShopUpdated{
            shop_id  : 0x2::object::id<PassShop<T0>>(arg0),
            treasury : arg0.treasury,
            paused   : arg0.paused,
            version  : arg0.version,
        };
        0x2::event::emit<PassShopUpdated>(v0);
    }

    public fun is_paused<T0>(arg0: &PassShop<T0>) : bool {
        arg0.paused
    }

    public fun max_pass_price() : u64 {
        1000000000000
    }

    public fun migrate_book(arg0: &mut PassBook) {
        assert!(arg0.version < 1, 13906835832201019397);
        arg0.version = 1;
    }

    public fun migrate_pass_shop<T0>(arg0: &mut PassShop<T0>, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap) {
        assert!(arg0.version < 1, 13906835248085467141);
        arg0.version = 1;
        emit_shop_updated<T0>(arg0);
    }

    public fun new_book(arg0: &mut 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::ShopRegistry, arg1: &mut 0x2::tx_context::TxContext) : PassBook {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PassBookKey{pos0: v0};
        assert!(!0x2::derived_object::exists<PassBookKey>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid(arg0), v1), 13906835303920304137);
        let v2 = PassBookKey{pos0: v0};
        let v3 = PassBook{
            id      : 0x2::derived_object::claim<PassBookKey>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid_mut(arg0), v2),
            owner   : v0,
            passes  : 0x2::table::new<0x2::object::ID, u64>(arg1),
            total   : 0,
            version : 1,
        };
        let v4 = PassBookCreated{
            book_id : 0x2::object::id<PassBook>(&v3),
            owner   : v0,
        };
        0x2::event::emit<PassBookCreated>(v4);
        v3
    }

    public fun owner(arg0: &PassBook) : address {
        arg0.owner
    }

    public fun package_version() : u64 {
        1
    }

    public fun pass_count(arg0: &PassBook, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.passes, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.passes, arg1)
        } else {
            0
        }
    }

    public fun pass_shop_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = PassShopKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<PassShopKey<T0>>(arg0, v0)
    }

    public fun pass_shop_exists<T0>(arg0: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::ShopRegistry) : bool {
        let v0 = PassShopKey<T0>{dummy_field: false};
        0x2::derived_object::exists<PassShopKey<T0>>(0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::registry_uid(arg0), v0)
    }

    public fun price<T0>(arg0: &PassShop<T0>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.prices, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.prices, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    fun price_option(arg0: u64) : 0x1::option::Option<u64> {
        if (arg0 > 0) {
            0x1::option::some<u64>(arg0)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun redeem_pass<T0>(arg0: &mut PassBook, arg1: &mut 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CharacterSale, arg2: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg3: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>, arg4: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_book_version(arg0);
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 13906835651813310483);
        let v0 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition>(arg2);
        let v1 = pass_count(arg0, v0);
        assert!(v1 > 0, 13906835664698736667);
        let (v2, v3, v4) = 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::mint_reserved_character<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v5 = v1 - 1;
        if (v5 > 0) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.passes, v0) = v5;
        } else {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.passes, v0);
        };
        arg0.total = arg0.total - 1;
        let v6 = PassRedeemed{
            book_id        : 0x2::object::id<PassBook>(arg0),
            owner          : arg0.owner,
            definition_id  : v0,
            archetype_id   : 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::definition_archetype_id(arg2),
            sale_id        : 0x2::object::id<0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CharacterSale>(arg1),
            character_id   : v2,
            account_id     : v3,
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            edition_serial : v4,
            passes_left    : v5,
        };
        0x2::event::emit<PassRedeemed>(v6);
        v2
    }

    public fun set_pass_paused<T0>(arg0: &mut PassShop<T0>, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg2: bool) {
        assert_shop_version<T0>(arg0);
        assert!(arg2 != arg0.paused, 13906835213726384143);
        arg0.paused = arg2;
        emit_shop_updated<T0>(arg0);
    }

    public fun set_pass_price<T0>(arg0: &mut PassShop<T0>, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg2: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg3: u64) {
        assert_shop_version<T0>(arg0);
        assert!(arg3 <= 1000000000000, 13906835076287299597);
        let v0 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition>(arg2);
        assert!(price<T0>(arg0, v0) != price_option(arg3), 13906835084877365263);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.prices, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.prices, v0);
        };
        if (arg3 > 0) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.prices, v0, arg3);
        };
        let v1 = PassPriceSet{
            shop_id       : 0x2::object::id<PassShop<T0>>(arg0),
            definition_id : v0,
            archetype_id  : 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::definition_archetype_id(arg2),
            price         : arg3,
        };
        0x2::event::emit<PassPriceSet>(v1);
    }

    public fun set_pass_treasury<T0>(arg0: &mut PassShop<T0>, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg2: address) {
        assert_shop_version<T0>(arg0);
        assert!(arg2 != @0x0, 13906835170776449035);
        assert!(arg2 != arg0.treasury, 13906835175071678479);
        arg0.treasury = arg2;
        emit_shop_updated<T0>(arg0);
    }

    public fun share_book(arg0: PassBook) {
        0x2::transfer::share_object<PassBook>(arg0);
    }

    public fun shop_version<T0>(arg0: &PassShop<T0>) : u64 {
        arg0.version
    }

    public fun total(arg0: &PassBook) : u64 {
        arg0.total
    }

    public fun treasury<T0>(arg0: &PassShop<T0>) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}


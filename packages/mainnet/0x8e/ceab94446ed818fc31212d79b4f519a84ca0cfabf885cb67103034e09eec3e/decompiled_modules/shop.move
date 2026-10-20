module 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop {
    struct AbilityAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ShopKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AbilityProceeds has drop {
        dummy_field: bool,
    }

    struct AbilityShop<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        prices: vector<u64>,
        charges_per_pack: u64,
    }

    struct AbilityShopCreated has copy, drop {
        shop_id: 0x2::object::ID,
        prices: vector<u64>,
        charges_per_pack: u64,
    }

    struct AbilityShopUpdated has copy, drop {
        shop_id: 0x2::object::ID,
        group: vector<u8>,
    }

    struct AbilityPacksBought has copy, drop {
        shop_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        owner: address,
        kind: u8,
        packs: u64,
        price: u64,
        paid: u64,
        charges_added: u64,
        charges: u64,
    }

    fun assert_version<T0>(arg0: &AbilityShop<T0>) {
        assert!(arg0.version == 1, 13906835437064093702);
    }

    fun assert_charges_per_pack(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 100, 13906835471425011736);
    }

    fun assert_price(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 1000000000000, 13906835454245142552);
    }

    public fun buy<T0>(arg0: &AbilityShop<T0>, arg1: &mut 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityBook, arg2: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::assert_version(arg1);
        assert!(!arg0.paused, 13906835149301547018);
        assert!(0x2::tx_context::sender(arg8) == 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::owner(arg1), 13906835153596645388);
        assert!(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::is_kind(arg5), 13906835157891743758);
        assert!(arg6 >= 1 && arg6 <= 20, 13906835162186842128);
        let v0 = *0x1::vector::borrow<u64>(&arg0.prices, (arg5 as u64));
        assert!(v0 <= arg7, 13906835170776907794);
        let v1 = v0 * arg6;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v1, 13906835179366973460);
        let v2 = arg6 * arg0.charges_per_pack;
        let v3 = AbilityProceeds{dummy_field: false};
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::deposit<T0, AbilityProceeds>(arg2, arg3, v3, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg4), v1));
        let v4 = AbilityPacksBought{
            shop_id       : 0x2::object::id<AbilityShop<T0>>(arg0),
            book_id       : 0x2::object::id<0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityBook>(arg1),
            owner         : 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::owner(arg1),
            kind          : arg5,
            packs         : arg6,
            price         : v0,
            paid          : v1,
            charges_added : v2,
            charges       : 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::credit(arg1, arg5, v2),
        };
        0x2::event::emit<AbilityPacksBought>(v4);
    }

    public fun charges_per_pack<T0>(arg0: &AbilityShop<T0>) : u64 {
        arg0.charges_per_pack
    }

    public fun create_shop<T0>(arg0: &mut 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityRegistry, arg1: &AbilityAdminCap, arg2: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg3: vector<u64>, arg4: u64) : 0x2::object::ID {
        assert!(0x1::vector::length<u64>(&arg3) == 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::kind_count(), 13906834801409982486);
        let v0 = &arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            assert_price(*0x1::vector::borrow<u64>(v0, v1));
            v1 = v1 + 1;
        };
        assert_charges_per_pack(arg4);
        let v2 = ShopKey<T0>{dummy_field: false};
        let v3 = AbilityShop<T0>{
            id               : 0x2::derived_object::claim<ShopKey<T0>>(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::registry_uid_mut(arg0), v2),
            version          : 1,
            paused           : false,
            prices           : arg3,
            charges_per_pack : arg4,
        };
        let v4 = 0x2::object::id<AbilityShop<T0>>(&v3);
        let v5 = AbilityShopCreated{
            shop_id          : v4,
            prices           : arg3,
            charges_per_pack : arg4,
        };
        0x2::event::emit<AbilityShopCreated>(v5);
        0x2::transfer::share_object<AbilityShop<T0>>(v3);
        v4
    }

    fun emit_updated<T0>(arg0: &AbilityShop<T0>, arg1: vector<u8>) {
        let v0 = AbilityShopUpdated{
            shop_id : 0x2::object::id<AbilityShop<T0>>(arg0),
            group   : arg1,
        };
        0x2::event::emit<AbilityShopUpdated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AbilityAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AbilityAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &AbilityShop<T0>) : bool {
        arg0.paused
    }

    public fun max_charges_per_pack() : u64 {
        100
    }

    public fun max_packs() : u64 {
        20
    }

    public fun max_price() : u64 {
        1000000000000
    }

    public fun migrate<T0>(arg0: &mut AbilityShop<T0>, arg1: &AbilityAdminCap) {
        assert!(arg0.version < 1, 13906835033337298952);
        arg0.version = 1;
        emit_updated<T0>(arg0, b"version");
    }

    public fun min_packs() : u64 {
        1
    }

    public fun package_version() : u64 {
        1
    }

    public fun price<T0>(arg0: &AbilityShop<T0>, arg1: u8) : u64 {
        assert!(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::is_kind(arg1), 13906835295330697230);
        *0x1::vector::borrow<u64>(&arg0.prices, (arg1 as u64))
    }

    public fun prices<T0>(arg0: &AbilityShop<T0>) : vector<u64> {
        arg0.prices
    }

    public fun quote<T0>(arg0: &AbilityShop<T0>, arg1: u8, arg2: u64) : u64 {
        price<T0>(arg0, arg1) * arg2
    }

    public fun set_charges_per_pack<T0>(arg0: &mut AbilityShop<T0>, arg1: &AbilityAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_charges_per_pack(arg2);
        assert!(arg2 != arg0.charges_per_pack, 13906834998978740250);
        arg0.charges_per_pack = arg2;
        emit_updated<T0>(arg0, b"charges_per_pack");
    }

    public fun set_paused<T0>(arg0: &mut AbilityShop<T0>, arg1: &AbilityAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert!(arg2 != arg0.paused, 13906834887309590554);
        arg0.paused = arg2;
        emit_updated<T0>(arg0, b"paused");
    }

    public fun set_price<T0>(arg0: &mut AbilityShop<T0>, arg1: &AbilityAdminCap, arg2: u8, arg3: u64) {
        assert_version<T0>(arg0);
        assert!(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::is_kind(arg2), 13906834930258477070);
        assert_price(arg3);
        assert!(arg3 != *0x1::vector::borrow<u64>(&arg0.prices, (arg2 as u64)), 13906834938849198106);
        *0x1::vector::borrow_mut<u64>(&mut arg0.prices, (arg2 as u64)) = arg3;
        emit_updated<T0>(arg0, b"price");
    }

    public fun shop_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = ShopKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<ShopKey<T0>>(arg0, v0)
    }

    public fun version<T0>(arg0: &AbilityShop<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}


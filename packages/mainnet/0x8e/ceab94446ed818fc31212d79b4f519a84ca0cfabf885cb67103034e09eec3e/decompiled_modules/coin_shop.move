module 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::coin_shop {
    struct CoinShopKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinAbilityShop<phantom T0> has key {
        id: 0x2::object::UID,
        prices: vector<u64>,
        charges_per_pack: u64,
        treasury: address,
        paused: bool,
        version: u64,
    }

    struct CoinAbilityShopCreated has copy, drop {
        shop_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        prices: vector<u64>,
        charges_per_pack: u64,
        treasury: address,
    }

    struct CoinAbilityShopUpdated has copy, drop {
        shop_id: 0x2::object::ID,
        prices: vector<u64>,
        charges_per_pack: u64,
        treasury: address,
        paused: bool,
        version: u64,
    }

    struct AbilityPacksBoughtWithCoin has copy, drop {
        shop_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        owner: address,
        kind: u8,
        packs: u64,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        paid: u64,
        charges_added: u64,
        charges_after: u64,
    }

    fun assert_version<T0>(arg0: &CoinAbilityShop<T0>) {
        assert!(arg0.version == 1, 13906835561618079749);
    }

    fun assert_charges_per_pack(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 100, 13906835600274096153);
    }

    fun assert_prices(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::kind_count(), 13906835578799128599);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = 0x1::vector::borrow<u64>(arg0, v0);
            assert!(*v1 >= 1 && *v1 <= 1000000000000, 13906835583094226969);
            v0 = v0 + 1;
        };
    }

    public fun buy_with_coin<T0>(arg0: &CoinAbilityShop<T0>, arg1: &mut 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityBook, arg2: &mut 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::assert_version(arg1);
        assert!(!arg0.paused, 13906835243790893067);
        assert!(0x2::tx_context::sender(arg7) == 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::owner(arg1), 13906835248085991437);
        assert!(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::is_kind(arg3), 13906835252381089807);
        assert!(arg4 >= 1 && arg4 <= 20, 13906835256676188177);
        let v0 = *0x1::vector::borrow<u64>(&arg0.prices, (arg3 as u64));
        assert!(v0 <= arg5, 13906835265266253843);
        assert!(arg0.charges_per_pack >= arg6, 13906835278151942175);
        let v1 = v0 * arg4;
        assert!(0x2::coin::value<T0>(arg2) >= v1, 13906835286741221397);
        let v2 = arg4 * arg0.charges_per_pack;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v1, arg7), arg0.treasury);
        let v3 = AbilityPacksBoughtWithCoin{
            shop_id       : 0x2::object::id<CoinAbilityShop<T0>>(arg0),
            book_id       : 0x2::object::id<0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityBook>(arg1),
            owner         : 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::owner(arg1),
            kind          : arg3,
            packs         : arg4,
            coin_type     : 0x1::type_name::with_original_ids<T0>(),
            price         : v0,
            paid          : v1,
            charges_added : v2,
            charges_after : 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::credit(arg1, arg3, v2),
        };
        0x2::event::emit<AbilityPacksBoughtWithCoin>(v3);
    }

    public fun charges_per_pack<T0>(arg0: &CoinAbilityShop<T0>) : u64 {
        arg0.charges_per_pack
    }

    public fun coin_shop_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = CoinShopKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<CoinShopKey<T0>>(arg0, v0)
    }

    public fun create_coin_shop<T0>(arg0: &mut 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::AbilityRegistry, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap, arg2: vector<u64>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_prices(&arg2);
        assert_charges_per_pack(arg3);
        assert!(arg4 != @0x0, 13906834810000244763);
        let v0 = 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::registry_uid_mut(arg0);
        let v1 = CoinShopKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<CoinShopKey<T0>>(v0, v1), 13906834818588999689);
        let v2 = CoinShopKey<T0>{dummy_field: false};
        let v3 = CoinAbilityShop<T0>{
            id               : 0x2::derived_object::claim<CoinShopKey<T0>>(v0, v2),
            prices           : arg2,
            charges_per_pack : arg3,
            treasury         : arg4,
            paused           : false,
            version          : 1,
        };
        let v4 = CoinAbilityShopCreated{
            shop_id          : 0x2::object::id<CoinAbilityShop<T0>>(&v3),
            coin_type        : 0x1::type_name::with_original_ids<T0>(),
            prices           : arg2,
            charges_per_pack : arg3,
            treasury         : arg4,
        };
        0x2::event::emit<CoinAbilityShopCreated>(v4);
        0x2::transfer::share_object<CoinAbilityShop<T0>>(v3);
    }

    fun emit_updated<T0>(arg0: &CoinAbilityShop<T0>) {
        let v0 = CoinAbilityShopUpdated{
            shop_id          : 0x2::object::id<CoinAbilityShop<T0>>(arg0),
            prices           : arg0.prices,
            charges_per_pack : arg0.charges_per_pack,
            treasury         : arg0.treasury,
            paused           : arg0.paused,
            version          : arg0.version,
        };
        0x2::event::emit<CoinAbilityShopUpdated>(v0);
    }

    public fun is_paused<T0>(arg0: &CoinAbilityShop<T0>) : bool {
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

    public fun migrate_coin_shop<T0>(arg0: &mut CoinAbilityShop<T0>, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap) {
        assert!(arg0.version < 1, 13906835136416448519);
        arg0.version = 1;
        emit_updated<T0>(arg0);
    }

    public fun min_packs() : u64 {
        1
    }

    public fun package_version() : u64 {
        1
    }

    public fun price<T0>(arg0: &CoinAbilityShop<T0>, arg1: u8) : u64 {
        assert!(0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book::is_kind(arg1), 13906835406999912463);
        *0x1::vector::borrow<u64>(&arg0.prices, (arg1 as u64))
    }

    public fun prices<T0>(arg0: &CoinAbilityShop<T0>) : vector<u64> {
        arg0.prices
    }

    public fun quote<T0>(arg0: &CoinAbilityShop<T0>, arg1: u8, arg2: u64) : u64 {
        price<T0>(arg0, arg1) * arg2
    }

    public fun set_coin_charges_per_pack<T0>(arg0: &mut CoinAbilityShop<T0>, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_charges_per_pack(arg2);
        assert!(arg2 != arg0.charges_per_pack, 13906835007568871453);
        arg0.charges_per_pack = arg2;
        emit_updated<T0>(arg0);
    }

    public fun set_coin_paused<T0>(arg0: &mut CoinAbilityShop<T0>, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert!(arg2 != arg0.paused, 13906835102058151965);
        arg0.paused = arg2;
        emit_updated<T0>(arg0);
    }

    public fun set_coin_prices<T0>(arg0: &mut CoinAbilityShop<T0>, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap, arg2: vector<u64>) {
        assert_version<T0>(arg0);
        assert_prices(&arg2);
        assert!(arg2 != arg0.prices, 13906834947439329309);
        arg0.prices = arg2;
        emit_updated<T0>(arg0);
    }

    public fun set_coin_treasury<T0>(arg0: &mut CoinAbilityShop<T0>, arg1: &0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::shop::AbilityAdminCap, arg2: address) {
        assert_version<T0>(arg0);
        assert!(arg2 != @0x0, 13906835063403315227);
        assert!(arg2 != arg0.treasury, 13906835067698413597);
        arg0.treasury = arg2;
        emit_updated<T0>(arg0);
    }

    public fun treasury<T0>(arg0: &CoinAbilityShop<T0>) : address {
        arg0.treasury
    }

    public fun version<T0>(arg0: &CoinAbilityShop<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}


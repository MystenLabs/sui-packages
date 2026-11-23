module 0xbde9a7f13faff3edb02550da45c35fa85a18530bea5320287dc4e4971bda92d1::suimemes {
    struct SUIMEMES has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AssetInfo has copy, drop, store {
        name: 0x1::type_name::TypeName,
        decimals: u8,
        status: u8,
        active_after_ms: u64,
        window_start_ms: u64,
        window_base: u64,
        swap_used: u64,
        retire_base: u64,
        retired_at_ms: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<SUIMEMES>,
        assets: vector<AssetInfo>,
        reserves: 0x2::bag::Bag,
        amounts: vector<u64>,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        fee_recipient: address,
        paused: bool,
        busy: bool,
        swappers: 0x2::vec_set::VecSet<address>,
        total_ever_minted: u128,
        total_ever_redeemed: u128,
    }

    struct SeedRequest {
        shares: u64,
        deposited: vector<u64>,
        done: vector<bool>,
    }

    struct MintRequest {
        shares: u64,
        fee_shares: u64,
        required: vector<u64>,
        deposited: vector<bool>,
    }

    struct RedeemRequest {
        shares: u64,
        fee_shares: u64,
        payouts: vector<u64>,
        withdrawn: vector<bool>,
    }

    struct VersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapTicket {
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
    }

    struct Seeded has copy, drop {
        seeder: address,
        shares: u64,
        deposited: vector<u64>,
    }

    struct Minted has copy, drop {
        minter: address,
        shares: u64,
        fee_shares: u64,
        fee_recipient: address,
        deposited: vector<u64>,
    }

    struct Redeemed has copy, drop {
        redeemer: address,
        shares: u64,
        fee_shares: u64,
        fee_recipient: address,
        withdrawn: vector<u64>,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    struct CoinIconUpdated has copy, drop {
        icon_url: 0x1::string::String,
    }

    struct Swapped has copy, drop {
        swapper: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct AssetRegistered has copy, drop {
        name: 0x1::type_name::TypeName,
        decimals: u8,
        active_after_ms: u64,
    }

    struct AssetRetired has copy, drop {
        name: 0x1::type_name::TypeName,
    }

    struct AssetRemoved has copy, drop {
        name: 0x1::type_name::TypeName,
    }

    struct SwapperAdded has copy, drop {
        swapper: address,
    }

    struct SwapperRemoved has copy, drop {
        swapper: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        fee_recipient: address,
    }

    struct FeesUpdated has copy, drop {
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
    }

    struct PausedUpdated has copy, drop {
        paused: bool,
    }

    fun add_asset<T0>(arg0: &mut Vault, arg1: u8, arg2: u64) {
        assert!(arg1 <= 18, 9);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reserves, v0), 1);
        let v1 = AssetInfo{
            name            : v0,
            decimals        : arg1,
            status          : 0,
            active_after_ms : arg2,
            window_start_ms : 0,
            window_base     : 0,
            swap_used       : 0,
            retire_base     : 0,
            retired_at_ms   : 0,
        };
        0x1::vector::push_back<AssetInfo>(&mut arg0.assets, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, v0, 0x2::balance::zero<T0>());
        0x1::vector::push_back<u64>(&mut arg0.amounts, 0);
    }

    public fun add_swapper(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        check_version(arg1);
        assert!(!0x2::vec_set::contains<address>(&arg1.swappers, &arg2), 25);
        assert!(0x2::vec_set::length<address>(&arg1.swappers) < 50, 24);
        0x2::vec_set::insert<address>(&mut arg1.swappers, arg2);
        let v0 = SwapperAdded{swapper: arg2};
        0x2::event::emit<SwapperAdded>(v0);
    }

    public fun admin_swap_start<T0, T1>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapTicket) {
        check_version(arg1);
        start_swap<T0, T1>(arg1, arg2, arg3, arg4)
    }

    fun assert_all(arg0: &vector<bool>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(arg0)) {
            assert!(*0x1::vector::borrow<bool>(arg0, v0), 11);
            v0 = v0 + 1;
        };
    }

    fun assert_idle(arg0: &Vault) {
        assert!(!arg0.busy, 12);
    }

    public fun asset_active_after_ms(arg0: &Vault) : vector<u64> {
        let v0 = &arg0.assets;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<AssetInfo>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<AssetInfo>(v0, v2).active_after_ms);
            v2 = v2 + 1;
        };
        v1
    }

    public fun asset_decimals(arg0: &Vault) : vector<u8> {
        let v0 = &arg0.assets;
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<AssetInfo>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::borrow<AssetInfo>(v0, v2).decimals);
            v2 = v2 + 1;
        };
        v1
    }

    public fun asset_names(arg0: &Vault) : vector<0x1::type_name::TypeName> {
        let v0 = &arg0.assets;
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<AssetInfo>(v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::vector::borrow<AssetInfo>(v0, v2).name);
            v2 = v2 + 1;
        };
        v1
    }

    public fun asset_statuses(arg0: &Vault) : vector<u8> {
        let v0 = &arg0.assets;
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<AssetInfo>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::borrow<AssetInfo>(v0, v2).status);
            v2 = v2 + 1;
        };
        v1
    }

    fun available_swap(arg0: &Vault, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::borrow<AssetInfo>(&arg0.assets, arg1);
        if (v0.status == 1 && arg2 >= v0.retired_at_ms + 259200000) {
            return *0x1::vector::borrow<u64>(&arg0.amounts, arg1)
        };
        let v1 = window_used(v0, arg2);
        let v2 = if (window_open(v0, arg2)) {
            (v0.window_base as u128)
        } else {
            (*0x1::vector::borrow<u64>(&arg0.amounts, arg1) as u128)
        };
        let v3 = v2;
        if (v0.status == 1 && (v0.retire_base as u128) > v2) {
            v3 = (v0.retire_base as u128);
        };
        let v4 = v3 * (4000 as u128) / (10000 as u128);
        let v5 = if (v4 > (v1 as u128)) {
            v4 - (v1 as u128)
        } else {
            0
        };
        (0x1::u128::min(v5, (*0x1::vector::borrow<u64>(&arg0.amounts, arg1) as u128)) as u64)
    }

    fun begin_mint(arg0: &mut Vault, arg1: u64) : vector<u64> {
        assert_idle(arg0);
        assert!(!arg0.paused, 0);
        assert!(arg1 > 0, 6);
        let v0 = 0x2::coin::total_supply<SUIMEMES>(&arg0.treasury);
        assert!(v0 > 0, 19);
        arg0.busy = true;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<AssetInfo>(&arg0.assets)) {
            0x1::vector::push_back<u64>(&mut v1, proportional(*0x1::vector::borrow<u64>(&arg0.amounts, v2), arg1, v0, true));
            v2 = v2 + 1;
        };
        v1
    }

    fun begin_redeem(arg0: &mut Vault, arg1: 0x2::coin::Coin<SUIMEMES>) : vector<u64> {
        assert_idle(arg0);
        let v0 = 0x2::coin::value<SUIMEMES>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = 0x2::coin::total_supply<SUIMEMES>(&arg0.treasury);
        let v2 = v1 - v0;
        assert!(v2 == 0 || v2 >= 1000000, 7);
        0x2::coin::burn<SUIMEMES>(&mut arg0.treasury, arg1);
        arg0.total_ever_redeemed = arg0.total_ever_redeemed + (v0 as u128);
        let v3 = &mut arg0.assets;
        let v4 = 0;
        while (v4 < 0x1::vector::length<AssetInfo>(v3)) {
            let v5 = 0x1::vector::borrow_mut<AssetInfo>(v3, v4);
            v5.window_base = proportional(v5.window_base, v2, v1, false);
            v5.retire_base = proportional(v5.retire_base, v2, v1, false);
            v5.swap_used = proportional(v5.swap_used, v2, v1, true);
            v4 = v4 + 1;
        };
        arg0.busy = true;
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<AssetInfo>(&arg0.assets)) {
            0x1::vector::push_back<u64>(&mut v6, proportional(*0x1::vector::borrow<u64>(&arg0.amounts, v7), v0, v1, false));
            v7 = v7 + 1;
        };
        v6
    }

    fun check_version(arg0: &Vault) {
        assert!(vault_version(arg0) <= 1, 27);
    }

    fun fee_of(arg0: u64, arg1: u64) : u64 {
        let v0 = (10000 as u128);
        ((((arg1 as u128) * (arg0 as u128) + v0 - 1) / v0) as u64)
    }

    public fun fee_recipient(arg0: &Vault) : address {
        arg0.fee_recipient
    }

    public fun finish_mint(arg0: &mut Vault, arg1: MintRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIMEMES> {
        let MintRequest {
            shares     : v0,
            fee_shares : v1,
            required   : v2,
            deposited  : v3,
        } = arg1;
        let v4 = v3;
        assert_all(&v4);
        let v5 = mint_shares(arg0, v0, arg2);
        if (v1 > 0) {
            let v6 = mint_shares(arg0, v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIMEMES>>(v6, arg0.fee_recipient);
        };
        arg0.busy = false;
        let v7 = Minted{
            minter        : 0x2::tx_context::sender(arg2),
            shares        : v0,
            fee_shares    : v1,
            fee_recipient : arg0.fee_recipient,
            deposited     : v2,
        };
        0x2::event::emit<Minted>(v7);
        v5
    }

    public fun finish_redeem(arg0: &mut Vault, arg1: RedeemRequest, arg2: &0x2::tx_context::TxContext) {
        let RedeemRequest {
            shares     : v0,
            fee_shares : v1,
            payouts    : v2,
            withdrawn  : v3,
        } = arg1;
        let v4 = v3;
        assert_all(&v4);
        arg0.busy = false;
        let v5 = Redeemed{
            redeemer      : 0x2::tx_context::sender(arg2),
            shares        : v0,
            fee_shares    : v1,
            fee_recipient : arg0.fee_recipient,
            withdrawn     : v2,
        };
        0x2::event::emit<Redeemed>(v5);
    }

    public fun finish_seed(arg0: &mut Vault, arg1: SeedRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIMEMES> {
        let SeedRequest {
            shares    : v0,
            deposited : v1,
            done      : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        assert_all(&v3);
        let v5 = false;
        let v6 = &v4;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v6)) {
            let v8 = 0x1::vector::borrow<u64>(v6, v7);
            let v9 = v5 || *v8 > 0;
            v5 = v9;
            v7 = v7 + 1;
        };
        assert!(v5, 23);
        arg0.total_ever_minted = arg0.total_ever_minted + (v0 as u128);
        arg0.busy = false;
        let v10 = Seeded{
            seeder    : 0x2::tx_context::sender(arg2),
            shares    : v0,
            deposited : v4,
        };
        0x2::event::emit<Seeded>(v10);
        0x2::coin::mint<SUIMEMES>(&mut arg0.treasury, v0, arg2)
    }

    fun index_of<T0>(arg0: &Vault) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetInfo>(&arg0.assets)) {
            if (0x1::vector::borrow<AssetInfo>(&arg0.assets, v0).name == 0x1::type_name::with_defining_ids<T0>()) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun init(arg0: SUIMEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEMES>(arg0, 9, b"suiMemes", b"Sui Memes", b"Nami Fund DTF: a basket of popular memecoins on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nami.fund/suiMemes.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEMES>>(v1);
        let v2 = Vault{
            id                  : 0x2::object::new(arg1),
            treasury            : v0,
            assets              : 0x1::vector::empty<AssetInfo>(),
            reserves            : 0x2::bag::new(arg1),
            amounts             : vector[],
            mint_fee_bps        : 70,
            redeem_fee_bps      : 70,
            fee_recipient       : @0x3ff32680edc74b4e894aa6d1dcaf1fc97bb4274a1bdc8428361f51aef4357957,
            paused              : false,
            busy                : false,
            swappers            : 0x2::vec_set::empty<address>(),
            total_ever_minted   : 0,
            total_ever_redeemed : 0,
        };
        0x2::transfer::share_object<Vault>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun is_swapper(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.swappers, &arg1)
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Vault) {
        let v0 = vault_version(arg1);
        assert!(v0 < 1, 28);
        let v1 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<VersionKey>(&arg1.id, v1)) {
            let v2 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<VersionKey, u64>(&mut arg1.id, v2) = 1;
        } else {
            let v3 = VersionKey{dummy_field: false};
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg1.id, v3, 1);
        };
        let v4 = Migrated{
            from_version : v0,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v4);
    }

    public fun mint_deposit<T0>(arg0: &mut Vault, arg1: &mut MintRequest, arg2: &mut 0x2::coin::Coin<T0>) {
        let v0 = index_of<T0>(arg0);
        assert!(!*0x1::vector::borrow<bool>(&arg1.deposited, v0), 5);
        *0x1::vector::borrow_mut<bool>(&mut arg1.deposited, v0) = true;
        let v1 = *0x1::vector::borrow<u64>(&arg1.required, v0);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 4);
        reserve_join<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), v1));
    }

    public fun mint_fee_bps(arg0: &Vault) : u64 {
        arg0.mint_fee_bps
    }

    public fun mint_fee_shares(arg0: &MintRequest) : u64 {
        arg0.fee_shares
    }

    public fun mint_required(arg0: &MintRequest) : vector<u64> {
        arg0.required
    }

    fun mint_shares(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIMEMES> {
        arg0.total_ever_minted = arg0.total_ever_minted + (arg1 as u128);
        0x2::coin::mint<SUIMEMES>(&mut arg0.treasury, arg1, arg2)
    }

    public fun package_version() : u64 {
        1
    }

    fun proportional(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = v0 / v1;
        let v3 = v2;
        if (arg3 && v0 % v1 != 0) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 18446744073709551615, 4);
        (v3 as u64)
    }

    public fun redeem_fee_bps(arg0: &Vault) : u64 {
        arg0.redeem_fee_bps
    }

    public fun redeem_fee_shares(arg0: &RedeemRequest) : u64 {
        arg0.fee_shares
    }

    public fun redeem_payouts(arg0: &RedeemRequest) : vector<u64> {
        arg0.payouts
    }

    public fun redeem_withdraw<T0>(arg0: &mut Vault, arg1: &mut RedeemRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = index_of<T0>(arg0);
        assert!(!*0x1::vector::borrow<bool>(&arg1.withdrawn, v0), 5);
        *0x1::vector::borrow_mut<bool>(&mut arg1.withdrawn, v0) = true;
        0x2::coin::from_balance<T0>(reserve_split<T0>(arg0, *0x1::vector::borrow<u64>(&arg1.payouts, v0)), arg2)
    }

    public fun register_asset<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u8, arg3: &0x2::clock::Clock) {
        check_version(arg1);
        assert_idle(arg1);
        assert!(0x1::vector::length<AssetInfo>(&arg1.assets) < 100, 3);
        let v0 = if (0x2::coin::total_supply<SUIMEMES>(&arg1.treasury) == 0) {
            0x2::clock::timestamp_ms(arg3)
        } else {
            0x2::clock::timestamp_ms(arg3) + 86400000
        };
        add_asset<T0>(arg1, arg2, v0);
        let v1 = AssetRegistered{
            name            : 0x1::type_name::with_defining_ids<T0>(),
            decimals        : arg2,
            active_after_ms : v0,
        };
        0x2::event::emit<AssetRegistered>(v1);
    }

    public fun remove_asset<T0>(arg0: &AdminCap, arg1: &mut Vault) {
        check_version(arg1);
        assert_idle(arg1);
        let v0 = index_of<T0>(arg1);
        assert!(0x1::vector::borrow<AssetInfo>(&arg1.assets, v0).status == 1, 14);
        assert!(*0x1::vector::borrow<u64>(&arg1.amounts, v0) == 0, 15);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.reserves, v1));
        0x1::vector::remove<AssetInfo>(&mut arg1.assets, v0);
        0x1::vector::remove<u64>(&mut arg1.amounts, v0);
        let v2 = AssetRemoved{name: v1};
        0x2::event::emit<AssetRemoved>(v2);
    }

    public fun remove_swapper(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        check_version(arg1);
        assert!(0x2::vec_set::contains<address>(&arg1.swappers, &arg2), 21);
        0x2::vec_set::remove<address>(&mut arg1.swappers, &arg2);
        let v0 = SwapperRemoved{swapper: arg2};
        0x2::event::emit<SwapperRemoved>(v0);
    }

    fun reserve_join<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = index_of<T0>(arg0);
        *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0) = *0x1::vector::borrow<u64>(&arg0.amounts, v0) + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T0>()), arg1);
    }

    fun reserve_split<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = index_of<T0>(arg0);
        *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v0) = *0x1::vector::borrow<u64>(&arg0.amounts, v0) - arg1;
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun reserves(arg0: &Vault) : vector<u64> {
        arg0.amounts
    }

    public fun retire_asset<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock) {
        check_version(arg1);
        assert_idle(arg1);
        let v0 = index_of<T0>(arg1);
        assert!(0x1::vector::borrow<AssetInfo>(&arg1.assets, v0).status == 0, 13);
        let v1 = 0;
        let v2 = &arg1.assets;
        let v3 = 0;
        while (v3 < 0x1::vector::length<AssetInfo>(v2)) {
            if (0x1::vector::borrow<AssetInfo>(v2, v3).status == 0) {
                v1 = v1 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v1 > 1, 17);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0x1::vector::borrow_mut<AssetInfo>(&mut arg1.assets, v0);
        v5.status = 1;
        v5.retire_base = *0x1::vector::borrow<u64>(&arg1.amounts, v0) + window_used(0x1::vector::borrow<AssetInfo>(&arg1.assets, v0), v4);
        v5.retired_at_ms = v4;
        let v6 = AssetRetired{name: v5.name};
        0x2::event::emit<AssetRetired>(v6);
    }

    public fun seed_deposit<T0>(arg0: &mut Vault, arg1: &mut SeedRequest, arg2: 0x2::coin::Coin<T0>) {
        let v0 = index_of<T0>(arg0);
        assert!(!*0x1::vector::borrow<bool>(&arg1.done, v0), 5);
        *0x1::vector::borrow_mut<bool>(&mut arg1.done, v0) = true;
        *0x1::vector::borrow_mut<u64>(&mut arg1.deposited, v0) = 0x2::coin::value<T0>(&arg2);
        reserve_join<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    fun send_fee<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0);
        };
    }

    public fun set_coin_icon_url(arg0: &AdminCap, arg1: &mut Vault, arg2: &mut 0x2::coin_registry::Currency<SUIMEMES>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = MetadataCapKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<MetadataCapKey>(&arg1.id, v0)) {
            let v1 = MetadataCapKey{dummy_field: false};
            0x2::dynamic_object_field::add<MetadataCapKey, 0x2::coin_registry::MetadataCap<SUIMEMES>>(&mut arg1.id, v1, 0x2::coin_registry::claim_metadata_cap<SUIMEMES>(arg2, &arg1.treasury, arg4));
        };
        let v2 = MetadataCapKey{dummy_field: false};
        0x2::coin_registry::set_icon_url<SUIMEMES>(arg2, 0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<SUIMEMES>>(&arg1.id, v2), arg3);
        let v3 = CoinIconUpdated{icon_url: arg3};
        0x2::event::emit<CoinIconUpdated>(v3);
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        check_version(arg1);
        assert!(arg2 != @0x0, 18);
        arg1.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{fee_recipient: arg2};
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun set_mint_fee_bps(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        check_version(arg1);
        assert!(arg2 <= 100, 10);
        arg1.mint_fee_bps = arg2;
        let v0 = FeesUpdated{
            mint_fee_bps   : arg1.mint_fee_bps,
            redeem_fee_bps : arg1.redeem_fee_bps,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Vault, arg2: bool) {
        check_version(arg1);
        arg1.paused = arg2;
        let v0 = PausedUpdated{paused: arg2};
        0x2::event::emit<PausedUpdated>(v0);
    }

    public fun set_redeem_fee_bps(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        check_version(arg1);
        assert!(arg2 <= 100, 10);
        arg1.redeem_fee_bps = arg2;
        let v0 = FeesUpdated{
            mint_fee_bps   : arg1.mint_fee_bps,
            redeem_fee_bps : arg1.redeem_fee_bps,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun start_mint(arg0: &mut Vault, arg1: u64) : MintRequest {
        check_version(arg0);
        let v0 = fee_of(arg0.mint_fee_bps, arg1);
        let v1 = begin_mint(arg0, arg1 + v0);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<bool>(&mut v2, false);
            v3 = v3 + 1;
        };
        MintRequest{
            shares     : arg1,
            fee_shares : v0,
            required   : v1,
            deposited  : v2,
        }
    }

    public fun start_redeem(arg0: &mut Vault, arg1: 0x2::coin::Coin<SUIMEMES>, arg2: &mut 0x2::tx_context::TxContext) : RedeemRequest {
        check_version(arg0);
        assert_idle(arg0);
        let v0 = 0x2::coin::value<SUIMEMES>(&arg1);
        let v1 = fee_of(arg0.redeem_fee_bps, v0);
        assert!(v0 > v1, 6);
        send_fee<SUIMEMES>(arg0.fee_recipient, 0x2::coin::split<SUIMEMES>(&mut arg1, v1, arg2));
        let v2 = begin_redeem(arg0, arg1);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v2)) {
            0x1::vector::push_back<bool>(&mut v3, false);
            v4 = v4 + 1;
        };
        RedeemRequest{
            shares     : v0,
            fee_shares : v1,
            payouts    : v2,
            withdrawn  : v3,
        }
    }

    public fun start_seed(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) : SeedRequest {
        check_version(arg1);
        assert_idle(arg1);
        assert!(0x2::coin::total_supply<SUIMEMES>(&arg1.treasury) == 0, 20);
        let v0 = 0x1::vector::length<AssetInfo>(&arg1.assets);
        assert!(v0 > 0, 26);
        assert!(arg2 >= 1000000000, 8);
        arg1.busy = true;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v0) {
            0x1::vector::push_back<bool>(&mut v3, false);
            v4 = v4 + 1;
        };
        SeedRequest{
            shares    : arg2,
            deposited : v1,
            done      : v3,
        }
    }

    fun start_swap<T0, T1>(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapTicket) {
        assert_idle(arg0);
        assert!(arg1 > 0, 16);
        let v0 = index_of<T0>(arg0);
        let v1 = index_of<T1>(arg0);
        assert!(v0 != v1, 16);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x1::vector::borrow<AssetInfo>(&arg0.assets, v1);
        assert!(v3.status == 0 && v2 >= v3.active_after_ms, 13);
        assert!(arg1 <= available_swap(arg0, v0, v2), 22);
        let v4 = 0x1::vector::borrow_mut<AssetInfo>(&mut arg0.assets, v0);
        if (!window_open(v4, v2)) {
            v4.window_start_ms = v2;
            v4.window_base = *0x1::vector::borrow<u64>(&arg0.amounts, v0);
            v4.swap_used = 0;
        };
        v4.swap_used = v4.swap_used + arg1;
        arg0.busy = true;
        let v5 = SwapTicket{
            coin_in   : 0x1::type_name::with_defining_ids<T0>(),
            coin_out  : 0x1::type_name::with_defining_ids<T1>(),
            amount_in : arg1,
        };
        (0x2::coin::from_balance<T0>(reserve_split<T0>(arg0, arg1), arg3), v5)
    }

    public fun swap_available(arg0: &Vault, arg1: &0x2::clock::Clock) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<AssetInfo>(&arg0.assets)) {
            0x1::vector::push_back<u64>(&mut v0, available_swap(arg0, v1, 0x2::clock::timestamp_ms(arg1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun swap_finish<T0, T1>(arg0: &mut Vault, arg1: SwapTicket, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        let SwapTicket {
            coin_in   : v0,
            coin_out  : v1,
            amount_in : v2,
        } = arg1;
        assert!(v0 == 0x1::type_name::with_defining_ids<T0>() && v1 == 0x1::type_name::with_defining_ids<T1>(), 16);
        let v3 = 0x2::coin::value<T1>(&arg2);
        assert!(v3 > 0, 16);
        reserve_join<T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
        arg0.busy = false;
        let v4 = Swapped{
            swapper    : 0x2::tx_context::sender(arg3),
            coin_in    : v0,
            coin_out   : v1,
            amount_in  : v2,
            amount_out : v3,
        };
        0x2::event::emit<Swapped>(v4);
    }

    public fun swap_start<T0, T1>(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapTicket) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.swappers, &v0), 21);
        start_swap<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swappers(arg0: &Vault) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.swappers)
    }

    public fun total_current_supply(arg0: &Vault) : u64 {
        0x2::coin::total_supply<SUIMEMES>(&arg0.treasury)
    }

    public fun total_ever_minted(arg0: &Vault) : u128 {
        arg0.total_ever_minted
    }

    public fun total_ever_redeemed(arg0: &Vault) : u128 {
        arg0.total_ever_redeemed
    }

    public fun vault_version(arg0: &Vault) : u64 {
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<VersionKey>(&arg0.id, v0)) {
            let v2 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<VersionKey, u64>(&arg0.id, v2)
        } else {
            1
        }
    }

    fun window_open(arg0: &AssetInfo, arg1: u64) : bool {
        arg0.swap_used > 0 && arg1 < arg0.window_start_ms + 86400000
    }

    fun window_used(arg0: &AssetInfo, arg1: u64) : u64 {
        if (window_open(arg0, arg1)) {
            arg0.swap_used
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}


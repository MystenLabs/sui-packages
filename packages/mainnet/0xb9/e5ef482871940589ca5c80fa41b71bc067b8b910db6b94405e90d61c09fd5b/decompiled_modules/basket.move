module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket {
    struct BasketLeg has copy, drop, store {
        asset: 0x1::type_name::TypeName,
        units_per_share: u64,
    }

    struct OwnerFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ForfeitedKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BasketVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        recipe: vector<BasketLeg>,
        total_shares: u64,
        seed_shares: u64,
        deposit_cap: u64,
        creator: address,
        seeded: bool,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        protocol_recipient: address,
        issue_per_hour: u64,
        issue_left: u64,
        issue_at: u64,
        redeem_hour_bps: u64,
        redeem_left: u64,
        redeem_at: u64,
        excluded: vector<bool>,
        reported_at: vector<u64>,
        open_redeems: u64,
    }

    struct MintReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        shares: u64,
        deposited: vector<bool>,
        seed: bool,
    }

    struct RedeemReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        shares: u64,
        supply_before: u64,
        withdrawn: vector<bool>,
    }

    struct BasketCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        basket_type: 0x1::type_name::TypeName,
        creator: address,
        seed_shares: u64,
        deposit_cap: u64,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
    }

    struct BasketMintEvent has copy, drop {
        vault_id: 0x2::object::ID,
        shares: u64,
        minter: address,
    }

    struct BasketRedeemEvent has copy, drop {
        vault_id: 0x2::object::ID,
        shares: u64,
        redeemer: address,
    }

    public fun accrete<T0, T1>(arg0: &mut BasketVault<T0>) {
        assert_settled<T0>(arg0);
        let v0 = ForfeitedKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<ForfeitedKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::remove<ForfeitedKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
            if (0x2::balance::value<T1>(&v1) > 0) {
                join_component<T0, T1>(arg0, v1);
                return
            };
            0x2::balance::destroy_zero<T1>(v1);
        };
        let v2 = OwnerFeeKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v2), 1);
        let v3 = 0x2::dynamic_field::remove<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v2);
        assert!(0x2::balance::value<T1>(&v3) > 0, 1);
        join_component<T0, T1>(arg0, v3);
    }

    fun add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 12);
        (v0 as u64)
    }

    fun all_set(arg0: &vector<bool>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(arg0)) {
            if (!*0x1::vector::borrow<bool>(arg0, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun assert_settled<T0>(arg0: &BasketVault<T0>) {
        assert!(arg0.open_redeems == 0, 23);
    }

    fun bucket_value<T0, T1: copy + drop + store, T2>(arg0: &BasketVault<T0>, arg1: T1) : u64 {
        if (!0x2::dynamic_field::exists_with_type<T1, 0x2::balance::Balance<T2>>(&arg0.id, arg1)) {
            return 0
        };
        0x2::balance::value<T2>(0x2::dynamic_field::borrow<T1, 0x2::balance::Balance<T2>>(&arg0.id, arg1))
    }

    fun ceil_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = ((arg0 as u128) * (arg1 as u128) + 9999) / 10000;
        assert!(v0 <= 18446744073709551615, 12);
        (v0 as u64)
    }

    fun complete_seed<T0>(arg0: BasketVault<T0>, arg1: MintReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) : (BasketVault<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.seed, 15);
        consume_mint_receipt<T0>(&arg0, arg1);
        let v0 = arg0.seed_shares;
        arg0.total_shares = v0;
        arg0.seeded = true;
        let v1 = BasketCreatedEvent{
            vault_id       : 0x2::object::id<BasketVault<T0>>(&arg0),
            basket_type    : 0x1::type_name::with_defining_ids<T0>(),
            creator        : arg0.creator,
            seed_shares    : arg0.seed_shares,
            deposit_cap    : arg0.deposit_cap,
            mint_fee_bps   : arg0.mint_fee_bps,
            redeem_fee_bps : arg0.redeem_fee_bps,
        };
        0x2::event::emit<BasketCreatedEvent>(v1);
        (arg0, 0x2::coin::mint<T0>(&mut arg0.treasury, v0, arg2))
    }

    public fun component_value<T0, T1>(arg0: &BasketVault<T0>) : u64 {
        bucket_value<T0, 0x1::type_name::TypeName, T1>(arg0, 0x1::type_name::with_defining_ids<T1>())
    }

    public fun confirm_failure<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_settled<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 18);
        let v0 = leg_index<T1>(&arg0.recipe);
        let v1 = *0x1::vector::borrow<u64>(&arg0.reported_at, v0);
        assert!(v1 > 0, 22);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1 + 86400000, 22);
        *0x1::vector::borrow_mut<bool>(&mut arg0.excluded, v0) = true;
    }

    fun consume_mint_receipt<T0>(arg0: &BasketVault<T0>, arg1: MintReceipt<T0>) {
        assert!(0x2::object::id<BasketVault<T0>>(arg0) == arg1.vault_id, 5);
        assert!(all_set(&arg1.deposited), 8);
        let MintReceipt {
            vault_id  : _,
            shares    : _,
            deposited : _,
            seed      : _,
        } = arg1;
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<BasketLeg>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : (BasketVault<T0>, MintReceipt<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 13);
        assert!(arg2 > 0, 1);
        assert!(arg3 >= arg2, 4);
        assert!(arg4 <= 100 && arg5 <= 100, 16);
        validate_recipe(&arg1);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<BasketLeg>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, false);
            0x1::vector::push_back<bool>(&mut v1, false);
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = issue_cap(arg3);
        let v5 = 0x2::object::new(arg7);
        let v6 = BasketVault<T0>{
            id                 : v5,
            treasury           : arg0,
            recipe             : arg1,
            total_shares       : 0,
            seed_shares        : arg2,
            deposit_cap        : arg3,
            creator            : 0x2::tx_context::sender(arg7),
            seeded             : false,
            mint_fee_bps       : arg4,
            redeem_fee_bps     : arg5,
            protocol_recipient : 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::platform_wallet(),
            issue_per_hour     : v4,
            issue_left         : v4,
            issue_at           : 0,
            redeem_hour_bps    : 10000,
            redeem_left        : 0,
            redeem_at          : 0,
            excluded           : v1,
            reported_at        : v2,
            open_redeems       : 0,
        };
        let v7 = MintReceipt<T0>{
            vault_id  : 0x2::object::uid_to_inner(&v5),
            shares    : arg2,
            deposited : v0,
            seed      : true,
        };
        (v6, v7)
    }

    public fun deposit<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut MintReceipt<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_settled<T0>(arg0);
        assert!(0x2::object::id<BasketVault<T0>>(arg0) == arg1.vault_id, 5);
        let v0 = leg_index<T1>(&arg0.recipe);
        assert!(!*0x1::vector::borrow<bool>(&arg0.excluded, v0), 20);
        assert!(!*0x1::vector::borrow<bool>(&arg1.deposited, v0), 7);
        let v1 = mul(0x1::vector::borrow<BasketLeg>(&arg0.recipe, v0).units_per_share, arg1.shares);
        let v2 = ceil_bps(v1, arg0.mint_fee_bps);
        let v3 = ceil_bps(v1, 35);
        assert!(0x2::coin::value<T1>(&arg2) >= add_u64(add_u64(v1, v2), v3), 9);
        join_component<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v1, arg3)));
        if (v2 > 0) {
            join_owner_fee<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2, arg3)));
        };
        if (v3 > 0) {
            join_protocol_fee<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg3)));
        };
        *0x1::vector::borrow_mut<bool>(&mut arg1.deposited, v0) = true;
        arg2
    }

    public fun deposit_cap<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.deposit_cap
    }

    public fun exclude<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_settled<T0>(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 18);
        *0x1::vector::borrow_mut<bool>(&mut arg0.excluded, leg_index<T1>(&arg0.recipe)) = true;
    }

    public fun finish_mint<T0>(arg0: &mut BasketVault<T0>, arg1: MintReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg1.seed, 11);
        let v0 = arg1.shares;
        consume_mint_receipt<T0>(arg0, arg1);
        let v1 = add_u64(arg0.total_shares, v0);
        assert!(v1 <= arg0.deposit_cap, 4);
        arg0.total_shares = v1;
        let v2 = BasketMintEvent{
            vault_id : 0x2::object::id<BasketVault<T0>>(arg0),
            shares   : v0,
            minter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BasketMintEvent>(v2);
        0x2::coin::mint<T0>(&mut arg0.treasury, v0, arg2)
    }

    public fun finish_redeem<T0>(arg0: &mut BasketVault<T0>, arg1: RedeemReceipt<T0>) {
        assert!(0x2::object::id<BasketVault<T0>>(arg0) == arg1.vault_id, 5);
        assert!(all_set(&arg1.withdrawn), 8);
        assert!(arg0.open_redeems > 0, 23);
        arg0.open_redeems = arg0.open_redeems - 1;
        let RedeemReceipt {
            vault_id      : _,
            shares        : _,
            supply_before : _,
            withdrawn     : _,
        } = arg1;
    }

    public fun finish_seed<T0>(arg0: BasketVault<T0>, arg1: MintReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_seed<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<BasketVault<T0>>(v0);
    }

    public fun finish_seed_with_quote<T0>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: BasketVault<T0>, arg2: MintReceipt<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_seed<T0>(arg1, arg2, arg4);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::add_instant_virtual_quote_once<T0>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<BasketVault<T0>>(v0);
    }

    fun floor_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun forfeit<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut RedeemReceipt<T0>) {
        assert!(0x2::object::id<BasketVault<T0>>(arg0) == arg1.vault_id, 5);
        let v0 = leg_index<T1>(&arg0.recipe);
        assert!(!*0x1::vector::borrow<bool>(&arg1.withdrawn, v0), 7);
        assert!(*0x1::vector::borrow<bool>(&arg0.excluded, v0), 21);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T1>());
        let v2 = 0x2::balance::split<T1>(v1, mul_div_floor(0x2::balance::value<T1>(v1), arg1.shares, arg1.supply_before));
        if (0x2::balance::value<T1>(&v2) > 0) {
            join_forfeited<T0, T1>(arg0, v2);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        *0x1::vector::borrow_mut<bool>(&mut arg1.withdrawn, v0) = true;
    }

    public fun forfeited_value<T0, T1>(arg0: &BasketVault<T0>) : u64 {
        let v0 = ForfeitedKey<T1>{dummy_field: false};
        bucket_value<T0, ForfeitedKey<T1>, T1>(arg0, v0)
    }

    public fun is_excluded<T0, T1>(arg0: &BasketVault<T0>) : bool {
        *0x1::vector::borrow<bool>(&arg0.excluded, leg_index<T1>(&arg0.recipe))
    }

    fun issue_cap(arg0: u64) : u64 {
        let v0 = arg0 / 10;
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun issue_per_hour<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.issue_per_hour
    }

    fun join_component<T0, T1>(arg0: &mut BasketVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::balance::zero<T1>());
        };
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v0), arg1);
    }

    fun join_forfeited<T0, T1>(arg0: &mut BasketVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = ForfeitedKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<ForfeitedKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<ForfeitedKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::balance::zero<T1>());
        };
        let v1 = ForfeitedKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<ForfeitedKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v1), arg1);
    }

    fun join_owner_fee<T0, T1>(arg0: &mut BasketVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = OwnerFeeKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::balance::zero<T1>());
        };
        let v1 = OwnerFeeKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v1), arg1);
    }

    fun join_protocol_fee<T0, T1>(arg0: &mut BasketVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = ProtocolFeeKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<ProtocolFeeKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<ProtocolFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::balance::zero<T1>());
        };
        let v1 = ProtocolFeeKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v1), arg1);
    }

    public fun leg_count<T0>(arg0: &BasketVault<T0>) : u64 {
        0x1::vector::length<BasketLeg>(&arg0.recipe)
    }

    fun leg_index<T0>(arg0: &vector<BasketLeg>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BasketLeg>(arg0)) {
            if (0x1::vector::borrow<BasketLeg>(arg0, v0).asset == 0x1::type_name::with_defining_ids<T0>()) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun max_owner_fee_bps() : u64 {
        100
    }

    public fun mint_fee_bps<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.mint_fee_bps
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 12);
        (v0 as u64)
    }

    fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_leg(arg0: 0x1::type_name::TypeName, arg1: u64) : BasketLeg {
        BasketLeg{
            asset           : arg0,
            units_per_share : arg1,
        }
    }

    public fun owner_fee_value<T0, T1>(arg0: &BasketVault<T0>) : u64 {
        let v0 = OwnerFeeKey<T1>{dummy_field: false};
        bucket_value<T0, OwnerFeeKey<T1>, T1>(arg0, v0)
    }

    public fun protocol_fee_value<T0, T1>(arg0: &BasketVault<T0>) : u64 {
        let v0 = ProtocolFeeKey<T1>{dummy_field: false};
        bucket_value<T0, ProtocolFeeKey<T1>, T1>(arg0, v0)
    }

    public fun protocol_mint_bps() : u64 {
        35
    }

    public fun protocol_recipient<T0>(arg0: &BasketVault<T0>) : address {
        arg0.protocol_recipient
    }

    public fun protocol_redeem_bps() : u64 {
        20
    }

    public fun receipt_shares<T0>(arg0: &MintReceipt<T0>) : u64 {
        arg0.shares
    }

    fun redeem_allowance<T0>(arg0: &BasketVault<T0>) : u64 {
        let v0 = arg0.total_shares;
        if (v0 == 0) {
            return 1
        };
        let v1 = mul_div_floor(v0, 1000, 10000);
        let v2 = v1;
        if (v1 == 0) {
            v2 = 1;
        };
        let v3 = mul_div_floor(v0, arg0.redeem_hour_bps, 10000);
        if (v3 > v2) {
            v3
        } else {
            v2
        }
    }

    public fun redeem_fee_bps<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.redeem_fee_bps
    }

    fun refill(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg3 == 0) {
            return (0, arg2)
        };
        if (arg1 == 0) {
            let v0 = if (arg2 == 0) {
                1
            } else {
                arg2
            };
            return (arg3, v0)
        };
        if (arg2 <= arg1) {
            return (arg0, arg1)
        };
        let v1 = arg2 - arg1;
        if (v1 >= 3600000) {
            return (arg3, arg2)
        };
        let v2 = add_u64(arg0, (((arg3 as u128) * (v1 as u128) / (3600000 as u128)) as u64));
        let v3 = v2;
        if (v2 > arg3) {
            v3 = arg3;
        };
        (v3, arg2)
    }

    public fun report_failure<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_settled<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 18);
        let v0 = leg_index<T1>(&arg0.recipe);
        assert!(!*0x1::vector::borrow<bool>(&arg0.excluded, v0), 20);
        if (*0x1::vector::borrow<u64>(&arg0.reported_at, v0) == 0) {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            let v2 = v1;
            if (v1 == 0) {
                v2 = 1;
            };
            *0x1::vector::borrow_mut<u64>(&mut arg0.reported_at, v0) = v2;
        };
    }

    public fun restore<T0, T1>(arg0: &mut BasketVault<T0>) {
        assert_settled<T0>(arg0);
        let v0 = leg_index<T1>(&arg0.recipe);
        *0x1::vector::borrow_mut<bool>(&mut arg0.excluded, v0) = false;
        *0x1::vector::borrow_mut<u64>(&mut arg0.reported_at, v0) = 0;
    }

    public fun return_asset<T0, T1>(arg0: &mut BasketVault<T0>, arg1: 0x2::coin::Coin<T1>) {
        assert_settled<T0>(arg0);
        leg_index<T1>(&arg0.recipe);
        join_forfeited<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun seed_shares<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.seed_shares
    }

    public fun start_mint<T0>(arg0: &mut BasketVault<T0>, arg1: u64, arg2: &0x2::clock::Clock) : MintReceipt<T0> {
        assert_settled<T0>(arg0);
        assert!(arg0.seeded, 14);
        assert!(arg1 > 0, 1);
        assert!(add_u64(arg0.total_shares, arg1) <= arg0.deposit_cap, 4);
        take_issue<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<BasketLeg>(&arg0.recipe)) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        MintReceipt<T0>{
            vault_id  : 0x2::object::id<BasketVault<T0>>(arg0),
            shares    : arg1,
            deposited : v0,
            seed      : false,
        }
    }

    public fun start_redeem<T0>(arg0: &mut BasketVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : RedeemReceipt<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 <= arg0.total_shares, 4);
        take_redeem<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
        arg0.open_redeems = arg0.open_redeems + 1;
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        arg0.total_shares = arg0.total_shares - v0;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<BasketLeg>(&arg0.recipe)) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = BasketRedeemEvent{
            vault_id : 0x2::object::id<BasketVault<T0>>(arg0),
            shares   : v0,
            redeemer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BasketRedeemEvent>(v3);
        RedeemReceipt<T0>{
            vault_id      : 0x2::object::id<BasketVault<T0>>(arg0),
            shares        : v0,
            supply_before : arg0.total_shares,
            withdrawn     : v1,
        }
    }

    public fun sweep_protocol_fees<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = take_protocol_fee<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg0.protocol_recipient);
    }

    fun take_issue<T0>(arg0: &mut BasketVault<T0>, arg1: u64, arg2: u64) {
        let (v0, v1) = refill(arg0.issue_left, arg0.issue_at, arg2, arg0.issue_per_hour);
        assert!(arg1 <= v0, 19);
        arg0.issue_left = v0 - arg1;
        arg0.issue_at = v1;
    }

    fun take_owner_fee<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = OwnerFeeKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_field::remove<OwnerFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T1>(&v1) > 0, 1);
        0x2::coin::from_balance<T1>(v1, arg1)
    }

    fun take_protocol_fee<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = ProtocolFeeKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ProtocolFeeKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_field::remove<ProtocolFeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T1>(&v1) > 0, 1);
        0x2::coin::from_balance<T1>(v1, arg1)
    }

    fun take_redeem<T0>(arg0: &mut BasketVault<T0>, arg1: u64, arg2: u64) {
        let (v0, v1) = refill(arg0.redeem_left, arg0.redeem_at, arg2, redeem_allowance<T0>(arg0));
        assert!(arg1 <= v0, 19);
        arg0.redeem_left = v0 - arg1;
        arg0.redeem_at = v1;
    }

    public fun total_shares<T0>(arg0: &BasketVault<T0>) : u64 {
        arg0.total_shares
    }

    fun validate_recipe(arg0: &vector<BasketLeg>) {
        let v0 = 0x1::vector::length<BasketLeg>(arg0);
        assert!(v0 >= 2 && v0 <= 8, 2);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::borrow<BasketLeg>(arg0, v1).units_per_share > 0, 2);
            let v2 = 0;
            while (v2 < v1) {
                assert!(0x1::vector::borrow<BasketLeg>(arg0, v2).asset != 0x1::vector::borrow<BasketLeg>(arg0, v1).asset, 3);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun withdraw<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut RedeemReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<BasketVault<T0>>(arg0) == arg1.vault_id, 5);
        let v0 = leg_index<T1>(&arg0.recipe);
        assert!(!*0x1::vector::borrow<bool>(&arg1.withdrawn, v0), 7);
        assert!(!*0x1::vector::borrow<bool>(&arg0.excluded, v0), 20);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T1>());
        let v2 = mul_div_floor(0x2::balance::value<T1>(v1), arg1.shares, arg1.supply_before);
        let v3 = floor_bps(v2, arg0.redeem_fee_bps);
        let v4 = floor_bps(v2, 20);
        let v5 = add_u64(v3, v4);
        assert!(v5 <= v2, 12);
        let v6 = 0x2::balance::split<T1>(v1, v2);
        if (v3 > 0) {
            join_owner_fee<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v6, v3));
        };
        if (v4 > 0) {
            join_protocol_fee<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v6, v4));
        };
        0x2::balance::destroy_zero<T1>(v6);
        *0x1::vector::borrow_mut<bool>(&mut arg1.withdrawn, v0) = true;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v6, v2 - v5), arg2)
    }

    public fun withdraw_owner_fees<T0, T1>(arg0: &mut BasketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 18);
        take_owner_fee<T0, T1>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}


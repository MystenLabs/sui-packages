module 0x4c534bef417de91cf3e9ae7f9d4d324969e3132f47cfde8972d0039b1337bf2e::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        supply: u64,
        minted: u64,
        burned: u64,
        price: u64,
        stake_amount: u64,
        lp_amount: u64,
        fee_wallet: address,
        validator: address,
        swap_pool: 0x2::object::ID,
        lp_pool: 0x2::object::ID,
        vault: 0x2::object::ID,
        policy: 0x2::object::ID,
        graveyard: 0x2::object::ID,
        graveyard_cap: 0x2::kiosk::KioskOwnerCap,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Item>,
        mint_open: bool,
        items: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        collection: 0x2::object::ID,
        proofs: 0x2::table::Table<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
        next_index: u64,
        live: u64,
        pot_a: 0x2::balance::Balance<T0>,
        pot_b: 0x2::balance::Balance<0x2::sui::SUI>,
        acc_a: u128,
        acc_b: u128,
        sweep_fee_bps: u64,
        sweep_open: bool,
        swept_a: u64,
        swept_b: u64,
        paid_a: u64,
        paid_b: u64,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        vault: 0x2::object::ID,
        stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        principal: u64,
        validator: address,
        status: 0x1::string::String,
        debt_a: u128,
        debt_b: u128,
        minted_epoch: u64,
        burned_epoch: u64,
    }

    struct CollectionCreated has copy, drop {
        collection: 0x2::object::ID,
        policy: 0x2::object::ID,
        graveyard: 0x2::object::ID,
        supply: u64,
        price: u64,
    }

    struct VaultCreated has copy, drop {
        collection: 0x2::object::ID,
        vault: 0x2::object::ID,
    }

    struct Minted has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        minter: address,
        principal: u64,
        validator: address,
        liquidity: u128,
        swap_in: u64,
        lp_sui: u64,
        lp_a: u64,
        fee: u64,
    }

    struct Harvested has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        reward: u64,
        validator: address,
        holder: address,
    }

    struct Collected has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        amount_a: u64,
        amount_b: u64,
        holder: address,
    }

    struct Swept has copy, drop {
        vault: 0x2::object::ID,
        caller: address,
        indices: u64,
        amount_a: u64,
        amount_b: u64,
        caller_a: u64,
        caller_b: u64,
        live: u64,
    }

    struct Burned has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        holder: address,
        principal: u64,
        staking_out: u64,
        pot_a: u64,
        pot_b: u64,
        royalty: u64,
        live: u64,
    }

    struct ValidatorSet has copy, drop {
        collection: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct PoolsSet has copy, drop {
        collection: 0x2::object::ID,
        swap_from: 0x2::object::ID,
        swap_to: 0x2::object::ID,
        lp_from: 0x2::object::ID,
        lp_to: 0x2::object::ID,
    }

    struct FeeWalletSet has copy, drop {
        collection: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct MintOpenSet has copy, drop {
        collection: 0x2::object::ID,
        open: bool,
    }

    struct SweepSet has copy, drop {
        vault: 0x2::object::ID,
        open: bool,
        fee_bps: u64,
    }

    struct RoyaltySet has copy, drop {
        collection: 0x2::object::ID,
        bps: u16,
        min: u64,
    }

    struct RoyaltyWithdrawn has copy, drop {
        collection: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct Migrated has copy, drop {
        object: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct AdminTransferred has copy, drop {
        to: address,
    }

    public fun acc<T0>(arg0: &Vault<T0>) : (u128, u128) {
        (arg0.acc_a, arg0.acc_b)
    }

    fun assert_configured(arg0: &Collection) {
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = if (arg0.fee_wallet != @0x0) {
            if (arg0.validator != @0x0) {
                if (arg0.swap_pool != v0) {
                    if (arg0.lp_pool != v0) {
                        arg0.vault != v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 109);
    }

    public fun burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        check_burn<T0>(arg0, arg1, arg3, arg4);
        let (v0, v1) = take_out(arg5, arg6, arg7, arg8);
        let v2 = v0;
        assert!(v2.vault == 0x2::object::id<Vault<T0>>(arg1), 110);
        assert!(is_active(&v2), 111);
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut v2.stake), arg8);
        settle_burn<T0>(arg0, arg1, arg3, arg4, v2, v1, v3, arg8);
    }

    public fun burned(arg0: &Collection) : u64 {
        arg0.burned
    }

    fun check_burn<T0>(arg0: &Collection, arg1: &Vault<T0>, arg2: &0x2::transfer_policy::TransferPolicy<Item>, arg3: &0x2::kiosk::Kiosk) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg2) == arg0.policy, 118);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.graveyard, 117);
    }

    fun check_collection(arg0: &Collection) {
        assert!(arg0.version == 1, 100);
    }

    fun check_vault<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 100);
    }

    public fun collect<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        check_vault<T0>(arg0);
        let v0 = 0x2::kiosk::borrow_mut<Item>(arg1, arg2, arg3);
        assert!(v0.vault == 0x2::object::id<Vault<T0>>(arg0), 110);
        assert!(is_active(v0), 111);
        let (v1, v2) = pay_pot<T0>(arg0, v0, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = Collected{
            item     : arg3,
            number   : v0.number,
            amount_a : 0x2::coin::value<T0>(&v4),
            amount_b : 0x2::coin::value<0x2::sui::SUI>(&v3),
            holder   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Collected>(v5);
        let v6 = 0x2::tx_context::sender(arg4);
        send<T0>(v4, v6);
        send_sui(v3, v6);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        check_collection(arg1);
        assert!(arg1.vault == 0x2::object::id_from_address(@0x0), 119);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        arg1.vault = v1;
        let v2 = VaultCreated{
            collection : 0x2::object::id<Collection>(arg1),
            vault      : v1,
        };
        0x2::event::emit<VaultCreated>(v2);
        let v3 = Vault<T0>{
            id            : v0,
            version       : 1,
            collection    : 0x2::object::id<Collection>(arg1),
            proofs        : 0x2::table::new<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg2),
            next_index    : 0,
            live          : 0,
            pot_a         : 0x2::balance::zero<T0>(),
            pot_b         : 0x2::balance::zero<0x2::sui::SUI>(),
            acc_a         : 0,
            acc_b         : 0,
            sweep_fee_bps : 100,
            sweep_open    : true,
            swept_a       : 0,
            swept_b       : 0,
            paid_a        : 0,
            paid_b        : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v3);
    }

    fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v2 = (arg0.live as u128);
        arg0.acc_a = arg0.acc_a + (v0 as u128) * 1000000000000 / v2;
        arg0.acc_b = arg0.acc_b + (v1 as u128) * 1000000000000 / v2;
        arg0.swept_a = arg0.swept_a + v0;
        arg0.swept_b = arg0.swept_b + v1;
        0x2::balance::join<T0>(&mut arg0.pot_a, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot_b, arg2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, (((0x2::balance::value<T0>(&arg1) as u128) * (arg0.sweep_fee_bps as u128) / 10000) as u64)), arg3), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, (((0x2::balance::value<0x2::sui::SUI>(&arg2) as u128) * (arg0.sweep_fee_bps as u128) / 10000) as u64)), arg3))
    }

    public fun fee_wallet(arg0: &Collection) : address {
        arg0.fee_wallet
    }

    public fun graveyard_id(arg0: &Collection) : 0x2::object::ID {
        arg0.graveyard
    }

    public fun harvest(arg0: &Collection, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        let v0 = 0x2::kiosk::borrow_mut<Item>(arg2, arg3, arg4);
        assert!(is_active(v0), 111);
        let v1 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut v0.stake), arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) > v0.principal, 112);
        let v2 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v1, v0.principal, arg5), arg0.validator, arg5);
        assert!(0x3::staking_pool::staked_sui_amount(&v2) == v0.principal, 113);
        0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v0.stake, v2);
        v0.validator = arg0.validator;
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Harvested{
            item      : arg4,
            number    : v0.number,
            reward    : 0x2::balance::value<0x2::sui::SUI>(&v1),
            validator : arg0.validator,
            holder    : v3,
        };
        0x2::event::emit<Harvested>(v4);
        send_sui(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), v3);
    }

    public fun has_proof<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.proofs, arg1)
    }

    public fun has_stake(arg0: &Item) : bool {
        0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.stake)
    }

    public fun index(arg0: &Item) : u64 {
        arg0.index
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(1000000000 >= 1000000000, 123);
        assert!(1000000000 > 0 && 1000000000 + 1000000000 <= 2200000000, 123);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x1::string::utf8(b"https://thetester.alienz.tech/media/");
        0x1::string::append(&mut v2, 0x1::string::utf8(b"{status}/{number}."));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"png"));
        let v3 = 0x1::string::utf8(b"https://thetester.alienz.tech/");
        0x1::string::append(&mut v3, 0x1::string::utf8(b"piece/{number}"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"principal"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"validator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"The Tester #{number}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"A calibration card with two live signals inside. Every piece holds a native Sui staking position and an equal share of a pool of permanently locked Cetus liquidity. The holder can harvest staking rewards and collect pool fees at any time. Burning returns the staking in full and leaves the pool share to the remaining holders; the burned card is kept, in black and white, in the collection's graveyard."));
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v3);
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://thetester.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Calibration Works"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{number}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{status}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{principal}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{validator}"));
        let v8 = 0x2::display::new_with_fields<Item>(&v1, v4, v6, arg1);
        0x2::display::update_version<Item>(&mut v8);
        let (v9, v10) = 0x2::transfer_policy::new<Item>(&v1, arg1);
        let v11 = v10;
        let v12 = v9;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Item>(&mut v12, &v11, 300, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Item>(&mut v12, &v11);
        let (v13, v14) = 0x2::kiosk::new(arg1);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x2::object::new(arg1);
        let v18 = 0x2::object::uid_to_inner(&v17);
        0x2::kiosk::set_owner_custom(&mut v16, &v15, 0x2::object::id_to_address(&v18));
        let v19 = Collection{
            id            : v17,
            version       : 1,
            name          : 0x1::string::utf8(b"The Tester"),
            supply        : 1111,
            minted        : 0,
            burned        : 0,
            price         : 2200000000,
            stake_amount  : 1000000000,
            lp_amount     : 1000000000,
            fee_wallet    : @0x0,
            validator     : @0x0,
            swap_pool     : 0x2::object::id_from_address(@0x0),
            lp_pool       : 0x2::object::id_from_address(@0x0),
            vault         : 0x2::object::id_from_address(@0x0),
            policy        : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(&v12),
            graveyard     : 0x2::object::id<0x2::kiosk::Kiosk>(&v16),
            graveyard_cap : v15,
            policy_cap    : v11,
            mint_open     : false,
            items         : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        let v20 = CollectionCreated{
            collection : v18,
            policy     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(&v12),
            graveyard  : 0x2::object::id<0x2::kiosk::Kiosk>(&v16),
            supply     : 1111,
            price      : 2200000000,
        };
        0x2::event::emit<CollectionCreated>(v20);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Item>>(v12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v16);
        0x2::transfer::share_object<Collection>(v19);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v8, v0);
        let v21 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v21, v0);
    }

    public fun is_active(arg0: &Item) : bool {
        arg0.status == 0x1::string::utf8(b"Active")
    }

    public fun item_id(arg0: &Collection, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.items, arg1)
    }

    public fun item_validator(arg0: &Item) : address {
        arg0.validator
    }

    public fun item_vault(arg0: &Item) : 0x2::object::ID {
        arg0.vault
    }

    public fun live<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live
    }

    public fun lp_amount(arg0: &Collection) : u64 {
        arg0.lp_amount
    }

    public fun lp_pool(arg0: &Collection) : 0x2::object::ID {
        arg0.lp_pool
    }

    public fun migrate_collection(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Collection>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun migrate_vault<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Vault<T0>>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun mint<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u128, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg0.mint_open, 101);
        assert_configured(arg0);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg6) == arg0.policy, 118);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4);
        assert!(v0 == arg0.swap_pool && v0 == arg0.lp_pool, 105);
        assert!(arg0.price <= arg10, 104);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= arg0.price, 103);
        assert!(arg11 > 0 && arg11 < arg0.lp_amount, 106);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = arg0.price - arg0.stake_amount - arg0.lp_amount;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v2, arg14), arg0.fee_wallet);
        };
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg9, arg0.stake_amount, arg14), arg0.validator, arg14);
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg9, arg0.lp_amount, arg14);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, false, true, arg11, 79226673515401279992447579055, arg13);
        let v8 = v7;
        let v9 = v5;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v10, arg14)), v8);
        let v11 = 0x2::balance::value<T0>(&v9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg3, arg4, 4294523696, 443600, arg14);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg3, arg4, &mut v12, v11, true, arg13);
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v13);
        assert!(v14 == v11, 107);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v4) >= v15, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg3, arg4, v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v15, arg14)), v13);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v12);
        assert!(v16 >= arg12, 108);
        let v17 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg5, v12, arg14);
        let v18 = 0x3::staking_pool::staked_sui_amount(&v3);
        let v19 = arg0.validator;
        let v20 = register_piece<T0>(arg0, arg1, 0x1::option::some<0x3::staking_pool::StakedSui>(v3), v18, v19, arg14);
        0x2::table::add<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v20.index, v17);
        let v21 = Minted{
            item      : 0x2::object::id<Item>(&v20),
            number    : v20.number,
            index     : v20.index,
            minter    : v1,
            principal : v18,
            validator : v19,
            liquidity : v16,
            swap_in   : v10,
            lp_sui    : v10 + v15,
            lp_a      : v11,
            fee       : v2,
        };
        0x2::event::emit<Minted>(v21);
        0x2::kiosk::lock<Item>(arg7, arg8, arg6, v20);
        0x2::coin::join<0x2::sui::SUI>(&mut arg9, v4);
        send_sui(arg9, v1);
    }

    public fun mint_open(arg0: &Collection) : bool {
        arg0.mint_open
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun next_index<T0>(arg0: &Vault<T0>) : u64 {
        arg0.next_index
    }

    public fun number(arg0: &Item) : u64 {
        arg0.number
    }

    fun pay_pot<T0>(arg0: &mut Vault<T0>, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = (((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64);
        let v1 = (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64);
        arg1.debt_a = arg0.acc_a;
        arg1.debt_b = arg0.acc_b;
        arg0.paid_a = arg0.paid_a + v0;
        arg0.paid_b = arg0.paid_b + v1;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot_a, v0), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot_b, v1), arg2))
    }

    public fun pending<T0>(arg0: &Vault<T0>, arg1: &Item) : (u64, u64) {
        ((((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64), (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64))
    }

    public fun policy_id(arg0: &Collection) : 0x2::object::ID {
        arg0.policy
    }

    public fun pot<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.pot_a), 0x2::balance::value<0x2::sui::SUI>(&arg0.pot_b))
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    public fun principal(arg0: &Item) : u64 {
        arg0.principal
    }

    fun register_piece<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: 0x1::option::Option<0x3::staking_pool::StakedSui>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Item {
        assert!(arg0.minted < arg0.supply, 102);
        arg0.minted = arg0.minted + 1;
        let v0 = arg1.next_index;
        arg1.next_index = v0 + 1;
        arg1.live = arg1.live + 1;
        let v1 = 0x2::object::new(arg5);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.items, arg0.minted, 0x2::object::uid_to_inner(&v1));
        Item{
            id           : v1,
            number       : arg0.minted,
            index        : v0,
            vault        : 0x2::object::id<Vault<T0>>(arg1),
            stake        : arg2,
            principal    : arg3,
            validator    : arg4,
            status       : 0x1::string::utf8(b"Active"),
            debt_a       : arg1.acc_a,
            debt_b       : arg1.acc_b,
            minted_epoch : 0x2::tx_context::epoch(arg5),
            burned_epoch : 0,
        }
    }

    public fun scale() : u128 {
        1000000000000
    }

    fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun send_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        send<0x2::sui::SUI>(arg0, arg1);
    }

    public fun set_fee_wallet(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        check_collection(arg1);
        let v0 = FeeWalletSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.fee_wallet,
            to         : arg2,
        };
        0x2::event::emit<FeeWalletSet>(v0);
        arg1.fee_wallet = arg2;
    }

    public fun set_mint_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        check_collection(arg1);
        if (arg2) {
            assert_configured(arg1);
        };
        arg1.mint_open = arg2;
        let v0 = MintOpenSet{
            collection : 0x2::object::id<Collection>(arg1),
            open       : arg2,
        };
        0x2::event::emit<MintOpenSet>(v0);
    }

    public fun set_pools(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        check_collection(arg1);
        let v0 = PoolsSet{
            collection : 0x2::object::id<Collection>(arg1),
            swap_from  : arg1.swap_pool,
            swap_to    : arg2,
            lp_from    : arg1.lp_pool,
            lp_to      : arg3,
        };
        0x2::event::emit<PoolsSet>(v0);
        arg1.swap_pool = arg2;
        arg1.lp_pool = arg3;
    }

    public fun set_royalty(arg0: &AdminCap, arg1: &Collection, arg2: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg3: u16, arg4: u64) {
        check_collection(arg1);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg2) == arg1.policy, 118);
        0x2::transfer_policy::remove_rule<Item, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg2, &arg1.policy_cap);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Item>(arg2, &arg1.policy_cap, arg3, arg4);
        let v0 = RoyaltySet{
            collection : 0x2::object::id<Collection>(arg1),
            bps        : arg3,
            min        : arg4,
        };
        0x2::event::emit<RoyaltySet>(v0);
    }

    public fun set_sweep<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: u64) {
        check_vault<T0>(arg1);
        assert!(arg3 <= 1000, 120);
        arg1.sweep_open = arg2;
        arg1.sweep_fee_bps = arg3;
        let v0 = SweepSet{
            vault   : 0x2::object::id<Vault<T0>>(arg1),
            open    : arg2,
            fee_bps : arg3,
        };
        0x2::event::emit<SweepSet>(v0);
    }

    public fun set_validator(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        check_collection(arg1);
        let v0 = ValidatorSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.validator,
            to         : arg2,
        };
        0x2::event::emit<ValidatorSet>(v0);
        arg1.validator = arg2;
    }

    fun settle_burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg3: &mut 0x2::kiosk::Kiosk, arg4: Item, arg5: 0x2::transfer_policy::TransferRequest<Item>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = &mut arg4;
        let (v2, v3) = pay_pot<T0>(arg1, v1, arg7);
        let v4 = v3;
        let v5 = v2;
        arg1.live = arg1.live - 1;
        arg0.burned = arg0.burned + 1;
        arg4.status = 0x1::string::utf8(b"Burned");
        arg4.burned_epoch = 0x2::tx_context::epoch(arg7);
        assert!(0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg4.stake), 113);
        let v6 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<Item>(arg2, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<Item>(arg2, &mut arg5, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg6, v6), arg7));
        0x2::kiosk::lock<Item>(arg3, &arg0.graveyard_cap, arg2, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<Item>(&mut arg5, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Item>(arg2, arg5);
        let v10 = Burned{
            item        : 0x2::object::id<Item>(&arg4),
            number      : arg4.number,
            index       : arg4.index,
            holder      : v0,
            principal   : arg4.principal,
            staking_out : 0x2::balance::value<0x2::sui::SUI>(&arg6),
            pot_a       : 0x2::coin::value<T0>(&v5),
            pot_b       : 0x2::coin::value<0x2::sui::SUI>(&v4),
            royalty     : v6,
            live        : arg1.live,
        };
        0x2::event::emit<Burned>(v10);
        let v11 = 0x2::coin::from_balance<0x2::sui::SUI>(arg6, arg7);
        0x2::coin::join<0x2::sui::SUI>(&mut v11, v4);
        send<T0>(v5, v0);
        send_sui(v11, v0);
    }

    public fun stake_amount(arg0: &Collection) : u64 {
        arg0.stake_amount
    }

    public fun status(arg0: &Item) : 0x1::string::String {
        arg0.status
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    public fun swap_pool(arg0: &Collection) : 0x2::object::ID {
        arg0.swap_pool
    }

    public fun sweep<T0>(arg0: &Collection, arg1: &mut Vault<T0>, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(arg1.sweep_open, 114);
        assert!(arg1.live > 0, 115);
        let v0 = 0x1::vector::length<u64>(&arg5);
        assert!(v0 > 0 && v0 <= 50, 116);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg5, v3);
            assert!(v4 < arg1.next_index, 122);
            let (v5, v6) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg2, arg3, arg4, 0x2::table::borrow_mut<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v4), arg6);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v5));
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
            v3 = v3 + 1;
        };
        let (v7, v8) = deposit<T0>(arg1, v1, v2, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::tx_context::sender(arg6);
        let v12 = Swept{
            vault    : 0x2::object::id<Vault<T0>>(arg1),
            caller   : v11,
            indices  : v0,
            amount_a : 0x2::balance::value<T0>(&v1),
            amount_b : 0x2::balance::value<0x2::sui::SUI>(&v2),
            caller_a : 0x2::coin::value<T0>(&v10),
            caller_b : 0x2::coin::value<0x2::sui::SUI>(&v9),
            live     : arg1.live,
        };
        0x2::event::emit<Swept>(v12);
        send<T0>(v10, v11);
        send_sui(v9, v11);
    }

    public fun sweep_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.sweep_fee_bps
    }

    public fun sweep_open<T0>(arg0: &Vault<T0>) : bool {
        arg0.sweep_open
    }

    fun take_out(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (Item, 0x2::transfer_policy::TransferRequest<Item>) {
        0x2::kiosk::purchase_with_cap<Item>(arg0, 0x2::kiosk::list_with_purchase_cap<Item>(arg0, arg1, arg2, 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        let v0 = AdminTransferred{to: arg1};
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun validator(arg0: &Collection) : address {
        arg0.validator
    }

    public fun vault_id(arg0: &Collection) : 0x2::object::ID {
        arg0.vault
    }

    public fun version() : u64 {
        1
    }

    public fun withdraw_royalties(arg0: &AdminCap, arg1: &Collection, arg2: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_collection(arg1);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg2) == arg1.policy, 118);
        let v0 = 0x2::transfer_policy::withdraw<Item>(arg2, &arg1.policy_cap, 0x1::option::none<u64>(), arg3);
        let v1 = RoyaltyWithdrawn{
            collection : 0x2::object::id<Collection>(arg1),
            amount     : 0x2::coin::value<0x2::sui::SUI>(&v0),
            to         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RoyaltyWithdrawn>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}


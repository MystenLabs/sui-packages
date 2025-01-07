module 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::linear_ve_sca {
    struct LINEAR_VE_SCA_ISSUER has drop {
        dummy_field: bool,
    }

    struct LINEAR_VE_SCA has drop {
        dummy_field: bool,
    }

    struct LinearVeScaMinted has copy, drop {
        amount: u64,
        mint_timestamp: u64,
        issuer_type: 0x1::type_name::TypeName,
        model_id: 0x2::object::ID,
        enable_partial_redeem: bool,
    }

    struct LinearVestedScaRedeemed has copy, drop {
        sca_redeemed: u64,
        unvested_amount: u64,
        issuer_type: 0x1::type_name::TypeName,
        model_id: 0x2::object::ID,
        enable_partial_redeem: bool,
    }

    struct LinearVeScaBurned has copy, drop {
        mint_timestamp: u64,
        redeemed_amount: u64,
        total_redeemable_amount: u64,
        issuer_type: 0x1::type_name::TypeName,
        model_id: 0x2::object::ID,
        enable_partial_redeem: bool,
    }

    struct VestingModelAdded has copy, drop {
        model_id: 0x2::object::ID,
        cliff: u64,
        vesting_period: u64,
    }

    struct VestingModelUpdated has copy, drop {
        model_id: 0x2::object::ID,
        previous_cliff: u64,
        previous_vesting_period: u64,
        new_cliff: u64,
        new_vesting_period: u64,
    }

    struct IssuerAdded has copy, drop {
        issuer_type: 0x1::type_name::TypeName,
    }

    struct IssuerRemoved has copy, drop {
        issuer_type: 0x1::type_name::TypeName,
    }

    struct LinearVeSca has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<LINEAR_VE_SCA>,
        issuer_type: 0x1::type_name::TypeName,
        model_typed_id: 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::typed_id::TypedID<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModel>,
        mint_timestamp: u64,
        redeemed_amount: u64,
        total_redeemable_amount: u64,
        enable_partial_redeem: bool,
    }

    struct LinearVeScaTreasury has key {
        id: 0x2::object::UID,
        x_supply: 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::XSupply<LINEAR_VE_SCA>,
        sca_balance: 0x2::balance::Balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>,
    }

    struct LinearVeScaCap has store, key {
        id: 0x2::object::UID,
        x_supply_cap: 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::XSupplyCap<LINEAR_VE_SCA>,
    }

    public fun value(arg0: &LinearVeSca) : u64 {
        0x2::balance::value<LINEAR_VE_SCA>(&arg0.balance)
    }

    public fun add_issuer<T0: drop>(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaTreasury) {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::add_issuer<LINEAR_VE_SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
        let v0 = IssuerAdded{issuer_type: 0x1::type_name::get<T0>()};
        0x2::event::emit<IssuerAdded>(v0);
    }

    public fun add_vesting_model(arg0: &LinearVeScaCap, arg1: &mut 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModels, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::add_model(arg1, arg2, arg3, arg4);
        let v1 = VestingModelAdded{
            model_id       : v0,
            cliff          : arg2,
            vesting_period : arg3,
        };
        0x2::event::emit<VestingModelAdded>(v1);
        v0
    }

    public fun assert_is_issuer<T0: drop>(arg0: &LinearVeSca) {
        assert!(is_issuer<T0>(arg0), 403);
    }

    public fun burn(arg0: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::Version, arg1: LinearVeSca) {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::assert_current_version(arg0);
        assert!(0x2::balance::value<LINEAR_VE_SCA>(&arg1.balance) == 0, 503);
        let LinearVeSca {
            id                      : v0,
            balance                 : v1,
            issuer_type             : v2,
            model_typed_id          : v3,
            mint_timestamp          : v4,
            redeemed_amount         : v5,
            total_redeemable_amount : v6,
            enable_partial_redeem   : v7,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<LINEAR_VE_SCA>(v1);
        let v8 = LinearVeScaBurned{
            mint_timestamp          : v4,
            redeemed_amount         : v5,
            total_redeemable_amount : v6,
            issuer_type             : v2,
            model_id                : 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::typed_id::to_id<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModel>(v3),
            enable_partial_redeem   : v7,
        };
        0x2::event::emit<LinearVeScaBurned>(v8);
    }

    public fun calc_vested_amount(arg0: &LinearVeSca, arg1: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModels, arg2: &0x2::clock::Clock) : u64 {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::calc_vested_amount(arg1, *0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::typed_id::as_id<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModel>(&arg0.model_typed_id), arg0.total_redeemable_amount, arg0.mint_timestamp, arg2)
    }

    public fun deposit_sca(arg0: &mut LinearVeScaTreasury, arg1: 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>) {
        0x2::balance::join<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg0.sca_balance, 0x2::coin::into_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(arg1));
    }

    fun init(arg0: LINEAR_VE_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::create_x_supply<LINEAR_VE_SCA>(0x2::balance::create_supply<LINEAR_VE_SCA>(arg0), arg1);
        let v2 = LinearVeScaCap{
            id           : 0x2::object::new(arg1),
            x_supply_cap : v1,
        };
        let v3 = LinearVeScaTreasury{
            id          : 0x2::object::new(arg1),
            x_supply    : v0,
            sca_balance : 0x2::balance::zero<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(),
        };
        0x2::transfer::share_object<LinearVeScaTreasury>(v3);
        0x2::transfer::transfer<LinearVeScaCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_issuer<T0: drop>(arg0: &LinearVeSca) : bool {
        arg0.issuer_type == 0x1::type_name::get<T0>()
    }

    public fun issuer_type(arg0: &LinearVeSca) : 0x1::type_name::TypeName {
        arg0.issuer_type
    }

    public fun mint<T0: drop>(arg0: T0, arg1: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::Version, arg2: &mut LinearVeScaTreasury, arg3: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModels, arg4: 0x2::object::ID, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : LinearVeSca {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::assert_current_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        let (v2, _, _) = 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::get_model(arg3, arg4);
        let v5 = LinearVeSca{
            id                      : 0x2::object::new(arg8),
            balance                 : 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::increase_supply<LINEAR_VE_SCA, T0>(arg0, &mut arg2.x_supply, arg5),
            issuer_type             : v1,
            model_typed_id          : 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::typed_id::new<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModel>(v2),
            mint_timestamp          : v0,
            redeemed_amount         : 0,
            total_redeemable_amount : arg5,
            enable_partial_redeem   : arg6,
        };
        let v6 = LinearVeScaMinted{
            amount                : arg5,
            mint_timestamp        : v0,
            issuer_type           : v1,
            model_id              : arg4,
            enable_partial_redeem : arg6,
        };
        0x2::event::emit<LinearVeScaMinted>(v6);
        v5
    }

    public fun mint_timestamp(arg0: &LinearVeSca) : u64 {
        arg0.mint_timestamp
    }

    public fun redeem_sca<T0: drop>(arg0: T0, arg1: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::Version, arg2: &mut LinearVeScaTreasury, arg3: &0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModels, arg4: &mut LinearVeSca, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::assert_current_version(arg1);
        assert!(arg4.issuer_type == 0x1::type_name::get<T0>(), 403);
        let v0 = calc_vested_amount(arg4, arg3, arg5);
        let v1 = v0 - arg4.redeemed_amount;
        assert!(v1 > 0, 505);
        assert!(v1 <= 0x2::balance::value<LINEAR_VE_SCA>(&arg4.balance), 504);
        arg4.redeemed_amount = v0;
        let v2 = if (arg4.enable_partial_redeem) {
            0x2::balance::split<LINEAR_VE_SCA>(&mut arg4.balance, v1)
        } else {
            0x2::balance::split<LINEAR_VE_SCA>(&mut arg4.balance, 0x2::balance::value<LINEAR_VE_SCA>(&arg4.balance))
        };
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::decrease_supply<LINEAR_VE_SCA, T0>(arg0, &mut arg2.x_supply, v2);
        let v3 = 0x2::coin::from_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(0x2::balance::split<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg2.sca_balance, v1), arg6);
        let v4 = LinearVestedScaRedeemed{
            sca_redeemed          : 0x2::coin::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&v3),
            unvested_amount       : 0x2::balance::value<LINEAR_VE_SCA>(&arg4.balance),
            issuer_type           : arg4.issuer_type,
            model_id              : 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::typed_id::to_id<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModel>(arg4.model_typed_id),
            enable_partial_redeem : arg4.enable_partial_redeem,
        };
        0x2::event::emit<LinearVestedScaRedeemed>(v4);
        v3
    }

    public fun remove_issuer<T0: drop>(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaTreasury) {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::remove_issuer<LINEAR_VE_SCA, T0>(&arg0.x_supply_cap, &mut arg1.x_supply);
        let v0 = IssuerRemoved{issuer_type: 0x1::type_name::get<T0>()};
        0x2::event::emit<IssuerRemoved>(v0);
    }

    public fun supply_value(arg0: &LinearVeScaTreasury) : u64 {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::x_supply::supply_value<LINEAR_VE_SCA>(&arg0.x_supply)
    }

    public fun update_version(arg0: &LinearVeScaCap, arg1: &mut 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::Version) {
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::version::upgrade_version(arg1);
    }

    public fun update_vesting_model(arg0: &LinearVeScaCap, arg1: &mut 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::VestingModels, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let (_, v1, v2) = 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::get_model(arg1, arg2);
        0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model::update_model(arg1, arg2, arg3, arg4);
        let v3 = VestingModelUpdated{
            model_id                : arg2,
            previous_cliff          : v1,
            previous_vesting_period : v2,
            new_cliff               : arg3,
            new_vesting_period      : arg4,
        };
        0x2::event::emit<VestingModelUpdated>(v3);
    }

    public fun withdraw_sca(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        0x2::coin::from_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(0x2::balance::split<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg1.sca_balance, 0x2::math::min(arg2, 0x2::balance::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg1.sca_balance))), arg3)
    }

    // decompiled from Move bytecode v6
}


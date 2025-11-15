module 0x4f1c5c376f4ad4e33a9010d2b604352b69c5d94150c3897e2ae83ec0f6a07175::stingray {
    struct Stingray has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultBuyFee has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRedeemFee has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultPlatformFee has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeCollector<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ValueTolerance has copy, drop, store {
        dummy_field: bool,
    }

    struct Collector<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        record: 0x2::vec_map::VecMap<0x2::object::ID, UnfilledAmount>,
        claimed_amount: u64,
        accumulated_amount: u64,
        claimable_amount: u64,
    }

    struct UnfilledAmount has copy, drop, store {
        pos0: u64,
    }

    struct ToleranceTs has copy, drop, store {
        dummy_field: bool,
    }

    public fun accumulated_amount<T0>(arg0: &Stingray) : u64 {
        let v0 = FeeCollector<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<FeeCollector<T0>, Collector<T0>>(&arg0.id, v0).accumulated_amount
    }

    public(friend) fun add_record<T0>(arg0: &mut Stingray, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)) {
            err_base_not_supported();
        };
        let v1 = FeeCollector<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v1);
        v2.accumulated_amount = v2.accumulated_amount + arg2;
        v2.claimable_amount = v2.claimable_amount + arg2;
        if (0x2::vec_map::contains<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1)) {
            0x2::vec_map::get_mut<0x2::object::ID, UnfilledAmount>(&mut v2.record, &arg1).pos0 = 0x2::vec_map::get<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1).pos0 + arg2;
        } else {
            let v3 = UnfilledAmount{pos0: arg2};
            0x2::vec_map::insert<0x2::object::ID, UnfilledAmount>(&mut v2.record, arg1, v3);
        };
    }

    public fun add_version(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
        } else {
            err_version_already_existed();
        };
    }

    public fun assert_version_not_allowed(arg0: &Stingray) {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
    }

    public entry fun claim_fee<T0>(arg0: &mut Stingray, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::withdraw_all<T0>(&mut v1.balance);
        let v3 = 0x2::balance::value<T0>(&v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), arg2);
        v1.claimed_amount = v1.claimed_amount + v3;
        v1.claimable_amount = v1.claimable_amount - v3;
    }

    public fun claimable_amount<T0>(arg0: &Stingray) : u64 {
        let v0 = FeeCollector<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<FeeCollector<T0>, Collector<T0>>(&arg0.id, v0).claimable_amount
    }

    public fun claimed_amount<T0>(arg0: &Stingray) : u64 {
        let v0 = FeeCollector<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<FeeCollector<T0>, Collector<T0>>(&arg0.id, v0).claimed_amount
    }

    public fun collect_fee<T0>(arg0: &mut Stingray, arg1: 0x2::balance::Balance<T0>) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)) {
            err_base_not_supported();
        };
        let v1 = FeeCollector<T0>{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FeeCollector<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1);
    }

    fun err_base_not_supported() {
        abort 10003
    }

    fun err_version_already_existed() {
        abort 10000
    }

    fun err_version_not_allowed() {
        abort 10002
    }

    fun err_version_not_existed() {
        abort 10001
    }

    public fun fill_record<T0>(arg0: &mut Stingray, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<T0>) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)) {
            err_base_not_supported();
        };
        let v1 = FeeCollector<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v1);
        if (!0x2::vec_map::contains<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1)) {
            return
        };
        let v3 = 0x2::vec_map::get<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1).pos0;
        if (v3 <= 0x2::balance::value<T0>(arg2)) {
            0x2::balance::join<T0>(&mut v2.balance, 0x2::balance::split<T0>(arg2, v3));
            0x2::vec_map::get_mut<0x2::object::ID, UnfilledAmount>(&mut v2.record, &arg1).pos0 = 0;
        } else {
            0x2::balance::join<T0>(&mut v2.balance, 0x2::balance::withdraw_all<T0>(arg2));
            0x2::vec_map::get_mut<0x2::object::ID, UnfilledAmount>(&mut v2.record, &arg1).pos0 = v3 - 0x2::balance::value<T0>(arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stingray{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(1),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = VaultBuyFee{dummy_field: false};
        0x2::dynamic_field::add<VaultBuyFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v0.id, v2, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(10));
        let v3 = VaultRedeemFee{dummy_field: false};
        0x2::dynamic_field::add<VaultRedeemFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v0.id, v3, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(10));
        let v4 = VaultPlatformFee{dummy_field: false};
        0x2::dynamic_field::add<VaultPlatformFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v0.id, v4, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(100));
        let v5 = ToleranceTs{dummy_field: false};
        0x2::dynamic_field::add<ToleranceTs, u64>(&mut v0.id, v5, 1000);
        let v6 = ValueTolerance{dummy_field: false};
        0x2::dynamic_field::add<ValueTolerance, u64>(&mut v0.id, v6, 100);
        0x2::transfer::share_object<Stingray>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_allowed_base<T0>(arg0: &Stingray) : bool {
        let v0 = FeeCollector<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)
    }

    public fun is_version_allowed(arg0: &Stingray) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    public fun new_fee_collector<T0>(arg0: &mut Stingray, arg1: &AdminCap) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        let v1 = Collector<T0>{
            balance            : 0x2::balance::zero<T0>(),
            record             : 0x2::vec_map::empty<0x2::object::ID, UnfilledAmount>(),
            claimed_amount     : 0,
            accumulated_amount : 0,
            claimable_amount   : 0,
        };
        0x2::dynamic_field::add<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v0, v1);
    }

    public(friend) fun record_claim_unfilled_amount<T0>(arg0: &mut Stingray, arg1: 0x2::object::ID) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::vec_map::get<0x2::object::ID, UnfilledAmount>(&v1.record, &arg1).pos0;
        0x2::vec_map::get_mut<0x2::object::ID, UnfilledAmount>(&mut v1.record, &arg1).pos0 = 0;
        v1.claimed_amount = v1.claimed_amount + v2;
        v1.claimable_amount = v1.claimable_amount - v2;
    }

    entry fun remove_fee_collector<T0>(arg0: &mut Stingray, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        let Collector {
            balance            : v1,
            record             : _,
            claimed_amount     : _,
            accumulated_amount : _,
            claimable_amount   : _,
        } = 0x2::dynamic_field::remove<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
    }

    public fun remove_version(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
        } else {
            err_version_not_existed();
        };
    }

    public(friend) fun set_record_after_claimed<T0>(arg0: &mut Stingray, arg1: 0x2::object::ID) {
        let v0 = FeeCollector<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)) {
            err_base_not_supported();
        };
        let v1 = FeeCollector<T0>{dummy_field: false};
        0x2::vec_map::get_mut<0x2::object::ID, UnfilledAmount>(&mut 0x2::dynamic_field::borrow_mut<FeeCollector<T0>, Collector<T0>>(&mut arg0.id, v1).record, &arg1).pos0 = 0;
    }

    public fun tolerance_ts(arg0: &Stingray) : u64 {
        let v0 = ToleranceTs{dummy_field: false};
        *0x2::dynamic_field::borrow<ToleranceTs, u64>(&arg0.id, v0)
    }

    public fun unfilled_amount<T0>(arg0: &Stingray, arg1: 0x2::object::ID) : u64 {
        let v0 = FeeCollector<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeCollector<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = FeeCollector<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<FeeCollector<T0>, Collector<T0>>(&arg0.id, v1);
        if (!0x2::vec_map::contains<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1)) {
            0
        } else {
            0x2::vec_map::get<0x2::object::ID, UnfilledAmount>(&v2.record, &arg1).pos0
        }
    }

    public fun update_tolerance_ts(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        let v0 = ToleranceTs{dummy_field: false};
        0x2::dynamic_field::remove<ToleranceTs, u64>(&mut arg0.id, v0);
        let v1 = ToleranceTs{dummy_field: false};
        0x2::dynamic_field::add<ToleranceTs, u64>(&mut arg0.id, v1, arg2);
    }

    public fun update_value_tolerance(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        let v0 = ValueTolerance{dummy_field: false};
        0x2::dynamic_field::remove<ValueTolerance, u64>(&mut arg0.id, v0);
        let v1 = ValueTolerance{dummy_field: false};
        0x2::dynamic_field::add<ValueTolerance, u64>(&mut arg0.id, v1, arg2);
    }

    public fun update_vault_buy_fee(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        let v0 = VaultBuyFee{dummy_field: false};
        0x2::dynamic_field::remove<VaultBuyFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v0);
        let v1 = VaultBuyFee{dummy_field: false};
        0x2::dynamic_field::add<VaultBuyFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v1, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(arg2));
    }

    public fun update_vault_platform_fee(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        let v0 = VaultPlatformFee{dummy_field: false};
        0x2::dynamic_field::remove<VaultPlatformFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v0);
        let v1 = VaultPlatformFee{dummy_field: false};
        0x2::dynamic_field::add<VaultPlatformFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v1, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(arg2));
    }

    public fun update_vault_redeem_fee(arg0: &mut Stingray, arg1: &AdminCap, arg2: u64) {
        let v0 = VaultRedeemFee{dummy_field: false};
        0x2::dynamic_field::remove<VaultRedeemFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v0);
        let v1 = VaultRedeemFee{dummy_field: false};
        0x2::dynamic_field::add<VaultRedeemFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut arg0.id, v1, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_bps(arg2));
    }

    public fun value_tolerance(arg0: &Stingray) : u64 {
        let v0 = ValueTolerance{dummy_field: false};
        *0x2::dynamic_field::borrow<ValueTolerance, u64>(&arg0.id, v0)
    }

    public fun vault_buy_fee(arg0: &Stingray) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = VaultBuyFee{dummy_field: false};
        *0x2::dynamic_field::borrow<VaultBuyFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&arg0.id, v0)
    }

    public fun vault_platform_fee(arg0: &Stingray) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = VaultPlatformFee{dummy_field: false};
        *0x2::dynamic_field::borrow<VaultPlatformFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&arg0.id, v0)
    }

    public fun vault_redeem_fee(arg0: &Stingray) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = VaultRedeemFee{dummy_field: false};
        *0x2::dynamic_field::borrow<VaultRedeemFee, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}


module 0x33ffca947d72dcfad02a9154677689fa29b90d365bd7eb24cd95addffe7af1bf::lockedup {
    struct LockedUpAdmin has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LOCKEDUP>,
        vesting_locked_up: u64,
        up_balance: 0x2::balance::Balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>,
        default_unlock_time: u64,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct UnlockUpCost<phantom T0> has store {
        coin_type: 0x1::type_name::TypeName,
        coin_balance: 0x2::balance::Balance<T0>,
        reduction_rate: u64,
    }

    struct LockedUpPosition has store, key {
        id: 0x2::object::UID,
        amount: u64,
        unlock_time: u64,
    }

    struct LockedUpAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LOCKEDUP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut LockedUpAdmin, arg1: 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LOCKEDUP> {
        assert_valid_version(arg0);
        0x2::balance::join<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, 0x2::coin::into_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(arg1));
        0x2::coin::mint<LOCKEDUP>(&mut arg0.treasury_cap, 0x2::coin::value<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&arg1), arg2)
    }

    public fun add_unlock_time_payment<T0>(arg0: &mut LockedUpAdmin, arg1: &LockedUpAdminCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = UnlockUpCost<T0>{
            coin_type      : v0,
            coin_balance   : 0x2::balance::zero<T0>(),
            reduction_rate : arg2,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, UnlockUpCost<T0>>(&mut arg0.id, v0, v1);
    }

    public fun add_version(arg0: &LockedUpAdminCap, arg1: &mut LockedUpAdmin, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.versions, arg2);
    }

    public fun assert_valid_version(arg0: &LockedUpAdmin) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_invalid_version();
        };
    }

    public fun err_cannot_redeem_before_unlock() {
        abort 0
    }

    public fun err_invalid_version() {
        abort 1
    }

    public fun get_unlock_amount_required<T0>(arg0: &LockedUpAdmin, arg1: &LockedUpPosition) : u64 {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::ceil(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::div(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::mul(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg0.default_unlock_time), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg1.amount)), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(0x2::dynamic_field::borrow<0x1::type_name::TypeName, UnlockUpCost<T0>>(&arg0.id, 0x1::type_name::get<T0>()).reduction_rate)))
    }

    fun init(arg0: LOCKEDUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKEDUP>(arg0, 6, b"LockedUp", b"LockedUp", b"LockedUp Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://doubleup-public.s3.us-east-1.amazonaws.com/tge/DU_locked_up.png")), arg1);
        let v2 = LockedUpAdmin{
            id                  : 0x2::object::new(arg1),
            treasury_cap        : v0,
            vesting_locked_up   : 0,
            up_balance          : 0x2::balance::zero<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(),
            default_unlock_time : 2592000000,
            versions            : 0x2::vec_set::singleton<u64>(package_version()),
        };
        let v3 = LockedUpAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<LockedUpAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<LockedUpAdmin>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKEDUP>>(v1);
    }

    public fun package_version() : u64 {
        2
    }

    public fun redeem(arg0: &mut LockedUpAdmin, arg1: LockedUpPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        assert_valid_version(arg0);
        let LockedUpPosition {
            id          : v0,
            amount      : v1,
            unlock_time : v2,
        } = arg1;
        0x2::object::delete(v0);
        if (v2 > 0x2::clock::timestamp_ms(arg2)) {
            err_cannot_redeem_before_unlock();
        };
        arg0.vesting_locked_up = arg0.vesting_locked_up - v1;
        0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, v1), arg3)
    }

    public fun remove_unlock_time_payment<T0>(arg0: &LockedUpAdminCap, arg1: &mut LockedUpAdmin, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let UnlockUpCost {
            coin_type      : _,
            coin_balance   : v1,
            reduction_rate : _,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, UnlockUpCost<T0>>(&mut arg1.id, arg2);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun remove_version(arg0: &LockedUpAdminCap, arg1: &mut LockedUpAdmin, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.versions, &arg2);
    }

    public fun unlock(arg0: &mut LockedUpAdmin, arg1: 0x2::coin::Coin<LOCKEDUP>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LockedUpPosition {
        assert_valid_version(arg0);
        let v0 = 0x2::coin::burn<LOCKEDUP>(&mut arg0.treasury_cap, arg1);
        arg0.vesting_locked_up = arg0.vesting_locked_up + v0;
        LockedUpPosition{
            id          : 0x2::object::new(arg3),
            amount      : v0,
            unlock_time : 0x2::clock::timestamp_ms(arg2) + arg0.default_unlock_time,
        }
    }

    public fun unlock_faster<T0>(arg0: &mut LockedUpAdmin, arg1: &mut LockedUpPosition, arg2: 0x2::coin::Coin<T0>) {
        assert_valid_version(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, UnlockUpCost<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        let v1 = 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::ceil(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::mul(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::div(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(0x2::coin::value<T0>(&arg2) * v0.reduction_rate), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::mul(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg0.default_unlock_time), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg1.amount))), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(v0.reduction_rate)));
        if (v1 > arg1.unlock_time) {
            arg1.unlock_time = 0;
        } else {
            arg1.unlock_time = arg1.unlock_time - v1;
        };
        0x2::balance::join<T0>(&mut v0.coin_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}


module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint {
    struct PaidMint has key {
        id: 0x2::object::UID,
        pay_coin: 0x1::ascii::String,
        curve_id: 0x2::object::ID,
        seal_price: u64,
        spice_price: u64,
        rebate_bps: u64,
        treasury: address,
        paused: bool,
        seals_sold: u64,
        spice_sold: u64,
        revenue_total: u64,
        rebate_total: u64,
    }

    struct PaidMintOpened has copy, drop {
        id: 0x2::object::ID,
        pay_coin: 0x1::ascii::String,
        seal_price: u64,
        spice_price: u64,
        rebate_bps: u64,
        treasury: address,
    }

    struct SealBought has copy, drop {
        seal_id: 0x2::object::ID,
        buyer: address,
        paid: u64,
        order_id: 0x1::string::String,
    }

    struct SpiceBought has copy, drop {
        buyer: address,
        count: u64,
        paid: u64,
        rebate: u64,
        price: u64,
    }

    public fun buy_seal<T0>(arg0: &mut PaidMint, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 1);
        assert!(name<T0>() == arg0.pay_coin, 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 == arg0.seal_price, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.treasury);
        let v1 = 0x1::string::utf8(b"SEAL-");
        0x1::string::append(&mut v1, 0x1::u64::to_string(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::issued(arg1) + 1));
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::issue_package(arg1, arg2, v1, v2, arg4, arg5);
        arg0.seals_sold = arg0.seals_sold + 1;
        arg0.revenue_total = arg0.revenue_total + v0;
        let v4 = SealBought{
            seal_id  : v3,
            buyer    : v2,
            paid     : v0,
            order_id : v1,
        };
        0x2::event::emit<SealBought>(v4);
        v3
    }

    public fun curve_id(arg0: &PaidMint) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun is_paused(arg0: &PaidMint) : bool {
        arg0.paused
    }

    public fun mint_spice<T0, T1>(arg0: &mut PaidMint, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::MintBook, arg2: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault, arg3: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::bonding_curve::Curve<T0, T1>, arg4: &0x2::transfer_policy::TransferPolicy<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(!arg0.paused, 1);
        assert!(name<T1>() == arg0.pay_coin, 2);
        assert!(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::bonding_curve::Curve<T0, T1>>(arg3) == arg0.curve_id, 5);
        assert!(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::rebate_vault(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault>(arg2)), 4);
        let v0 = 0x2::coin::value<T1>(&arg9);
        assert!(v0 == arg0.spice_price * arg8, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg9, arg0.treasury);
        let v1 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::bonding_curve::spot_price<T0, T1>(arg3);
        let v2 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::pay_exact<T0>(arg2, rebate_for(v0, arg0.rebate_bps, v1), arg8, arg11);
        arg0.spice_sold = arg0.spice_sold + arg8;
        arg0.revenue_total = arg0.revenue_total + v0;
        arg0.rebate_total = arg0.rebate_total + v2;
        let v3 = SpiceBought{
            buyer  : 0x2::tx_context::sender(arg11),
            count  : arg8,
            paid   : v0,
            rebate : v2,
            price  : v1,
        };
        0x2::event::emit<SpiceBought>(v3);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::mint_package(arg1, arg4, arg5, arg6, arg7, arg8, arg10, arg11)
    }

    fun name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun open<T0>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 <= 2000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = PaidMint{
            id            : 0x2::object::new(arg6),
            pay_coin      : name<T0>(),
            curve_id      : arg1,
            seal_price    : arg2,
            spice_price   : arg3,
            rebate_bps    : arg4,
            treasury      : arg5,
            paused        : false,
            seals_sold    : 0,
            spice_sold    : 0,
            revenue_total : 0,
            rebate_total  : 0,
        };
        let v2 = 0x2::object::id<PaidMint>(&v1);
        let v3 = PaidMintOpened{
            id          : v2,
            pay_coin    : v1.pay_coin,
            seal_price  : arg2,
            spice_price : arg3,
            rebate_bps  : arg4,
            treasury    : arg5,
        };
        0x2::event::emit<PaidMintOpened>(v3);
        0x2::transfer::share_object<PaidMint>(v1);
        v2
    }

    public fun pay_coin(arg0: &PaidMint) : 0x1::ascii::String {
        arg0.pay_coin
    }

    public fun rebate_bps(arg0: &PaidMint) : u64 {
        arg0.rebate_bps
    }

    public fun rebate_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::bonding_curve::soos_for_quote((((arg0 as u128) * (arg1 as u128) / 10000) as u64), arg2)
    }

    public fun seal_price(arg0: &PaidMint) : u64 {
        arg0.seal_price
    }

    public fun seals_sold(arg0: &PaidMint) : u64 {
        arg0.seals_sold
    }

    public fun set_params(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut PaidMint, arg2: u64, arg3: u64, arg4: u64, arg5: address) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 <= 2000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        arg1.seal_price = arg2;
        arg1.spice_price = arg3;
        arg1.rebate_bps = arg4;
        arg1.treasury = arg5;
    }

    public fun set_paused(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut PaidMint, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun spice_price(arg0: &PaidMint) : u64 {
        arg0.spice_price
    }

    public fun spice_sold(arg0: &PaidMint) : u64 {
        arg0.spice_sold
    }

    public fun treasury(arg0: &PaidMint) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}


module 0x4255c692b44a43e903ebf13095cca7dea9ed636d485b706a0dd76246d5c93ef6::build_slot_royalties_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        min_amount: u64,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            min_amount : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun fee_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = (((arg1 as u128) * (v1.amount_bp as u128) / (10000 as u128)) as u64);
        let v3 = v2;
        if (v2 < v1.min_amount) {
            v3 = v1.min_amount;
        };
        v3
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x5a658961fdd5375a8723bf4445a341731ec069e5764937d132195c77e3b79c1a::marketplace::RoyaltiesInfo<T0>, arg3: &mut 0x4255c692b44a43e903ebf13095cca7dea9ed636d485b706a0dd76246d5c93ef6::royalties::RoyaltiesPool, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == fee_amount<T0>(arg0, 0x5a658961fdd5375a8723bf4445a341731ec069e5764937d132195c77e3b79c1a::marketplace::royalties_price<T0>(&arg2)), 1);
        0x4255c692b44a43e903ebf13095cca7dea9ed636d485b706a0dd76246d5c93ef6::royalties::add_to_balance_usdc(arg3, arg4);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    public fun pay_dmc<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x5a658961fdd5375a8723bf4445a341731ec069e5764937d132195c77e3b79c1a::marketplace::RoyaltiesInfo<T0>) {
        assert!(0x5a658961fdd5375a8723bf4445a341731ec069e5764937d132195c77e3b79c1a::marketplace::royalties_coin_type<T0>(&arg2) == 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>())), 2);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}


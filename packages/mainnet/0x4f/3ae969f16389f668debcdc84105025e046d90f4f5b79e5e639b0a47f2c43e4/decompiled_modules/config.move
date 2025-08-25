module 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        default_config: Config,
        partner_configs: 0x2::vec_map::VecMap<address, Config>,
    }

    struct Config has copy, drop, store {
        fee_rate: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float,
        max_amount: u64,
        total_amount: u64,
    }

    struct FlashMintReceipt {
        partner: 0x1::option::Option<address>,
        mint_amount: u64,
        fee_amount: u64,
    }

    public fun config(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : Config {
        if (0x1::option::is_some<address>(&arg1)) {
            *0x2::vec_map::get<address, Config>(&arg0.partner_configs, 0x1::option::borrow<address>(&arg1))
        } else {
            arg0.default_config
        }
    }

    fun err_exceed_max_amount() {
        abort 401
    }

    fun err_repayment_not_enough() {
        abort 402
    }

    public fun fee_amount(arg0: &FlashMintReceipt) : u64 {
        arg0.fee_amount
    }

    public fun fee_rate(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float {
        let v0 = config(arg0, arg1);
        v0.fee_rate
    }

    public fun flash_burn(arg0: &mut GlobalConfig, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, arg3: FlashMintReceipt) {
        let FlashMintReceipt {
            partner     : v0,
            mint_amount : v1,
            fee_amount  : v2,
        } = arg3;
        let v3 = v0;
        let v4 = if (0x1::option::is_some<address>(&v3)) {
            0x2::vec_map::get_mut<address, Config>(&mut arg0.partner_configs, 0x1::option::borrow<address>(&v3))
        } else {
            &mut arg0.default_config
        };
        if (0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&arg2) != v1 + v2) {
            err_repayment_not_enough();
        };
        v4.total_amount = v4.total_amount - v1;
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::burn<0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::BucketV2Flash>(arg1, 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::witness(), 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::version::package_version(), arg2);
        0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::collect<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB, 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::BucketV2Flash>(arg1, 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::witness(), 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::memo::flash_mint(), 0x2::balance::split<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(0x2::coin::balance_mut<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&mut arg2), v2));
    }

    public fun flash_mint(arg0: &mut GlobalConfig, arg1: &mut 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::Treasury, arg2: &0x1::option::Option<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, FlashMintReceipt) {
        let v0 = if (0x1::option::is_some<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest>(arg2)) {
            let v1 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::request_address(0x1::option::borrow<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest>(arg2));
            0x2::vec_map::get_mut<address, Config>(&mut arg0.partner_configs, &v1)
        } else {
            &mut arg0.default_config
        };
        v0.total_amount = v0.total_amount + arg3;
        if (v0.total_amount > v0.max_amount) {
            err_exceed_max_amount();
        };
        let v2 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::ceil(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::mul(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from(arg3), v0.fee_rate));
        let v3 = if (0x1::option::is_some<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest>(arg2)) {
            0x1::option::some<address>(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::request_address(0x1::option::borrow<0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::account::AccountRequest>(arg2)))
        } else {
            0x1::option::none<address>()
        };
        let v4 = FlashMintReceipt{
            partner     : v3,
            mint_amount : arg3,
            fee_amount  : v2,
        };
        0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::events::emit_flash_mint(v3, arg3, v2);
        (0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::mint<0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::BucketV2Flash>(arg1, 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness::witness(), 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::version::package_version(), arg3, arg4), v4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            fee_rate     : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(0),
            max_amount   : 0,
            total_amount : 0,
        };
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            default_config  : v0,
            partner_configs : 0x2::vec_map::empty<address, Config>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun max_amount(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : u64 {
        let v0 = config(arg0, arg1);
        v0.max_amount
    }

    public fun mint_amount(arg0: &FlashMintReceipt) : u64 {
        arg0.mint_amount
    }

    public fun set_flash_config(arg0: &mut GlobalConfig, arg1: &0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::admin::AdminCap, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) {
        if (0x1::option::is_some<address>(&arg2)) {
            let v0 = 0x1::option::borrow<address>(&arg2);
            if (0x2::vec_map::contains<address, Config>(&arg0.partner_configs, v0)) {
                let v1 = 0x2::vec_map::get_mut<address, Config>(&mut arg0.partner_configs, v0);
                v1.fee_rate = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg3);
                v1.max_amount = arg4;
            } else {
                let v2 = Config{
                    fee_rate     : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg3),
                    max_amount   : arg4,
                    total_amount : 0,
                };
                0x2::vec_map::insert<address, Config>(&mut arg0.partner_configs, *v0, v2);
            };
        } else {
            let v3 = &mut arg0.default_config;
            v3.fee_rate = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg3);
            v3.max_amount = arg4;
        };
        0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::events::emit_update_flash_mint_config(0x2::object::id<GlobalConfig>(arg0), arg2, arg3, arg4);
    }

    public fun total_amount(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : u64 {
        let v0 = config(arg0, arg1);
        v0.total_amount
    }

    // decompiled from Move bytecode v6
}


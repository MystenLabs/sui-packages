module 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        default_config: Config,
        partner_configs: 0x2::vec_map::VecMap<address, Config>,
    }

    struct Config has copy, drop, store {
        fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_amount: u64,
        total_amount: u64,
    }

    struct FlashMintReceipt {
        partner: 0x1::option::Option<address>,
        mint_amount: u64,
        fee_amount: u64,
    }

    public fun config(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : Config {
        if (0x1::option::is_some<address>(&arg1) && 0x2::vec_map::contains<address, Config>(&arg0.partner_configs, 0x1::option::borrow<address>(&arg1))) {
            *0x2::vec_map::get<address, Config>(&arg0.partner_configs, 0x1::option::borrow<address>(&arg1))
        } else {
            arg0.default_config
        }
    }

    fun borrow_config_mut(arg0: &mut GlobalConfig, arg1: 0x1::option::Option<address>) : &mut Config {
        if (0x1::option::is_some<address>(&arg1) && 0x2::vec_map::contains<address, Config>(&arg0.partner_configs, 0x1::option::borrow<address>(&arg1))) {
            0x2::vec_map::get_mut<address, Config>(&mut arg0.partner_configs, 0x1::option::borrow<address>(&arg1))
        } else {
            &mut arg0.default_config
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

    public fun fee_rate(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = config(arg0, arg1);
        v0.fee_rate
    }

    public fun flash_burn(arg0: &mut GlobalConfig, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: FlashMintReceipt) {
        let FlashMintReceipt {
            partner     : v0,
            mint_amount : v1,
            fee_amount  : v2,
        } = arg3;
        let v3 = borrow_config_mut(arg0, v0);
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg2) != v1 + v2) {
            err_repayment_not_enough();
        };
        v3.total_amount = v3.total_amount - v1;
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::BucketV2Flash>(arg1, 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::witness(), 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::version::package_version(), arg2);
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::BucketV2Flash>(arg1, 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::witness(), 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::memo::flash_mint(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg2), v2));
    }

    public fun flash_mint(arg0: &mut GlobalConfig, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, FlashMintReceipt) {
        let v0 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg2)) {
            0x1::option::some<address>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg2)))
        } else {
            0x1::option::none<address>()
        };
        let v1 = borrow_config_mut(arg0, v0);
        v1.total_amount = v1.total_amount + arg3;
        if (v1.total_amount > v1.max_amount) {
            err_exceed_max_amount();
        };
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg3), v1.fee_rate));
        let v3 = FlashMintReceipt{
            partner     : v0,
            mint_amount : arg3,
            fee_amount  : v2,
        };
        0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::events::emit_flash_mint(v0, arg3, v2);
        (0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::BucketV2Flash>(arg1, 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness::witness(), 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::version::package_version(), arg3, arg4), v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            fee_rate     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(0),
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

    public fun remove_flash_config(arg0: &mut GlobalConfig, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        if (0x2::vec_map::contains<address, Config>(&arg0.partner_configs, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, Config>(&mut arg0.partner_configs, &arg2);
        };
    }

    public fun set_flash_config(arg0: &mut GlobalConfig, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) {
        if (0x1::option::is_some<address>(&arg2) && !0x2::vec_map::contains<address, Config>(&arg0.partner_configs, 0x1::option::borrow<address>(&arg2))) {
            let v0 = Config{
                fee_rate     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3),
                max_amount   : arg4,
                total_amount : 0,
            };
            0x2::vec_map::insert<address, Config>(&mut arg0.partner_configs, 0x1::option::destroy_some<address>(arg2), v0);
        } else {
            let v1 = borrow_config_mut(arg0, arg2);
            v1.fee_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3);
            v1.max_amount = arg4;
        };
        0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::events::emit_update_flash_mint_config(0x2::object::id<GlobalConfig>(arg0), arg2, arg3, arg4);
    }

    public fun total_amount(arg0: &GlobalConfig, arg1: 0x1::option::Option<address>) : u64 {
        let v0 = config(arg0, arg1);
        v0.total_amount
    }

    // decompiled from Move bytecode v6
}


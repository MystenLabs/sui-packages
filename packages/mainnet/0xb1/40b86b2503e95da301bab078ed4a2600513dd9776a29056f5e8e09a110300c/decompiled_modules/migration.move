module 0xb140b86b2503e95da301bab078ed4a2600513dd9776a29056f5e8e09a110300c::migration {
    struct MigrationRule has drop {
        dummy_field: bool,
    }

    struct Privileges has key {
        id: 0x2::object::UID,
        flash_mint_config: 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>,
        v2_psm_partner: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
    }

    public fun flash_burn_buck(arg0: &mut Privileges, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &mut 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::config::GlobalConfig, arg4: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.v2_psm_partner));
        let (v1, v2) = 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::config::flash_mint(arg3, arg2, &v0, 0x1::u64::min(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::usdb_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg4), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir::pool_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_reservoir<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1))), arg6);
        let v3 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.v2_psm_partner));
        let v4 = MigrationRule{dummy_field: false};
        0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::config::flash_burn(arg3, arg2, 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, MigrationRule>(arg1, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg4, arg2, arg5, v1, &v3, arg6)), v4), arg6), v2);
    }

    public fun flash_burn_usdb(arg0: &mut Privileges, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg4: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt, arg5: u64) {
        let v0 = MigrationRule{dummy_field: false};
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir_by_partner<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, MigrationRule>(arg1, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg3), v0);
        let v2 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v1);
        if (v2 > arg5) {
            let v3 = MigrationRule{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MigrationRule>(arg2, v3, 0x1::string::utf8(b"leftover"), 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v1, v2 - arg5));
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg1, 0x1::option::borrow_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>(&mut arg0.flash_mint_config), v1, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Privileges{
            id                : 0x2::object::new(arg0),
            flash_mint_config : 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>(),
            v2_psm_partner    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg0),
        };
        0x2::transfer::share_object<Privileges>(v0);
    }

    public fun insert_flash_mint_config(arg0: &mut Privileges, arg1: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig) {
        0x1::option::fill<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>(&mut arg0.flash_mint_config, arg1);
    }

    public fun migrate<T0>(arg0: &mut Privileges, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg4: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &mut 0x2::tx_context::TxContext) : (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt, u64) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::position_exists<T0>(arg3, v0)) {
            let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg5);
            0x2::transfer::public_transfer<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(v2, 0x2::tx_context::sender(arg5));
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&v2)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg5)
        };
        let v3 = v1;
        let (_, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<T0>(arg1, v0, arg2);
        let (v6, v7) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg1, 0x1::option::borrow_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>(&mut arg0.flash_mint_config), v5);
        (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::debtor_request<T0>(arg3, &v3, arg4, 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_debt<T0>(arg1, v6, arg2, arg5), arg5), v5 / 1000 + 1, 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg5), 0), v7, v5)
    }

    public fun migrate_strap<T0>(arg0: &mut Privileges, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg4: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt, u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(&arg5);
        let v1 = if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::position_exists<T0>(arg3, v0)) {
            let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg6);
            0x2::transfer::public_transfer<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(v2, 0x2::tx_context::sender(arg6));
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&v2)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg6)
        };
        let v3 = v1;
        let (_, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<T0>(arg1, v0, arg2);
        let (v6, v7) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg1, 0x1::option::borrow_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig>(&mut arg0.flash_mint_config), v5);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::destroy_empty_strap<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg1), arg5);
        (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::debtor_request<T0>(arg3, &v3, arg4, 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_with_strap<T0>(arg1, &arg5, v6, arg2), arg6), v5 / 1000 + 1, 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg6), 0), v7, v5)
    }

    // decompiled from Move bytecode v6
}


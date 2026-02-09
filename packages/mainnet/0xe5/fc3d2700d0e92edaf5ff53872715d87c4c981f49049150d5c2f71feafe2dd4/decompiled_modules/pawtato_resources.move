module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources {
    struct PawtatoResources has key {
        id: 0x2::object::UID,
        treasury_caps: 0x2::bag::Bag,
        authorized_pools: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ResourcesAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PAWTATO_RESOURCES has drop {
        dummy_field: bool,
    }

    public fun add_treasury_cap<T0>(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::coin::TreasuryCap<T0>) {
        0x2::bag::add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_caps, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<T0>(), arg2);
    }

    public fun authorize_pool(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.authorized_pools, arg2, true);
    }

    public fun burn_coin<T0>(arg0: &mut PawtatoResources, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<T0>();
        if (v0 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        } else {
            assert!(0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
            0x2::coin::burn<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_caps, v0), arg1);
        };
    }

    public(friend) fun burn_dft_token(arg0: &mut PawtatoResources, arg1: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>();
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
        0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::burn_dft(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>>(&mut arg0.treasury_caps, v0), arg1, arg2);
    }

    public fun burn_dft_token_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut PawtatoResources, arg2: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        burn_dft_token(arg1, arg2, arg3);
    }

    public entry fun deposit_tato_to_bag(arg0: &mut PawtatoResources, arg1: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::bag::Bag>(&arg0.id, b"tato_coin_bag")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::bag::Bag>(&mut arg0.id, b"tato_coin_bag", 0x2::bag::new(arg2));
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::bag::Bag>(&mut arg0.id, b"tato_coin_bag");
        if (0x2::bag::contains<vector<u8>>(v0, b"tato")) {
            0x2::coin::join<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(v0, b"tato"), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(v0, b"tato", arg1);
        };
    }

    public fun eject_treasury_cap<T0>(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(&arg1.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(0x2::bag::remove<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_caps, v0), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun get_coin_type_by_resource_type(arg0: u8) : 0x1::string::String {
        let v0 = &arg0;
        let v1 = 1;
        if (v0 == &v1) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>()
        } else {
            let v3 = 2;
            if (v0 == &v3) {
                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>()
            } else {
                let v4 = 3;
                if (v0 == &v4) {
                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>()
                } else {
                    let v5 = 4;
                    if (v0 == &v5) {
                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>()
                    } else {
                        let v6 = 5;
                        if (v0 == &v6) {
                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>()
                        } else {
                            let v7 = 6;
                            if (v0 == &v7) {
                                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>()
                            } else {
                                let v8 = 7;
                                if (v0 == &v8) {
                                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>()
                                } else {
                                    let v9 = 8;
                                    if (v0 == &v9) {
                                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>()
                                    } else {
                                        let v10 = 9;
                                        if (v0 == &v10) {
                                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>()
                                        } else {
                                            let v11 = 10;
                                            if (v0 == &v11) {
                                                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>()
                                            } else {
                                                let v12 = 11;
                                                if (v0 == &v12) {
                                                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>()
                                                } else {
                                                    let v13 = 12;
                                                    if (v0 == &v13) {
                                                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>()
                                                    } else {
                                                        let v14 = 13;
                                                        if (v0 == &v14) {
                                                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>()
                                                        } else {
                                                            let v15 = 14;
                                                            if (v0 == &v15) {
                                                                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>()
                                                            } else {
                                                                let v16 = 16;
                                                                if (v0 == &v16) {
                                                                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>()
                                                                } else {
                                                                    let v17 = 17;
                                                                    if (v0 == &v17) {
                                                                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM>()
                                                                    } else {
                                                                        let v18 = 18;
                                                                        if (v0 == &v18) {
                                                                            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>()
                                                                        } else {
                                                                            let v19 = 19;
                                                                            if (v0 == &v19) {
                                                                                0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM>()
                                                                            } else {
                                                                                let v20 = 20;
                                                                                if (v0 == &v20) {
                                                                                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>()
                                                                                } else {
                                                                                    let v21 = 21;
                                                                                    if (v0 == &v21) {
                                                                                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>()
                                                                                    } else {
                                                                                        let v22 = 22;
                                                                                        assert!(v0 == &v22, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function());
                                                                                        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>()
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public fun has_treasury_cap<T0>(arg0: &PawtatoResources) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<T0>())
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_pool_authorized(arg0: &PawtatoResources, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.authorized_pools, arg1)
    }

    public(friend) fun mint_chaos_seed(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED> {
        mint_coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coal(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL> {
        mint_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coin<T0>(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.authorized_pools, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unauthorized_pool_to_mint());
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<T0>();
        assert!(v0 != 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(), 1003);
        if (v0 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>()) {
            assert!(0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::bag::Bag>(&arg0.id, b"tato_coin_bag"), 1001);
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::bag::Bag>(&mut arg0.id, b"tato_coin_bag");
            assert!(0x2::bag::contains<vector<u8>>(v2, b"tato"), 1001);
            let v3 = 0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(v2, b"tato");
            assert!(0x2::coin::value<T0>(v3) >= arg2, 1002);
            0x2::coin::split<T0>(v3, arg2, arg3)
        } else {
            assert!(0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
            0x2::coin::mint<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_caps, v0), arg2, arg3)
        }
    }

    public fun mint_coin_with_cap<T0>(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        mint_coin<T0>(arg1, arg2, arg3, arg4)
    }

    public(friend) fun mint_crystal(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL> {
        mint_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_dawnstone(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE> {
        mint_coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_dft_reward(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.authorized_pools, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unauthorized_pool_to_mint());
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>();
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
        0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::mint_dft(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>>(&mut arg0.treasury_caps, v0), arg2, arg3, arg4);
    }

    public fun mint_dft_with_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        mint_dft_reward(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun mint_gilded_prism(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM> {
        mint_coin<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD> {
        mint_coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR> {
        mint_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON> {
        mint_coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR> {
        mint_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_q_rune(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE> {
        mint_coin<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_phoenix_feather(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER> {
        mint_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_primal_loam(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM> {
        mint_coin<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE> {
        mint_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone_block(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK> {
        mint_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone_q_rune(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE> {
        mint_coin<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_titanium_splinter(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER> {
        mint_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_water(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER> {
        mint_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wood(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD> {
        mint_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wooden_plank(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK> {
        mint_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wooden_q_rune(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE> {
        mint_coin<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>(arg0, arg1, arg2, arg3)
    }

    public fun resource_type_barrier_shard() : u8 {
        25
    }

    public fun resource_type_chaos_seed() : u8 {
        10
    }

    public fun resource_type_chrono_seed() : u8 {
        23
    }

    public fun resource_type_coal() : u8 {
        4
    }

    public fun resource_type_crystal() : u8 {
        9
    }

    public fun resource_type_dawnstone() : u8 {
        16
    }

    public fun resource_type_divine_favor_token() : u8 {
        18
    }

    public fun resource_type_fairy_dust() : u8 {
        24
    }

    public fun resource_type_frgmnt_awakening() : u8 {
        36
    }

    public fun resource_type_frgmnt_eternity() : u8 {
        34
    }

    public fun resource_type_frgmnt_focus() : u8 {
        27
    }

    public fun resource_type_frgmnt_genesis() : u8 {
        32
    }

    public fun resource_type_frgmnt_harmony() : u8 {
        28
    }

    public fun resource_type_frgmnt_insight() : u8 {
        30
    }

    public fun resource_type_frgmnt_oblivion() : u8 {
        33
    }

    public fun resource_type_frgmnt_resolve() : u8 {
        26
    }

    public fun resource_type_frgmnt_transcendence() : u8 {
        37
    }

    public fun resource_type_frgmnt_unity() : u8 {
        31
    }

    public fun resource_type_frgmnt_veil() : u8 {
        35
    }

    public fun resource_type_frgmnt_vigor() : u8 {
        29
    }

    public fun resource_type_gilded_prism() : u8 {
        19
    }

    public fun resource_type_gold() : u8 {
        7
    }

    public fun resource_type_gold_bar() : u8 {
        8
    }

    public fun resource_type_gravel() : u8 {
        63
    }

    public fun resource_type_iron() : u8 {
        5
    }

    public fun resource_type_iron_bar() : u8 {
        6
    }

    public fun resource_type_iron_q_rune() : u8 {
        22
    }

    public fun resource_type_paper() : u8 {
        62
    }

    public fun resource_type_phoenix_feather() : u8 {
        11
    }

    public fun resource_type_primal_loam() : u8 {
        17
    }

    public fun resource_type_stone() : u8 {
        2
    }

    public fun resource_type_stone_block() : u8 {
        14
    }

    public fun resource_type_stone_q_rune() : u8 {
        21
    }

    public fun resource_type_titanium_splinter() : u8 {
        12
    }

    public fun resource_type_water() : u8 {
        3
    }

    public fun resource_type_wood() : u8 {
        1
    }

    public fun resource_type_wooden_plank() : u8 {
        13
    }

    public fun resource_type_wooden_q_rune() : u8 {
        20
    }

    public fun revoke_pool_authorization(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.authorized_pools, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.authorized_pools, arg2);
        };
    }

    public entry fun set_coin_types_bulk(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"coin_types")) {
            0x2::dynamic_field::remove<vector<u8>, vector<0x1::string::String>>(&mut arg1.id, b"coin_types");
        };
        0x2::dynamic_field::add<vector<u8>, vector<0x1::string::String>>(&mut arg1.id, b"coin_types", arg2);
    }

    public fun transfer_chaos_seed(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed::PAWTATO_CHAOS_SEED>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_chaos_seed_new(arg0: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>>(arg0, arg1);
    }

    public fun transfer_coal(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_coal_new(arg0: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>>(arg0, arg1);
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_crystal(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_crystal::PAWTATO_CRYSTAL>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_crystal_new(arg0: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>>(arg0, arg1);
    }

    public fun transfer_dawnstone_new(arg0: 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>>(arg0, arg1);
    }

    public fun transfer_gilded_prism_new(arg0: 0x2::coin::Coin<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism::PAWTATO_COIN_GILDED_PRISM>>(arg0, arg1);
    }

    public fun transfer_gold(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_gold_bar(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_gold_bar_new(arg0: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>>(arg0, arg1);
    }

    public fun transfer_gold_new(arg0: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>>(arg0, arg1);
    }

    public fun transfer_iron(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_iron_bar(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_iron_bar_new(arg0: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>>(arg0, arg1);
    }

    public fun transfer_iron_new(arg0: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>>(arg0, arg1);
    }

    public fun transfer_iron_q_rune_new(arg0: 0x2::coin::Coin<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>>(arg0, arg1);
    }

    public fun transfer_phoenix_feather(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_phoenix_feather_new(arg0: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>>(arg0, arg1);
    }

    public fun transfer_primal_loam_new(arg0: 0x2::coin::Coin<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam::PAWTATO_COIN_PRIMAL_LOAM>>(arg0, arg1);
    }

    public fun transfer_stone(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_stone_block_new(arg0: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>>(arg0, arg1);
    }

    public fun transfer_stone_new(arg0: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>>(arg0, arg1);
    }

    public fun transfer_stone_q_rune_new(arg0: 0x2::coin::Coin<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>>(arg0, arg1);
    }

    public fun transfer_titanium_splinter(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_titanium_splinter_new(arg0: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>>(arg0, arg1);
    }

    public fun transfer_water(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_water_new(arg0: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>>(arg0, arg1);
    }

    public fun transfer_wood(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD>, arg1: address) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun transfer_wood_new(arg0: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>>(arg0, arg1);
    }

    public fun transfer_wooden_plank_new(arg0: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>>(arg0, arg1);
    }

    public fun transfer_wooden_q_rune_new(arg0: 0x2::coin::Coin<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>>(arg0, arg1);
    }

    public fun validate_coin_type<T0>(arg0: &PawtatoResources, arg1: u64) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"coin_types"), 1004);
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, vector<0x1::string::String>>(&arg0.id, b"coin_types");
        assert!(0x1::vector::length<0x1::string::String>(v0) > arg1, 1005);
        let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        assert!(0x1::vector::borrow<0x1::string::String>(v0, arg1) == &v1, 1005);
    }

    // decompiled from Move bytecode v6
}


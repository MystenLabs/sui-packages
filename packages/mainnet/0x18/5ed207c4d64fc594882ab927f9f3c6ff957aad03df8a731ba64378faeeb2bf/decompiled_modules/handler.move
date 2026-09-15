module 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::handler {
    struct Auth has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg1: 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::BurnReceipt<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::CompleteBurnTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, Auth> {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg0));
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap_is_set(arg0), 0);
        let (_, v1, _) = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::get_burn_details<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v1, 1);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::burn<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap(arg0), arg3, arg2, arg5);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_complete_burn_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, Auth>(arg1, new())
    }

    public fun mint(arg0: &0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg1: 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::MintReceipt<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::deny_list::DenyList, arg5: &mut 0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::CompleteMintTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, Auth> {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg0));
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap_is_set(arg0), 0);
        let (_, v1, v2, v3) = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::get_mint_details<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        let v4 = 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap(arg0);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::mint<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v4, arg4, v2, v1, arg5);
        if (v3 > 0) {
            0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::mint<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v4, arg4, v3, 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::fee_recipient(arg2), arg5);
        };
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::create_complete_mint_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, Auth>(arg1, new())
    }

    public(friend) fun new() : Auth {
        Auth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}


module 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::mint_controller {
    struct MintCapAdded has copy, drop {
        mint_cap_id: 0x2::object::ID,
    }

    struct MintCapRemoved has copy, drop {
        mint_cap_id: 0x2::object::ID,
    }

    entry fun add_mint_cap(arg0: 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg2: &0x2::tx_context::TxContext) {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg1));
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::mint_controller(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles(arg1)) == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap_is_set(arg1), 1);
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::set_mint_cap(arg1, arg0);
        let v0 = MintCapAdded{mint_cap_id: 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0)};
        0x2::event::emit<MintCapAdded>(v0);
    }

    entry fun remove_mint_cap(arg0: &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg1: &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::tx_context::TxContext) {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg0));
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::mint_controller(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles(arg0)) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap_is_set(arg0), 2);
        assert!(!0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::is_authorized_mint_cap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::mint_cap(arg0))), 3);
        let v0 = 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::remove_mint_cap(arg0);
        let v1 = MintCapRemoved{mint_cap_id: 0x2::object::id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v0)};
        0x2::event::emit<MintCapRemoved>(v1);
        0x2::transfer::public_transfer<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}


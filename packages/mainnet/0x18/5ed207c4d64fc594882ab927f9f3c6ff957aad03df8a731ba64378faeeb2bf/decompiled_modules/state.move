module 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state {
    struct State has key {
        id: 0x2::object::UID,
        roles: 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::Roles,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
        mint_cap: 0x1::option::Option<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                  : 0x2::object::new(arg1),
            roles               : 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::new(arg0, arg0, arg1),
            compatible_versions : 0x2::vec_set::singleton<u64>(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::current_version()),
            mint_cap            : 0x1::option::none<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(),
        }
    }

    public fun roles(arg0: &State) : &0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::Roles {
        &arg0.roles
    }

    public(friend) fun add_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public fun compatible_versions(arg0: &State) : &0x2::vec_set::VecSet<u64> {
        &arg0.compatible_versions
    }

    public(friend) fun mint_cap(arg0: &State) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x1::option::borrow<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0.mint_cap)
    }

    public fun mint_cap_is_set(arg0: &State) : bool {
        0x1::option::is_some<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0.mint_cap)
    }

    public(friend) fun remove_compatible_version(arg0: &mut State, arg1: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public(friend) fun remove_mint_cap(arg0: &mut State) : 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x1::option::extract<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.mint_cap)
    }

    public(friend) fun roles_mut(arg0: &mut State) : &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::Roles {
        &mut arg0.roles
    }

    public(friend) fun set_mint_cap(arg0: &mut State, arg1: 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x1::option::fill<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.mint_cap, arg1);
    }

    public(friend) fun share_state(arg0: State) {
        0x2::transfer::share_object<State>(arg0);
    }

    // decompiled from Move bytecode v7
}


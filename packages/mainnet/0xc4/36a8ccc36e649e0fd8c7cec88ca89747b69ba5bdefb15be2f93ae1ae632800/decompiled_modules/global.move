module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global {
    struct Global has store, key {
        id: 0x2::object::UID,
        version: u64,
        treasury_cap: 0x2::coin::TreasuryCap<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        vault_registries: 0x2::table::Table<u64, 0x2::object::ID>,
        vault_registries_counter: u64,
        dori_fee_vault: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault::FeeVault<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        is_init: bool,
    }

    public(friend) fun add_registry(arg0: &mut Global, arg1: 0x2::object::ID) {
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.vault_registries, arg0.vault_registries_counter, arg1);
        arg0.vault_registries_counter = arg0.vault_registries_counter + 1;
    }

    public fun assert_version(arg0: &Global) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    public(friend) fun burn_dori_coin(arg0: &mut Global, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>) : u64 {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::burn(&mut arg0.treasury_cap, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_global_burn(v0);
        v0
    }

    public(friend) fun create_global(arg0: 0x2::coin::TreasuryCap<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                       : 0x2::object::new(arg1),
            version                  : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            treasury_cap             : arg0,
            vault_registries         : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            vault_registries_counter : 0,
            dori_fee_vault           : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault::create_fee_vault<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1),
            is_init                  : true,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun get_total_dori_total_supply(arg0: &Global) : u64 {
        0x2::coin::total_supply<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.treasury_cap)
    }

    public fun get_treasury_dori_balance(arg0: &Global) : u64 {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault::intern_get_fee_vault_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_fee_vault)
    }

    entry fun migrate(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut Global) {
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    public(friend) fun mint_dori_and_return_coin(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_global_mint_dori_sp(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::mint_and_return_coin_dori(&mut arg0.treasury_cap, arg1, arg2)
    }

    public(friend) fun mint_dori_and_transfer(arg0: &mut Global, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::mint(&mut arg0.treasury_cap, arg1, arg2, arg3);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_global_mint_and_transfer(arg1);
    }

    public(friend) fun mint_dori_fee_vault(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault::intern_fee_vault_add_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_fee_vault, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::mint_and_return_coin_dori(&mut arg0.treasury_cap, arg1, arg2)));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_global_mint_dori_fee_vault(arg1);
    }

    public entry fun withdraw_fee_vault_balance(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut Global, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault::intern_withdraw_fee_vault_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0, &mut arg1.dori_fee_vault, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}


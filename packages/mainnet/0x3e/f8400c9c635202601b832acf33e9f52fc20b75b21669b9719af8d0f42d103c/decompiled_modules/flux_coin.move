module 0x3ef8400c9c635202601b832acf33e9f52fc20b75b21669b9719af8d0f42d103c::flux_coin {
    struct FLUX_COIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        minter_id: address,
    }

    struct TaxConfig has store {
        buy_tax_rate: u64,
        sell_tax_rate: u64,
        transfer_tax_rate: u64,
        tax_recipient: address,
        tax_enabled: bool,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        tax_config: TaxConfig,
        is_minting_allowed: bool,
        whitelist: 0x2::table::Table<address, bool>,
        revoked_minters: 0x2::vec_set::VecSet<address>,
    }

    struct TokensMinted has copy, drop {
        minter: address,
        recipient: address,
        amount: u64,
    }

    struct TokensBurned has copy, drop {
        burner: address,
        amount: u64,
    }

    struct TaxRatesChanged has copy, drop {
        buy_tax_rate: u64,
        sell_tax_rate: u64,
        transfer_tax_rate: u64,
    }

    struct TaxEnabledChanged has copy, drop {
        enabled: bool,
    }

    struct AddressWhitelisted has copy, drop {
        address: address,
    }

    struct AddressRemovedFromWhitelist has copy, drop {
        address: address,
    }

    struct MinterAdded has copy, drop {
        minter: address,
    }

    struct MinterRevoked has copy, drop {
        minter: address,
    }

    struct OwnershipRenounced has copy, drop {
        admin: address,
    }

    public entry fun burn(arg0: 0x2::coin::Coin<FLUX_COIN>, arg1: &mut 0x2::coin::TreasuryCap<FLUX_COIN>, arg2: &mut GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<FLUX_COIN>(&arg0);
        assert!(v0 > 0, 9);
        arg2.total_supply = arg2.total_supply - v0;
        0x2::coin::burn<FLUX_COIN>(arg1, arg0);
        let v1 = TokensBurned{
            burner : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public entry fun mint(arg0: &MinterCap, arg1: &mut 0x2::coin::TreasuryCap<FLUX_COIN>, arg2: &mut GlobalConfig, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_set::contains<address>(&arg2.revoked_minters, &arg0.minter_id), 8);
        assert!(arg2.is_minting_allowed, 1);
        let v0 = arg2.total_supply + arg3;
        assert!(v0 <= 1000000000000000000, 3);
        arg2.total_supply = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUX_COIN>>(0x2::coin::mint<FLUX_COIN>(arg1, arg3, arg5), arg4);
        let v1 = TokensMinted{
            minter    : 0x2::tx_context::sender(arg5),
            recipient : arg4,
            amount    : arg3,
        };
        0x2::event::emit<TokensMinted>(v1);
    }

    public entry fun add_minter(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{
            id        : 0x2::object::new(arg2),
            minter_id : arg1,
        };
        0x2::transfer::public_transfer<MinterCap>(v0, arg1);
        let v1 = MinterAdded{minter: arg1};
        0x2::event::emit<MinterAdded>(v1);
    }

    public entry fun add_to_whitelist(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert!(!0x2::table::contains<address, bool>(&arg1.whitelist, arg2), 5);
        0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, true);
        let v0 = AddressWhitelisted{address: arg2};
        0x2::event::emit<AddressWhitelisted>(v0);
    }

    public fun calculate_tax(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun get_tax_config(arg0: &GlobalConfig) : (u64, u64, u64, address, bool) {
        (arg0.tax_config.buy_tax_rate, arg0.tax_config.sell_tax_rate, arg0.tax_config.transfer_tax_rate, arg0.tax_config.tax_recipient, arg0.tax_config.tax_enabled)
    }

    fun init(arg0: FLUX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUX_COIN>(arg0, 9, b"FLUX", b"Flux Zone", b"Core of Flux Zone. Innovative DeFi token on Sui Network for staking and cutting-edge features", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://bafkreiaog5tkmv2gfdtrgtazwcb3up4stev2teoot5gbvuooatt473qygu"))), arg1);
        let v2 = v0;
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = TaxConfig{
            buy_tax_rate      : 0,
            sell_tax_rate     : 0,
            transfer_tax_rate : 0,
            tax_recipient     : 0x2::tx_context::sender(arg1),
            tax_enabled       : false,
        };
        let v5 = GlobalConfig{
            id                 : 0x2::object::new(arg1),
            total_supply       : 0,
            tax_config         : v4,
            is_minting_allowed : true,
            whitelist          : 0x2::table::new<address, bool>(arg1),
            revoked_minters    : 0x2::vec_set::empty<address>(),
        };
        let v6 = 25000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUX_COIN>>(0x2::coin::mint<FLUX_COIN>(&mut v2, v6, arg1), 0x2::tx_context::sender(arg1));
        v5.total_supply = v6;
        let v7 = MinterCap{
            id        : 0x2::object::new(arg1),
            minter_id : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUX_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUX_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<GlobalConfig>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MinterCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun is_minter_revoked(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.revoked_minters, &arg1)
    }

    public fun is_minting_allowed(arg0: &GlobalConfig) : bool {
        arg0.is_minting_allowed
    }

    public fun is_tax_enabled(arg0: &GlobalConfig) : bool {
        arg0.tax_config.tax_enabled
    }

    public fun is_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public entry fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert!(0x2::table::contains<address, bool>(&arg1.whitelist, arg2), 6);
        0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
        let v0 = AddressRemovedFromWhitelist{address: arg2};
        0x2::event::emit<AddressRemovedFromWhitelist>(v0);
    }

    public entry fun renounce_ownership(arg0: AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_minting_allowed = false;
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = OwnershipRenounced{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<OwnershipRenounced>(v1);
    }

    public entry fun revoke_minter(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg1.revoked_minters, &arg2), 2);
        0x2::vec_set::insert<address>(&mut arg1.revoked_minters, arg2);
        let v0 = MinterRevoked{minter: arg2};
        0x2::event::emit<MinterRevoked>(v0);
    }

    public entry fun set_tax_enabled(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.tax_config.tax_enabled = arg2;
        let v0 = TaxEnabledChanged{enabled: arg2};
        0x2::event::emit<TaxEnabledChanged>(v0);
    }

    public entry fun set_tax_rates(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 1000, 4);
        assert!(arg3 <= 1000, 4);
        assert!(arg4 <= 1000, 4);
        arg1.tax_config.buy_tax_rate = arg2;
        arg1.tax_config.sell_tax_rate = arg3;
        arg1.tax_config.transfer_tax_rate = arg4;
        arg1.tax_config.tax_enabled = true;
        let v0 = TaxRatesChanged{
            buy_tax_rate      : arg2,
            sell_tax_rate     : arg3,
            transfer_tax_rate : arg4,
        };
        0x2::event::emit<TaxRatesChanged>(v0);
    }

    public entry fun set_tax_recipient(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.tax_config.tax_recipient = arg2;
    }

    public fun total_supply(arg0: &GlobalConfig) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}


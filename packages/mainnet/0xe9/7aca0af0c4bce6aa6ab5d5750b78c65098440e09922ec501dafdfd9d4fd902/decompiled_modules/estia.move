module 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia {
    struct ESTIA has drop {
        dummy_field: bool,
    }

    struct Central has store, key {
        id: 0x2::object::UID,
        cashback_vault: 0x2::balance::Balance<ESTIA>,
        main_vault: 0x2::balance::Balance<ESTIA>,
        incentives_vault: 0x2::balance::Balance<ESTIA>,
        ecosystem_vault: 0x2::balance::Balance<ESTIA>,
        liquidity_vault: 0x2::balance::Balance<ESTIA>,
        team_vault: 0x2::balance::Balance<ESTIA>,
        is_distributed: bool,
        operator: address,
        version: u64,
    }

    public fun cashback_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.cashback_vault)
    }

    public(friend) fun deposit_to_cashback(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.cashback_vault, arg1);
    }

    public(friend) fun deposit_to_ecosystem(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.ecosystem_vault, arg1);
    }

    public(friend) fun deposit_to_incentives(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.incentives_vault, arg1);
    }

    public(friend) fun deposit_to_liquidity(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.liquidity_vault, arg1);
    }

    public(friend) fun deposit_to_main(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.main_vault, arg1);
    }

    public(friend) fun deposit_to_team(arg0: &mut Central, arg1: 0x2::balance::Balance<ESTIA>) {
        0x2::balance::join<ESTIA>(&mut arg0.team_vault, arg1);
    }

    public fun ecosystem_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.ecosystem_vault)
    }

    public(friend) fun end_distribution(arg0: &mut Central) {
        arg0.is_distributed = true;
    }

    public fun incentives_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.incentives_vault)
    }

    fun init(arg0: ESTIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ESTIA>(arg0, 9, 0x1::string::utf8(b"ESTIA"), 0x1::string::utf8(b"Estia"), 0x1::string::utf8(b""), 0x1::string::utf8(b"estia.com/icon"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ESTIA>(&mut v3, v2);
        let v4 = Central{
            id               : 0x2::object::new(arg1),
            cashback_vault   : 0x2::balance::zero<ESTIA>(),
            main_vault       : 0x2::coin::mint_balance<ESTIA>(&mut v2, 260000000000000000),
            incentives_vault : 0x2::balance::zero<ESTIA>(),
            ecosystem_vault  : 0x2::balance::zero<ESTIA>(),
            liquidity_vault  : 0x2::balance::zero<ESTIA>(),
            team_vault       : 0x2::balance::zero<ESTIA>(),
            is_distributed   : false,
            operator         : 0x2::tx_context::sender(arg1),
            version          : 0,
        };
        0x2::transfer::public_share_object<Central>(v4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ESTIA>>(0x2::coin_registry::finalize<ESTIA>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_distributed(arg0: &Central) : bool {
        arg0.is_distributed
    }

    public fun liquidity_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.liquidity_vault)
    }

    public fun main_vault_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.main_vault)
    }

    public(friend) fun migrate(arg0: &mut Central, arg1: u64) {
        arg0.version = arg1;
    }

    public fun operator(arg0: &Central) : address {
        arg0.operator
    }

    public fun set_operator(arg0: &mut Central, arg1: address, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        arg0.operator = arg1;
    }

    public(friend) fun split_from_cashback(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(0x2::balance::value<ESTIA>(&arg0.cashback_vault) >= arg1, 100);
        0x2::balance::split<ESTIA>(&mut arg0.cashback_vault, arg1)
    }

    public(friend) fun split_from_main(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(0x2::balance::value<ESTIA>(&arg0.main_vault) >= arg1, 100);
        0x2::balance::split<ESTIA>(&mut arg0.main_vault, arg1)
    }

    public(friend) fun take_from_ecosystem(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(arg1 <= 0x2::balance::value<ESTIA>(&arg0.ecosystem_vault), 100);
        0x2::balance::split<ESTIA>(&mut arg0.ecosystem_vault, arg1)
    }

    public(friend) fun take_from_incentives(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(arg1 <= 0x2::balance::value<ESTIA>(&arg0.incentives_vault), 100);
        0x2::balance::split<ESTIA>(&mut arg0.incentives_vault, arg1)
    }

    public(friend) fun take_from_liquidity(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(arg1 <= 0x2::balance::value<ESTIA>(&arg0.liquidity_vault), 100);
        0x2::balance::split<ESTIA>(&mut arg0.liquidity_vault, arg1)
    }

    public(friend) fun take_from_team(arg0: &mut Central, arg1: u64) : 0x2::balance::Balance<ESTIA> {
        assert!(arg1 <= 0x2::balance::value<ESTIA>(&arg0.team_vault), 100);
        0x2::balance::split<ESTIA>(&mut arg0.team_vault, arg1)
    }

    public fun team_total(arg0: &Central) : u64 {
        0x2::balance::value<ESTIA>(&arg0.team_vault)
    }

    public fun version(arg0: &Central) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}


module 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_config {
    struct ConfigAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        mint_total_supply: u64,
        mint_decimal: u8,
        mint_fee: u64,
        swap_fee_numerator: u64,
        swap_fee_denominator: u64,
        protocol_fee_numerator: u64,
        protocol_fee_denominator: u64,
        protocol_fee_switch: bool,
        minimum_swap_amount: u64,
    }

    public fun get_minimum_swap_amount(arg0: &Config) : u64 {
        arg0.minimum_swap_amount
    }

    public fun get_mint_decimal(arg0: &Config) : u8 {
        arg0.mint_decimal
    }

    public fun get_mint_fee(arg0: &Config) : u64 {
        arg0.mint_fee
    }

    public fun get_mint_total_supply(arg0: &Config) : u64 {
        arg0.mint_total_supply
    }

    public fun get_protocol_fee(arg0: &Config) : (u64, u64) {
        (arg0.protocol_fee_numerator, arg0.protocol_fee_denominator)
    }

    public fun get_protocol_fee_switch(arg0: &Config) : bool {
        arg0.protocol_fee_switch
    }

    public fun get_swap_fee(arg0: &Config) : (u64, u64) {
        (arg0.swap_fee_numerator, arg0.swap_fee_denominator)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ConfigAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id                       : 0x2::object::new(arg0),
            mint_total_supply        : 1000000000000000000,
            mint_decimal             : 18,
            mint_fee                 : 1000,
            swap_fee_numerator       : 3,
            swap_fee_denominator     : 1000,
            protocol_fee_numerator   : 1,
            protocol_fee_denominator : 1,
            protocol_fee_switch      : false,
            minimum_swap_amount      : 1000,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    entry fun set_minimum_swap_amount(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u64) {
        arg1.minimum_swap_amount = arg2;
    }

    entry fun set_mint_decimal(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u8) {
        arg1.mint_decimal = arg2;
    }

    entry fun set_mint_fee(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u64) {
        arg1.mint_fee = arg2;
    }

    entry fun set_mint_total_supply(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u64) {
        arg1.mint_total_supply = arg2;
    }

    entry fun set_protocol_fee(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.protocol_fee_numerator = arg2;
        arg1.protocol_fee_denominator = arg3;
    }

    entry fun set_protocol_fee_switch(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: bool) {
        arg1.protocol_fee_switch = arg2;
    }

    entry fun set_swap_fee(arg0: &ConfigAdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.swap_fee_numerator = arg2;
        arg1.swap_fee_denominator = arg3;
    }

    // decompiled from Move bytecode v6
}


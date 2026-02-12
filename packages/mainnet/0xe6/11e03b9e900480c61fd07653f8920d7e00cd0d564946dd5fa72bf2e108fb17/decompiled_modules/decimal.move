module 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::decimal {
    public fun register_decimals<T0>(arg0: &0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::DragonBallCollector, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_can_summon_shenron(arg0);
        0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::decimals_admin::register_decimals<T0>(0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


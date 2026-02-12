module 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::decimal {
    public fun register_decimals<T0>(arg0: &0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::decimals_admin::register_decimals<T0>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


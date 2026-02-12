module 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::DragonBallCollector, arg1: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::ProtocolApp, arg2: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_can_summon_shenron(arg0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::revenue_admin::take_revenue<T0, T1>(0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}


module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_admin {
    public fun onboard_market<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::emode::ensure_group_exists(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::emode_registry<T0>(arg1), arg2);
        0x2::transfer::public_share_object<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::LeverageMarket>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::new_market(*0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::id<T0>(arg1), arg2, arg3));
    }

    // decompiled from Move bytecode v6
}


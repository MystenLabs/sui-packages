module 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle_utils {
    public fun get_amount(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) : u64 {
        (((arg2 as u256) * (0x2::math::pow(10, 0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::get_coin_decimals(arg4, arg1)) as u256) / (0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::get_price(arg0, arg3, arg1, arg5) as u256)) as u64)
    }

    public fun get_usd_value(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) : u64 {
        (((0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::get_price(arg0, arg3, arg1, arg5) as u256) * (arg2 as u256) / (0x2::math::pow(10, 0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::get_coin_decimals(arg4, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}


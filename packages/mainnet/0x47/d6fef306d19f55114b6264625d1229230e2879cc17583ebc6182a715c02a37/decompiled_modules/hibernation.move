module 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::Pool<T0, T1>) {
        0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::Pool<T0, T1>, arg1: &0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::config::Config, arg2: &0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}


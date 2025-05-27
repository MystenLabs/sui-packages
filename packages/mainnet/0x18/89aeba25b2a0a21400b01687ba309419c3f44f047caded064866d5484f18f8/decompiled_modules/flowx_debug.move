module 0x1889aeba25b2a0a21400b01687ba309419c3f44f047caded064866d5484f18f8::flowx_debug {
    struct FetchBitmapResutlEvent has copy, drop {
        bitmap: u64,
    }

    struct Tick {
        index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        liquidity_net: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::I128,
    }

    struct FetchTicksResutlEvent has copy, drop {
        dummy_field: bool,
    }

    public fun fetch_ticks<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>) : FetchBitmapResutlEvent {
        abort 0
    }

    // decompiled from Move bytecode v6
}


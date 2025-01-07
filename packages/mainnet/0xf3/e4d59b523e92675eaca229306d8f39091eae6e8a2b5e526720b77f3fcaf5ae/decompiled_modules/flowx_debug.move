module 0xf3e4d59b523e92675eaca229306d8f39091eae6e8a2b5e526720b77f3fcaf5ae::flowx_debug {
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


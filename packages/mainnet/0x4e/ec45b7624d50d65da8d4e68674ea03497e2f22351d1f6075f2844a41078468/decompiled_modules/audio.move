module 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio {
    struct Audio<phantom T0, T1: drop + store, T2: drop + store> has drop, store {
        format: T1,
        layout: T2,
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
    }

    public fun data<T0, T1: drop + store, T2: drop + store>(arg0: &Audio<T0, T1, T2>) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob {
        &arg0.data
    }

    public fun format<T0, T1: drop + store, T2: drop + store>(arg0: &Audio<T0, T1, T2>) : &T1 {
        &arg0.format
    }

    public fun layout<T0, T1: drop + store, T2: drop + store>(arg0: &Audio<T0, T1, T2>) : &T2 {
        &arg0.layout
    }

    public fun new<T0: drop, T1: drop + store, T2: drop + store>(arg0: T0, arg1: T1, arg2: T2, arg3: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob) : Audio<T0, T1, T2> {
        Audio<T0, T1, T2>{
            format : arg1,
            layout : arg2,
            data   : arg3,
        }
    }

    // decompiled from Move bytecode v7
}


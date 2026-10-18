module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_d {
    public fun d<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v1 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v0);
            if (v1 > 0) {
                let v2 = if (arg2) {
                    v1
                } else {
                    0
                };
                let v3 = if (arg2) {
                    0
                } else {
                    v1
                };
                let (v4, v5, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg1, v2, v3, arg3);
                let v7 = if (arg2) {
                    v5
                } else {
                    v4
                };
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v0, v7);
            };
            v0 = v0 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}


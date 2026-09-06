module 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::vec_sort {
    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun sort_u32(arg0: &mut vector<u32>) {
        let v0 = 0x1::vector::length<u32>(arg0);
        if (v0 < 2) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = vector[];
            let v3 = 0;
            let v4 = v3;
            while (v4 < v0) {
                let v5 = min_u64(v4 + v1, v0);
                v4 = min_u64(v4 + v1 + v1, v0);
                while (v3 < v5 || v5 < v4) {
                    if (v3 < v5 && (v5 >= v4 || *0x1::vector::borrow<u32>(arg0, v3) <= *0x1::vector::borrow<u32>(arg0, v5))) {
                        0x1::vector::push_back<u32>(&mut v2, *0x1::vector::borrow<u32>(arg0, v3));
                        v3 = v3 + 1;
                        continue
                    };
                    0x1::vector::push_back<u32>(&mut v2, *0x1::vector::borrow<u32>(arg0, v5));
                    v5 = v5 + 1;
                };
            };
            *arg0 = v2;
            v1 = v1 + v1;
        };
    }

    // decompiled from Move bytecode v7
}


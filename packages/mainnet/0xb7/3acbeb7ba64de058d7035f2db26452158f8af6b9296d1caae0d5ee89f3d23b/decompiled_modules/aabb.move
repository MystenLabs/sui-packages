module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb {
    struct AABB has copy, drop, store {
        min_x: u64,
        min_y: u64,
        max_x: u64,
        max_y: u64,
    }

    public fun from_vertices(arg0: &vector<u64>, arg1: &vector<u64>) : AABB {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 >= 3, 1001);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1002);
        let v1 = *0x1::vector::borrow<u64>(arg0, 0);
        let v2 = v1;
        let v3 = v1;
        let v4 = *0x1::vector::borrow<u64>(arg1, 0);
        let v5 = v4;
        let v6 = v4;
        let v7 = 1;
        while (v7 < v0) {
            let v8 = *0x1::vector::borrow<u64>(arg0, v7);
            let v9 = *0x1::vector::borrow<u64>(arg1, v7);
            if (v8 < v1) {
                v2 = v8;
            };
            if (v8 > v1) {
                v3 = v8;
            };
            if (v9 < v4) {
                v5 = v9;
            };
            if (v9 > v4) {
                v6 = v9;
            };
            v7 = v7 + 1;
        };
        AABB{
            min_x : v2,
            min_y : v5,
            max_x : v3,
            max_y : v6,
        }
    }

    public fun intersects(arg0: &AABB, arg1: &AABB) : bool {
        if (arg0.min_x < arg1.max_x) {
            if (arg0.max_x > arg1.min_x) {
                if (arg0.min_y < arg1.max_y) {
                    arg0.max_y > arg1.min_y
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun max_x(arg0: &AABB) : u64 {
        arg0.max_x
    }

    public fun max_y(arg0: &AABB) : u64 {
        arg0.max_y
    }

    public fun min_x(arg0: &AABB) : u64 {
        arg0.min_x
    }

    public fun min_y(arg0: &AABB) : u64 {
        arg0.min_y
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : AABB {
        assert!(arg0 <= arg2, 1000);
        assert!(arg1 <= arg3, 1000);
        AABB{
            min_x : arg0,
            min_y : arg1,
            max_x : arg2,
            max_y : arg3,
        }
    }

    // decompiled from Move bytecode v7
}


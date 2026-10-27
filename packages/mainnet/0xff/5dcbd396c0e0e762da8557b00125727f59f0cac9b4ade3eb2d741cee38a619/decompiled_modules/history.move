module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history {
    struct Header has copy, drop, store {
        first: u64,
        posted: u64,
        pages: u64,
    }

    struct PageKey has copy, drop, store {
        index: u64,
    }

    struct Page has store {
        first_tick: u64,
        prices: vector<u64>,
        min: u64,
        max: u64,
    }

    struct RunKey has copy, drop, store {
        index: u64,
    }

    struct Run has store {
        first_tick: u64,
        min: u64,
        max: u64,
    }

    public(friend) fun capacity(arg0: &Header) : u64 {
        arg0.pages * 64
    }

    public(friend) fun extremes(arg0: &0x2::object::UID, arg1: &Header, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = if (arg2 <= arg3) {
            if (arg2 >= oldest(arg1)) {
                arg3 <= arg1.posted
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = 18446744073709551615;
        let v2 = 0;
        let v3 = arg2;
        while (v3 <= arg3) {
            if (v3 % 4096 == 0 && arg3 - v3 >= 4096 - 1) {
                let v4 = RunKey{index: v3 / 4096 % arg1.pages / 64};
                let v5 = 0x2::dynamic_field::borrow<RunKey, Run>(arg0, v4);
                if (v5.min < v1) {
                    v1 = v5.min;
                };
                if (v5.max > v2) {
                    v2 = v5.max;
                };
                v3 = v3 + 4096;
                continue
            };
            if (v3 % 64 == 0 && arg3 - v3 >= 64 - 1) {
                let v6 = PageKey{index: v3 / 64 % arg1.pages};
                let v7 = 0x2::dynamic_field::borrow<PageKey, Page>(arg0, v6);
                if (v7.min < v1) {
                    v1 = v7.min;
                };
                if (v7.max > v2) {
                    v2 = v7.max;
                };
                v3 = v3 + 64;
                continue
            };
            let v8 = PageKey{index: v3 / 64 % arg1.pages};
            let v9 = 0x2::dynamic_field::borrow<PageKey, Page>(arg0, v8);
            let v10 = v3 - v3 % 64 + 64 - 1;
            let v11 = if (v10 < arg3) {
                v10
            } else {
                arg3
            };
            let v12 = v3;
            while (v12 <= v11) {
                let v13 = *0x1::vector::borrow<u64>(&v9.prices, v12 % 64);
                if (v13 < v1) {
                    v1 = v13;
                };
                if (v13 > v2) {
                    v2 = v13;
                };
                v12 = v12 + 1;
            };
            v3 = v11 + 1;
        };
        (v1, v2)
    }

    public(friend) fun first(arg0: &Header) : u64 {
        arg0.first
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) : Header {
        assert!(arg3 >= 64 && arg3 % 64 == 0, 2);
        store(arg0, arg3, arg1, arg2);
        Header{
            first  : arg1,
            posted : arg1,
            pages  : arg3,
        }
    }

    public(friend) fun oldest(arg0: &Header) : u64 {
        let v0 = capacity(arg0);
        let v1 = if (arg0.posted + 1 > v0) {
            arg0.posted + 1 - v0
        } else {
            0
        };
        if (v1 > arg0.first) {
            v1
        } else {
            arg0.first
        }
    }

    public(friend) fun posted(arg0: &Header) : u64 {
        arg0.posted
    }

    public(friend) fun price(arg0: &0x2::object::UID, arg1: &Header, arg2: u64) : u64 {
        assert!(arg2 >= oldest(arg1) && arg2 <= arg1.posted, 1);
        let v0 = PageKey{index: arg2 / 64 % arg1.pages};
        *0x1::vector::borrow<u64>(&0x2::dynamic_field::borrow<PageKey, Page>(arg0, v0).prices, arg2 % 64)
    }

    public(friend) fun push_all(arg0: &mut 0x2::object::UID, arg1: &mut Header, arg2: u64, arg3: &vector<u64>) {
        assert!(arg2 == arg1.posted + 1, 0);
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg3)) {
            store(arg0, arg1.pages, v0, *0x1::vector::borrow<u64>(arg3, v1));
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        arg1.posted = v0 - 1;
    }

    fun store(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = arg2 % 64;
        let v1 = arg2 - v0;
        let v2 = PageKey{index: arg2 / 64 % arg1};
        if (!0x2::dynamic_field::exists<PageKey>(arg0, v2)) {
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 64) {
                0x1::vector::push_back<u64>(&mut v3, 0);
                v4 = v4 + 1;
            };
            let v5 = Page{
                first_tick : v1,
                prices     : v3,
                min        : arg3,
                max        : arg3,
            };
            0x2::dynamic_field::add<PageKey, Page>(arg0, v2, v5);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<PageKey, Page>(arg0, v2);
        if (v6.first_tick != v1) {
            v6.first_tick = v1;
            v6.min = arg3;
            v6.max = arg3;
        };
        *0x1::vector::borrow_mut<u64>(&mut v6.prices, v0) = arg3;
        let v7 = v6.min;
        let v8 = v6.max;
        let v9 = if (arg3 < v7) {
            arg3
        } else {
            v7
        };
        v6.min = v9;
        let v10 = if (arg3 > v8) {
            arg3
        } else {
            v8
        };
        v6.max = v10;
        let v11 = arg2 - arg2 % 4096;
        let v12 = RunKey{index: arg2 / 4096 % arg1 / 64};
        if (!0x2::dynamic_field::exists<RunKey>(arg0, v12)) {
            let v13 = Run{
                first_tick : v11,
                min        : arg3,
                max        : arg3,
            };
            0x2::dynamic_field::add<RunKey, Run>(arg0, v12, v13);
        };
        let v14 = 0x2::dynamic_field::borrow_mut<RunKey, Run>(arg0, v12);
        if (v14.first_tick != v11) {
            v14.first_tick = v11;
            v14.min = arg3;
            v14.max = arg3;
        };
        let v15 = v14.min;
        let v16 = v14.max;
        let v17 = if (arg3 < v15) {
            arg3
        } else {
            v15
        };
        v14.min = v17;
        let v18 = if (arg3 > v16) {
            arg3
        } else {
            v16
        };
        v14.max = v18;
    }

    // decompiled from Move bytecode v7
}


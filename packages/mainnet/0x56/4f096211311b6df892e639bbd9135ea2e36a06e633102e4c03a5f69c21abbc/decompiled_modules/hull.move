module 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::hull {
    fun all_left(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg2: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg2)) {
            if (v0) {
                v0 = !0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::cross(arg0, arg1, *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg2, v1)));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun convex_hull(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>, arg1: &vector<u64>) : vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point> {
        let v0 = 0x1::vector::empty<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            0x1::vector::push_back<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(&mut v0, *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, *0x1::vector::borrow<u64>(arg1, v1)));
            v1 = v1 + 1;
        };
        assert!(is_convex(&v0) && encloses(&v0, arg0), 1);
        v0
    }

    fun edge_strict(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>, arg1: u64, arg2: u64) : bool {
        let v0 = (arg2 + 1) % arg1;
        let v1 = true;
        let v2 = 0;
        while (v2 < arg1) {
            if (v1) {
                if (v2 != arg2 && v2 != v0) {
                    v1 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::orient(*0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, arg2), *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, v0), *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, v2)) == 2;
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun encloses(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>, arg1: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : bool {
        let v0 = 0x1::vector::length<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0);
        let v1 = true;
        let v2 = 0;
        while (v2 < v0) {
            if (v1) {
                v1 = all_left(*0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, v2), *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, (v2 + 1) % v0), arg1);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun is_convex(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : bool {
        let v0 = 0x1::vector::length<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0);
        let v1 = v0 >= 3;
        let v2 = 0;
        while (v2 < v0) {
            if (v1) {
                v1 = edge_strict(arg0, v0, v2);
            };
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}


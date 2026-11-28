module 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::segment {
    public fun between(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg2: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::le(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::dot(arg0, arg1, arg2), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero())
    }

    public fun on_segment(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg2: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : bool {
        !0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::cross(arg0, arg1, arg2), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()) && false || between(arg0, arg1, arg2)
    }

    public fun segments_intersect(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg2: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg3: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : bool {
        let v0 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::orient(arg0, arg1, arg2);
        let v1 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::orient(arg0, arg1, arg3);
        let v2 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::orient(arg2, arg3, arg0);
        let v3 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::orient(arg2, arg3, arg1);
        let v4 = v0 == 1 && between(arg2, arg0, arg1);
        let v5 = v1 == 1 && between(arg3, arg0, arg1);
        let v6 = v2 == 1 && between(arg0, arg2, arg3);
        let v7 = v3 == 1 && between(arg1, arg2, arg3);
        let v8 = if (v0 != 1) {
            if (v1 != 1) {
                if (v2 != 1) {
                    v3 != 1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            v0 != v1 && v2 != v3
        } else if (v4) {
            true
        } else if (v5) {
            true
        } else if (v6) {
            true
        } else {
            v7
        }
    }

    // decompiled from Move bytecode v7
}


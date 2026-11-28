module 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::polygon {
    public fun area2(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0x1::vector::length<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero();
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(v1, term(*0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, v2), *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, (v2 + 1) % v0)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun area_down(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : u256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(area2(arg0)) / 2
    }

    public fun area_ud18(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(area2(arg0)) * 500000000000000000)
    }

    public fun area_up(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>) : u256 {
        (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(area2(arg0)) + 1) / 2
    }

    fun edge_step(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg2: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : (bool, bool, bool) {
        let v0 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::cross(arg1, arg2, arg0);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()) && 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::segment::between(arg0, arg1, arg2);
        let v2 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::y(arg1);
        let v3 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::y(arg2);
        let v4 = 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::y(arg0);
        let v5 = if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::le(v2, v4)) {
            if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::lt(v4, v3)) {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::gt(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero())
            } else {
                false
            }
        } else {
            false
        };
        let v6 = if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::le(v3, v4)) {
            if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::lt(v4, v2)) {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::lt(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero())
            } else {
                false
            }
        } else {
            false
        };
        (v1, v5, v6)
    }

    public fun point_in_polygon(arg0: &vector<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : u8 {
        let v0 = 0x1::vector::length<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let (v5, v6, v7) = edge_step(arg1, *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, v4), *0x1::vector::borrow<0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point>(arg0, (v4 + 1) % v0));
            let v8 = v1 || v5;
            v1 = v8;
            if (v6) {
                v2 = v2 + 1;
            };
            if (v7) {
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        if (v1) {
            1
        } else if (v2 != v3) {
            2
        } else {
            0
        }
    }

    fun term(arg0: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point, arg1: 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::Point) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::sub(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::x(arg0)), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::y(arg1))), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::x(arg1)), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point::y(arg0))))
    }

    // decompiled from Move bytecode v7
}


module 0x564f096211311b6df892e639bbd9135ea2e36a06e633102e4c03a5f69c21abbc::point {
    struct Point has copy, drop, store {
        x: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64,
        y: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64,
    }

    public fun cross(arg0: Point, arg1: Point, arg2: Point) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::sub(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(diff(arg1.x, arg0.x), diff(arg2.y, arg0.y)), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(diff(arg1.y, arg0.y), diff(arg2.x, arg0.x)))
    }

    fun diff(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64, arg1: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::sub(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(arg0), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::cast::i64_to_i256(arg1))
    }

    public fun dist_sq(arg0: Point, arg1: Point) : u256 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(diff(arg1.x, arg0.x));
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(diff(arg1.y, arg0.y));
        v0 * v0 + v1 * v1
    }

    public fun dot(arg0: Point, arg1: Point, arg2: Point) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(diff(arg1.x, arg0.x), diff(arg2.x, arg0.x)), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(diff(arg1.y, arg0.y), diff(arg2.y, arg0.y)))
    }

    public fun new(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64, arg1: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64) : Point {
        Point{
            x : arg0,
            y : arg1,
        }
    }

    public fun orient(arg0: Point, arg1: Point, arg2: Point) : u8 {
        let v0 = cross(arg0, arg1, arg2);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0
        } else if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero())) {
            1
        } else {
            2
        }
    }

    public fun x(arg0: Point) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64 {
        arg0.x
    }

    public fun y(arg0: Point) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i64::I64 {
        arg0.y
    }

    // decompiled from Move bytecode v7
}


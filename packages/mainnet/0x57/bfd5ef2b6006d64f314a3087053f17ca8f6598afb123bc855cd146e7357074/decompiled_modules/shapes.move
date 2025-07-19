module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes {
    struct Rectangle {
        base: u64,
        height: u64,
    }

    struct Box {
        base: u64,
        height: u64,
        depth: u64,
    }

    public fun box(arg0: u64, arg1: u64, arg2: u64) : Box {
        Box{
            base   : arg0,
            height : arg1,
            depth  : arg2,
        }
    }

    public fun box_base(arg0: &Box) : u64 {
        arg0.base
    }

    public fun box_depth(arg0: &Box) : u64 {
        arg0.depth
    }

    public fun box_height(arg0: &Box) : u64 {
        arg0.height
    }

    public fun rectangle(arg0: u64, arg1: u64) : Rectangle {
        Rectangle{
            base   : arg0,
            height : arg1,
        }
    }

    public fun rectangle_base(arg0: &Rectangle) : u64 {
        arg0.base
    }

    public fun rectangle_height(arg0: &Rectangle) : u64 {
        arg0.height
    }

    // decompiled from Move bytecode v6
}


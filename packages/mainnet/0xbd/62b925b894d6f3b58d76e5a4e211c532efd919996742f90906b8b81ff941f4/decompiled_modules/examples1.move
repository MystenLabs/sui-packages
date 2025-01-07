module 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::examples1 {
    fun example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle, arg1: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Box) : u64 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_base(arg0) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_height(arg0) + 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_base(arg1) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_height(arg1) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_depth(arg1)
    }

    fun expanded_example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle, arg1: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Box) : u64 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_base(arg0) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_height(arg0) + 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_base(arg1) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_height(arg1) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box_depth(arg1)
    }

    // decompiled from Move bytecode v6
}


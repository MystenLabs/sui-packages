module 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::examples2 {
    fun example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle) : 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle) : 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle, arg1: u64) : 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Box {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::box(0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_base(arg0), 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}


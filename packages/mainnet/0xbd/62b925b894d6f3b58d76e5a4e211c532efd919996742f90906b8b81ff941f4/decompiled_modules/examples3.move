module 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::examples3 {
    fun example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle) : u64 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_base(arg0) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::Rectangle) : u64 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_base(arg0) * 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}


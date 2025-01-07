module 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::examples {
    fun examples<T0>(arg0: 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::Cup<T0>) : T0 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::borrow<T0>(&arg0);
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::borrow_mut<T0>(&mut arg0);
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::Cup<T0>) : T0 {
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::borrow<T0>(&arg0);
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::borrow_mut<T0>(&mut arg0);
        0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}


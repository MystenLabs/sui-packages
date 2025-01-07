module 0xb2c5dee1361f9c6aa230bf73897d5a8a33702036315bbe7b9694341f6398f85c::coin_helper {
    public fun compare<T0, T1>() : 0xb2c5dee1361f9c6aa230bf73897d5a8a33702036315bbe7b9694341f6398f85c::comparator::Result {
        0xb2c5dee1361f9c6aa230bf73897d5a8a33702036315bbe7b9694341f6398f85c::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = compare<T0, T1>();
        assert!(!0xb2c5dee1361f9c6aa230bf73897d5a8a33702036315bbe7b9694341f6398f85c::comparator::is_equal(&v0), 3000);
        0xb2c5dee1361f9c6aa230bf73897d5a8a33702036315bbe7b9694341f6398f85c::comparator::is_smaller_than(&v0)
    }

    // decompiled from Move bytecode v6
}


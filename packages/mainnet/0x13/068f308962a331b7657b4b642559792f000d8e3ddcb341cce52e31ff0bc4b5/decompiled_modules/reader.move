module 0x13068f308962a331b7657b4b642559792f000d8e3ddcb341cce52e31ff0bc4b5::reader {
    public fun current<T0, T1>(arg0: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool, u64, u64, u64) {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 600);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg2, 0x2::bcs::peel_bool(&mut v0), 0x2::clock::timestamp_ms(arg1), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    // decompiled from Move bytecode v7
}


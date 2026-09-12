module 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::reader {
    public fun current<T0, T1>(arg0: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool, u64, u64, u64) {
        decode_state(0x1::bcs::to_bytes<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>>(arg0), 0x2::clock::timestamp_ms(arg1), arg2)
    }

    fun decode_state(arg0: vector<u8>, arg1: u64, arg2: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool, u64, u64, u64) {
        let v0 = 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::new(arg0);
        0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::skip(&mut v0, 64);
        0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::skip(&mut v0, 1);
        0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::skip(&mut v0, 1);
        0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::skip(&mut v0, 16);
        assert!(0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::is_empty(&v0), 600);
        (0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), arg2, 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::boolean(&mut v0), arg1, 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0), 0xcac1a862957aa0b58fc6a86ee229201c918ecb99dc3f49d13f41babee3ab0c43::cursor::read_u64(&mut v0))
    }

    // decompiled from Move bytecode v7
}


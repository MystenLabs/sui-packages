module 0x5edc11f5f599080a8991e59e85a6df8dcb81d910c380405198b02db479bede05::assertion {
    struct TimeRemainingEvent has copy, drop {
        end_time: u64,
        expected_end_time: u64,
        now_time: u64,
    }

    public fun assert_end_time<T0>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::end_time<T0>(arg0) == arg1, 0);
        let v0 = TimeRemainingEvent{
            end_time          : 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::end_time<T0>(arg0),
            expected_end_time : arg1,
            now_time          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TimeRemainingEvent>(v0);
    }

    public fun update_price<T0>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg1: u64) {
        assert!(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::end_time<T0>(arg0) == arg1, 0);
    }

    // decompiled from Move bytecode v6
}


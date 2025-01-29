module 0x910efb97cc4a36f6e65362a0683d0293a2f6ef8c39abb5cd13dc65a11f2c1a90::buckyou_bot {
    struct StampEvent has copy, drop {
        ts: u64,
    }

    public fun redeem<T0, T1: store + key>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: T1, arg3: u64, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::end_time<T0>(arg1);
        assert!(v1 >= v0 && v1 - v0 <= arg3, 100);
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::entry::redeem<T0, T1>(arg0, arg1, arg5, arg4, arg2);
    }

    public fun stamp<T0>(arg0: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg1: &0x2::clock::Clock) {
        let v0 = StampEvent{ts: 0x2::clock::timestamp_ms(arg1)};
        0x2::event::emit<StampEvent>(v0);
    }

    // decompiled from Move bytecode v6
}


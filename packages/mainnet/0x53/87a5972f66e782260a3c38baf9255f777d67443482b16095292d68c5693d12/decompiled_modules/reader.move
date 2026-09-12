module 0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::reader {
    public fun current<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : (u128, u128, u64, bool) {
        decode_state(0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global>(arg0), 0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1))
    }

    fun decode_state(arg0: vector<u8>, arg1: vector<u8>) : (u128, u128, u64, bool) {
        assert!(0x1::vector::length<u8>(&arg0) <= 4096, 901);
        let v0 = 0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::new(arg0);
        0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::skip(&mut v0, 32);
        let v1 = 0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::new(arg1);
        0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::skip(&mut v1, 32);
        0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::skip(&mut v1, 24);
        0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::skip(&mut v1, 16);
        assert!(0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::is_empty(&v1), 900);
        ((0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::read_u64(&mut v1) as u128), (0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::read_u64(&mut v1) as u128), 0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::read_u64(&mut v1), !0x5387a5972f66e782260a3c38baf9255f777d67443482b16095292d68c5693d12::cursor::boolean(&mut v0))
    }

    public fun pool_bcs<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0)
    }

    // decompiled from Move bytecode v7
}


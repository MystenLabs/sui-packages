module 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67 {
    struct H7889f has copy, drop {
        h14ee8: u64,
        h69de8: u64,
        h1ae05: u64,
    }

    struct Hc0f5e has copy, drop {
        h8b8ea: vector<u128>,
        h3dfbb: vector<bool>,
    }

    struct H4eee1 has copy, drop {
        hc3725: u64,
        h332f0: 0x2::object::ID,
        he8bd1: u256,
        h663ef: u256,
        h4291c: u256,
        ha9484: u256,
        h4278e: u256,
        hfbce5: u256,
        h0c3f9: u256,
        h98a1c: u256,
        h29646: u64,
    }

    public(friend) fun h145ed<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::SessionSummary) {
        let (v0, v1) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::filled_base_and_quote(arg2, true);
        let (v2, v3) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::filled_base_and_quote(arg2, false);
        let (v4, v5) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::posted_base_by_side(arg2);
        let v6 = H4eee1{
            hc3725 : arg1,
            h332f0 : 0x2::object::id<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>>(arg0),
            he8bd1 : v0,
            h663ef : v1,
            h4291c : v2,
            ha9484 : v3,
            h4278e : 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::execution_price(arg2, true),
            hfbce5 : 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::execution_price(arg2, false),
            h0c3f9 : v4,
            h98a1c : v5,
            h29646 : 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::posted_orders(arg2),
        };
        0x2::event::emit<H4eee1>(v6);
    }

    public(friend) fun h620fb(arg0: &vector<u128>, arg1: &vector<bool>) {
        assert!(0x1::vector::length<bool>(arg1) == 0x1::vector::length<u128>(arg0), 510);
        let v0 = Hc0f5e{
            h8b8ea : *arg0,
            h3dfbb : *arg1,
        };
        0x2::event::emit<Hc0f5e>(v0);
    }

    public(friend) fun h67a26(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = H7889f{
            h14ee8 : arg0,
            h69de8 : arg1,
            h1ae05 : arg2,
        };
        0x2::event::emit<H7889f>(v0);
    }

    // decompiled from Move bytecode v7
}


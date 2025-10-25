module 0x6e21c84fd36ade63485196dee9f0e761518be23ec3e3ccf44bd883ca46e24fa6::ticks_reader {
    struct Tick has copy, drop, store {
        index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        tick_info: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::TickInfo,
    }

    struct FetchTicksResultEvent has copy, drop, store {
        ticks: vector<Tick>,
    }

    public entry fun emit_all_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0x1::vector::empty<Tick>();
        while (v1 < 0x1::vector::length<u32>(&arg1)) {
            let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v1));
            if (0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::TickInfo>(v0, v3)) {
                let v4 = Tick{
                    index     : v3,
                    tick_info : *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::TickInfo>(v0, v3),
                };
                0x1::vector::push_back<Tick>(&mut v2, v4);
            };
            v1 = v1 + 1;
        };
        let v5 = FetchTicksResultEvent{ticks: v2};
        0x2::event::emit<FetchTicksResultEvent>(v5);
    }

    // decompiled from Move bytecode v6
}


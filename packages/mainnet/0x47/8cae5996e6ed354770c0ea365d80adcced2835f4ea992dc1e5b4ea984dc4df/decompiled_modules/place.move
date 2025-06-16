module 0x478cae5996e6ed354770c0ea365d80adcced2835f4ea992dc1e5b4ea984dc4df::place {
    struct SharedPlace has store, key {
        id: 0x2::object::UID,
        list: vector<u32>,
    }

    entry fun get_place_color(arg0: &SharedPlace) : vector<u32> {
        arg0.list
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u32>(&mut v0, 13421772);
            v1 = v1 + 1;
        };
        let v2 = SharedPlace{
            id   : 0x2::object::new(arg0),
            list : v0,
        };
        0x2::transfer::share_object<SharedPlace>(v2);
    }

    entry fun set_place_color(arg0: &mut SharedPlace, arg1: u32, arg2: u32) {
        0x1::vector::push_back<u32>(&mut arg0.list, arg2);
    }

    // decompiled from Move bytecode v6
}


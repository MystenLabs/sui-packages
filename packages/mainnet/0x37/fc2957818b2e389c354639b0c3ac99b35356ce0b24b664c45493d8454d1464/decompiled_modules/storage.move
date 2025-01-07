module 0x37fc2957818b2e389c354639b0c3ac99b35356ce0b24b664c45493d8454d1464::storage {
    struct StorageV2 has store, key {
        id: 0x2::object::UID,
        obligations: 0x2::bag::Bag,
        latest_digest: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageV2{
            id            : 0x2::object::new(arg0),
            obligations   : 0x2::bag::new(arg0),
            latest_digest : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<StorageV2>(v0);
    }

    public entry fun update(arg0: &mut StorageV2, arg1: vector<address>, arg2: vector<u8>) {
        let v0 = 0x2::bag::length(&arg0.obligations);
        let v1 = 0x1::vector::length<address>(&arg1);
        if (v0 == 0) {
            let v2 = 0x2::vec_set::empty<address>();
            let v3 = 0;
            while (v3 < v1) {
                0x2::vec_set::insert<address>(&mut v2, 0x1::vector::pop_back<address>(&mut arg1));
                v3 = v3 + 1;
            };
            0x2::bag::add<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.obligations, 0, v2);
        } else {
            let v4 = 0x2::bag::borrow_mut<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.obligations, v0 - 1);
            if (0x2::vec_set::size<address>(v4) > 1000 - v1) {
                let v5 = 0x2::vec_set::empty<address>();
                let v6 = 0;
                while (v6 < 0x1::vector::length<address>(&arg1)) {
                    0x2::vec_set::insert<address>(&mut v5, 0x1::vector::pop_back<address>(&mut arg1));
                    v6 = v6 + 1;
                };
                0x2::bag::add<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.obligations, v0, v5);
            } else {
                let v7 = 0;
                while (v7 < v1) {
                    0x2::vec_set::insert<address>(v4, 0x1::vector::pop_back<address>(&mut arg1));
                    v7 = v7 + 1;
                };
            };
        };
        arg0.latest_digest = arg2;
    }

    // decompiled from Move bytecode v6
}


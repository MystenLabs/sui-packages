module 0xeaa8fa15ffe040dcf3e5d0d2611826953e7951269086d2e87a343c8c8b242ec9::memez_distributor {
    struct Recipient has copy, drop, store {
        address: address,
        bps: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
    }

    struct Distributor has copy, drop, store {
        recipients: vector<Recipient>,
    }

    public(friend) fun new(arg0: vector<address>, arg1: vector<u64>) : Distributor {
        let v0 = 0x1::vector::empty<Recipient>();
        0x1::vector::reverse<u64>(&mut arg1);
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 13906834290307497983);
        0x1::vector::reverse<address>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = Recipient{
                address : 0x1::vector::pop_back<address>(&mut arg0),
                bps     : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0x1::vector::pop_back<u64>(&mut arg1)),
            };
            0x1::vector::push_back<Recipient>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg0);
        0x1::vector::destroy_empty<u64>(arg1);
        Distributor{recipients: v0}
    }

    public(friend) fun maybe_send_vested<T0>(arg0: &Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = &arg0.recipients;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipient>(v1)) {
            let v3 = 0x1::vector::borrow<Recipient>(v1, v2);
            let v4 = 0x1::u64::min(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v3.bps, 0x2::coin::value<T0>(&arg1)), 0x2::coin::value<T0>(&arg1));
            if (v4 == 0) {
                v0 = v0 + 1;
            } else {
                if (*0x1::vector::borrow<u64>(&arg3, v0) == 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4, arg4), v3.address);
                } else {
                    0x2::transfer::public_transfer<0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting::MemezVesting<T0>>(0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting::new<T0>(arg2, 0x2::coin::split<T0>(&mut arg1, v4, arg4), 0x2::clock::timestamp_ms(arg2), *0x1::vector::borrow<u64>(&arg3, v0), arg4), v3.address);
                };
                v0 = v0 + 1;
            };
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        };
    }

    public(friend) fun send<T0>(arg0: &Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = &arg0.recipients;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipient>(v1)) {
            let v3 = 0x1::vector::borrow<Recipient>(v1, v2);
            let v4 = 0x1::u64::min(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v3.bps, 0x2::coin::value<T0>(&arg1)), 0x2::coin::value<T0>(&arg1));
            if (v4 == 0) {
                v0 = v0 + 1;
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4, arg2), v3.address);
                v0 = v0 + 1;
            };
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        };
    }

    // decompiled from Move bytecode v6
}


module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards {
    struct Policy has drop, store {
        recipients: vector<address>,
        shares_bps: vector<u64>,
        total_paid_mist: u64,
    }

    struct RewardPaid has copy, drop {
        curve_id: 0x2::object::ID,
        recipient: address,
        amount_mist: u64,
    }

    public fun create(arg0: vector<address>, arg1: vector<u64>) : Policy {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = if (v0 > 0) {
            if (v0 <= 8) {
                v0 == 0x1::vector::length<u64>(&arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (*0x1::vector::borrow<address>(&arg0, v3) != @0x0) {
                if (*0x1::vector::borrow<u64>(&arg1, v3) > 0) {
                    *0x1::vector::borrow<u64>(&arg1, v3) <= 10000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 0);
            let v5 = 0;
            while (v5 < v3) {
                assert!(*0x1::vector::borrow<address>(&arg0, v5) != *0x1::vector::borrow<address>(&arg0, v3), 0);
                v5 = v5 + 1;
            };
            v2 = v2 + *0x1::vector::borrow<u64>(&arg1, v3);
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 0);
        Policy{
            recipients      : arg0,
            shares_bps      : arg1,
            total_paid_mist : 0,
        }
    }

    public fun distribute(arg0: &mut Policy, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        arg0.total_paid_mist = arg0.total_paid_mist + v0;
        let v1 = 1;
        while (v1 < 0x1::vector::length<address>(&arg0.recipients)) {
            pay(arg1, *0x1::vector::borrow<address>(&arg0.recipients, v1), 0x2::balance::split<0x2::sui::SUI>(&mut arg2, (((v0 as u128) * (*0x1::vector::borrow<u64>(&arg0.shares_bps, v1) as u128) / (10000 as u128)) as u64)), arg3);
            v1 = v1 + 1;
        };
        pay(arg1, *0x1::vector::borrow<address>(&arg0.recipients, 0), arg2, arg3);
    }

    fun pay(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg3), arg1);
            let v1 = RewardPaid{
                curve_id    : arg0,
                recipient   : arg1,
                amount_mist : v0,
            };
            0x2::event::emit<RewardPaid>(v1);
        };
    }

    // decompiled from Move bytecode v7
}


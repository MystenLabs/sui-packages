module 0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha_referral {
    struct ReferralPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>,
        total_paid: u64,
    }

    struct ReferralEvent has copy, drop {
        referrer: address,
        referee: address,
        amount: u64,
        reward: u64,
    }

    public entry fun create_referral_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralPool{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(),
            total_paid : 0,
        };
        0x2::transfer::share_object<ReferralPool>(v0);
    }

    public entry fun fund_referral_pool(arg0: &mut ReferralPool, arg1: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>) {
        0x2::balance::join<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.balance, 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(arg1));
    }

    public entry fun pay_with_referral(arg0: &mut ReferralPool, arg1: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 != v0, 2);
        let v1 = 0x2::coin::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg1);
        assert!(v1 > 0, 0);
        let v2 = v1 * 500 / 10000;
        assert!(0x2::balance::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0.balance) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(arg1, arg2);
        arg0.total_paid = arg0.total_paid + v2;
        let v3 = ReferralEvent{
            referrer : arg2,
            referee  : v0,
            amount   : v1,
            reward   : v2,
        };
        0x2::event::emit<ReferralEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(0x2::coin::from_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::balance::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.balance, v2), arg3), arg2);
    }

    public fun pool_balance(arg0: &ReferralPool) : u64 {
        0x2::balance::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0.balance)
    }

    public fun total_paid(arg0: &ReferralPool) : u64 {
        arg0.total_paid
    }

    // decompiled from Move bytecode v7
}


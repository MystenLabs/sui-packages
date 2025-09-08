module 0xe05eb3bc0cc1af17e986a16b7d3065711b41f82d800f12ac876f57448f53fecc::meeting {
    struct MeetingRequest has key {
        id: 0x2::object::UID,
        user1: address,
        user2: address,
        amount: u64,
        user2_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_active: bool,
        is_confirmed: bool,
    }

    public entry fun cancel_meeting(arg0: &mut MeetingRequest, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.user1, 2);
        assert!(!arg0.is_confirmed, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.user2_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.user2_balance, v0), arg1), arg0.user2);
        };
        arg0.is_active = false;
    }

    public entry fun confirm_meeting(arg0: &mut MeetingRequest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.user1, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.amount, 0);
        assert!(!arg0.is_confirmed, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.user1);
        arg0.is_confirmed = true;
    }

    public entry fun create_meeting(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MeetingRequest{
            id            : 0x2::object::new(arg2),
            user1         : 0x2::tx_context::sender(arg2),
            user2         : arg0,
            amount        : arg1,
            user2_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            is_active     : true,
            is_confirmed  : false,
        };
        0x2::transfer::share_object<MeetingRequest>(v0);
    }

    public entry fun deposit_user2(arg0: &mut MeetingRequest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.user2, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.amount, 0);
        assert!(!arg0.is_confirmed, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.user2_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun is_meeting_active(arg0: &MeetingRequest) : bool {
        arg0.is_active
    }

    public fun is_meeting_confirmed(arg0: &MeetingRequest) : bool {
        arg0.is_confirmed
    }

    // decompiled from Move bytecode v6
}


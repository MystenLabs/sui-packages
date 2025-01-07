module 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::team_vesting {
    struct TeamVesting has store, key {
        id: 0x2::object::UID,
        schedule: 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::VestingSchedule<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>,
    }

    public fun claim_vapor(arg0: &mut TeamVesting, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR> {
        0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::claim_vested<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&mut arg0.schedule, arg1, arg2)
    }

    entry fun claim_vapor_to_sender(arg0: &mut TeamVesting, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_vapor(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun distribute_vapor(arg0: 0x2::coin::Coin<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&arg0);
        let v1 = v0 * 0 / 1000;
        let v2 = v0 * 0 / 1000;
        let v3 = v0 * 0 / 1000;
        let v4 = 0x2::coin::split<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&mut arg0, v1, arg2);
        let v5 = 0x2::coin::split<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&mut arg0, v2, arg2);
        let v6 = 0x2::coin::split<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&mut arg0, v3, arg2);
        assert!(0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&v4) >= v1, 0);
        assert!(0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&v5) >= v2, 0);
        assert!(0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&v6) >= v3, 0);
        assert!(0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&arg0) >= v0 * 0 / 1000, 0);
        let v7 = 0x2::clock::timestamp_ms(arg1);
        let v8 = TeamVesting{
            id       : 0x2::object::new(arg2),
            schedule : 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::vest_tokens<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(v4, v7, 7257600000, arg2),
        };
        let v9 = TeamVesting{
            id       : 0x2::object::new(arg2),
            schedule : 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::vest_tokens<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(v5, v7, 7257600000, arg2),
        };
        let v10 = TeamVesting{
            id       : 0x2::object::new(arg2),
            schedule : 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::vest_tokens<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(v6, v7, 7257600000, arg2),
        };
        let v11 = TeamVesting{
            id       : 0x2::object::new(arg2),
            schedule : 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::vest_tokens<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(arg0, v7, 7257600000, arg2),
        };
        0x2::transfer::public_transfer<TeamVesting>(v8, @0x0);
        0x2::transfer::public_transfer<TeamVesting>(v9, @0x0);
        0x2::transfer::public_transfer<TeamVesting>(v10, @0x0);
        0x2::transfer::public_transfer<TeamVesting>(v11, @0x0);
    }

    // decompiled from Move bytecode v6
}


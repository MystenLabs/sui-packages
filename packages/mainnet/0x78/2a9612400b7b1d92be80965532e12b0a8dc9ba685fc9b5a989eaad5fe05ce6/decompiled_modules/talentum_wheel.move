module 0x782a9612400b7b1d92be80965532e12b0a8dc9ba685fc9b5a989eaad5fe05ce6::talentum_wheel {
    struct TalentumWheelSpinEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        battlePass_id: u64,
        user_id: u64,
    }

    public entry fun spin(arg0: u64, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        let v1 = TalentumWheelSpinEvent{
            sender        : 0x2::tx_context::sender(arg4),
            receiver      : arg1,
            amount        : v0,
            battlePass_id : arg0,
            user_id       : arg2,
        };
        0x2::event::emit<TalentumWheelSpinEvent>(v1);
    }

    // decompiled from Move bytecode v6
}


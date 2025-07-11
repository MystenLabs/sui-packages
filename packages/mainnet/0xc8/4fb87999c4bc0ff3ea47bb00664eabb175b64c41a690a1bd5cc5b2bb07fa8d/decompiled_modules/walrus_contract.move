module 0xc84fb87999c4bc0ff3ea47bb00664eabb175b64c41a690a1bd5cc5b2bb07fa8d::walrus_contract {
    struct VerificationRegistry has key {
        id: 0x2::object::UID,
        treasury: address,
        admin: address,
        total_verifications: u64,
        verification_fee: u64,
    }

    struct UserVerified has copy, drop {
        user: address,
        timestamp: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    struct VerificationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    public fun get_admin(arg0: &VerificationRegistry) : address {
        arg0.admin
    }

    public fun get_total_verifications(arg0: &VerificationRegistry) : u64 {
        arg0.total_verifications
    }

    public fun get_treasury(arg0: &VerificationRegistry) : address {
        arg0.treasury
    }

    public fun get_verification_fee(arg0: &VerificationRegistry) : u64 {
        arg0.verification_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VerificationRegistry{
            id                  : 0x2::object::new(arg0),
            treasury            : 0x2::tx_context::sender(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            total_verifications : 0,
            verification_fee    : 2000000000,
        };
        0x2::transfer::share_object<VerificationRegistry>(v0);
    }

    public fun update_admin(arg0: &mut VerificationRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun update_treasury(arg0: &mut VerificationRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.treasury = arg1;
        let v0 = TreasuryUpdated{
            old_treasury : arg0.treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun update_verification_fee(arg0: &mut VerificationRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.verification_fee = arg1;
        let v0 = VerificationFeeUpdated{
            old_fee : arg0.verification_fee,
            new_fee : arg1,
        };
        0x2::event::emit<VerificationFeeUpdated>(v0);
    }

    public fun verify(arg0: &mut VerificationRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.verification_fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.verification_fee, arg2), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        arg0.total_verifications = arg0.total_verifications + 1;
        let v1 = UserVerified{
            user      : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<UserVerified>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa61e1817a0c75affdf2ecbbe046e7b17f5292f1ca8abbf7c9473e99c52769aff::events {
    struct CreatedReferralVaultEvent has copy, drop {
        id: 0x2::object::ID,
        type: 0x1::ascii::String,
    }

    public(friend) fun emit_created_referral_vault_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String) {
        let v0 = CreatedReferralVaultEvent{
            id   : arg0,
            type : arg1,
        };
        0x2::event::emit<CreatedReferralVaultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}


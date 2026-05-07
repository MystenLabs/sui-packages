module 0xf857d0065a2d37d0ca8519cc60e7bb706da84f12c8997c1698c775641c7e8312::xcetus {
    struct EffectiveXcetusAmountEvent has copy, drop {
        amount: u64,
    }

    struct EffectiveTotolAmountEvent has copy, drop {
        amount: u64,
    }

    public fun effective_totol_amount(arg0: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager) : u64 {
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::effective_totol_amount(arg0);
        let v1 = EffectiveTotolAmountEvent{amount: v0};
        0x2::event::emit<EffectiveTotolAmountEvent>(v1);
        v0
    }

    public fun effective_xcetus_amount(arg0: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::effective_xcetus_amount(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNftInfo>(0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::nfts(arg0), arg1));
        let v1 = EffectiveXcetusAmountEvent{amount: v0};
        0x2::event::emit<EffectiveXcetusAmountEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}


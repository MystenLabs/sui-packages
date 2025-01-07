module 0x66dd6f65ebad8911bd196749098bfe6ef826049cef4086c5929863a5a30c93ef::kyc {
    struct Kyc has key {
        id: 0x2::object::UID,
    }

    struct MintedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct ApprovalEvent has copy, drop {
        object_id: 0x2::object::ID,
        ref: 0x1::string::String,
    }

    struct BurnedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun airdrop(arg0: &0x66dd6f65ebad8911bd196749098bfe6ef826049cef4086c5929863a5a30c93ef::kns::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Kyc{id: 0x2::object::new(arg2)};
        let v1 = MintedEvent{object_id: 0x2::object::id<Kyc>(&v0)};
        0x2::event::emit<MintedEvent>(v1);
        0x2::transfer::transfer<Kyc>(v0, arg1);
    }

    public fun airdrop_multi(arg0: &0x66dd6f65ebad8911bd196749098bfe6ef826049cef4086c5929863a5a30c93ef::kns::AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            airdrop(arg0, 0x1::vector::pop_back<address>(&mut arg1), arg2);
            v0 = v0 + 1;
        };
    }

    public entry fun approve(arg0: &Kyc, arg1: 0x1::string::String) {
        let v0 = ApprovalEvent{
            object_id : 0x2::object::id<Kyc>(arg0),
            ref       : arg1,
        };
        0x2::event::emit<ApprovalEvent>(v0);
    }

    public fun burn(arg0: Kyc) {
        let v0 = BurnedEvent{object_id: 0x2::object::id<Kyc>(&arg0)};
        0x2::event::emit<BurnedEvent>(v0);
        let Kyc { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}


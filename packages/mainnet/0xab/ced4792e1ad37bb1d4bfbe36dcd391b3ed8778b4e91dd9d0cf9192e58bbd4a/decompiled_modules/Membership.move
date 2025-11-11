module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Membership {
    struct KycAuthority has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct MemberCard has store, key {
        id: 0x2::object::UID,
        owner: address,
        kyc_ref: vector<u8>,
    }

    public entry fun init_kyc(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KycAuthority{
            id    : 0x2::object::new(arg1),
            admin : arg0,
        };
        0x2::transfer::share_object<KycAuthority>(v0);
    }

    public entry fun mint(arg0: &KycAuthority, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 8001);
        let v0 = MemberCard{
            id      : 0x2::object::new(arg3),
            owner   : arg1,
            kyc_ref : arg2,
        };
        0x2::transfer::transfer<MemberCard>(v0, arg1);
    }

    public entry fun revoke(arg0: &KycAuthority, arg1: MemberCard, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8002);
        let MemberCard {
            id      : v0,
            owner   : _,
            kyc_ref : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}


module 0x2df79802651f01232a3c01f090839fb528747c8287c0c4a2effa038ccf7e5b84::nft_ownership {
    struct DRIP has key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
    }

    struct MintEvent has copy, drop {
        owner: address,
        amount: u64,
    }

    public entry fun check_nft_ownership(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 101);
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg2), 102);
        let v0 = 0x2::tx_context::sender(arg2);
        mint_token(v0, 1, arg2);
    }

    public fun mint_token(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DRIP{
            id     : 0x2::object::new(arg2),
            owner  : arg0,
            amount : arg1,
        };
        let v1 = MintEvent{
            owner  : arg0,
            amount : arg1,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::transfer<DRIP>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}


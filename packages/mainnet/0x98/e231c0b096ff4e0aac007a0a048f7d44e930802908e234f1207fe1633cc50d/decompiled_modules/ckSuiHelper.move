module 0x98e231c0b096ff4e0aac007a0a048f7d44e930802908e234f1207fe1633cc50d::ckSuiHelper {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CkSuiMinter has key {
        id: 0x2::object::UID,
        minter_address: address,
    }

    struct ReceivedSui has copy, drop, store {
        from: address,
        value: u64,
        principal_address: 0x1::string::String,
        minter_address: address,
    }

    public fun deposit(arg0: u64, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &mut CkSuiMinter, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg0, arg4), arg3.minter_address);
        let v0 = ReceivedSui{
            from              : 0x2::tx_context::sender(arg4),
            value             : arg0,
            principal_address : arg2,
            minter_address    : arg3.minter_address,
        };
        0x2::event::emit<ReceivedSui>(v0);
    }

    public fun getMinterAddress(arg0: &mut CkSuiMinter) : &mut address {
        &mut arg0.minter_address
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CkSuiMinter{
            id             : 0x2::object::new(arg0),
            minter_address : @0x0,
        };
        0x2::transfer::transfer<CkSuiMinter>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun setMinterAddress(arg0: &AdminCap, arg1: address, arg2: &mut CkSuiMinter) {
        arg2.minter_address = arg1;
    }

    // decompiled from Move bytecode v6
}


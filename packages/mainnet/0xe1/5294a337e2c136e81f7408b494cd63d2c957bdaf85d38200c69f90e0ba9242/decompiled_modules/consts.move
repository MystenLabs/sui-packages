module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts {
    public(friend) fun F0UserCreate() : u8 {
        10
    }

    public(friend) fun F0UserDelete() : u8 {
        11
    }

    public(friend) fun F0UserDeposit() : u8 {
        13
    }

    public(friend) fun F0UserSetOwner() : u8 {
        15
    }

    public(friend) fun F0UserSetProposer() : u8 {
        14
    }

    public(friend) fun F0UserWithdraw() : u8 {
        12
    }

    public(friend) fun F0WareOffShelfs() : u8 {
        32
    }

    public(friend) fun F0WaresPurchase() : u8 {
        33
    }

    public(friend) fun F0WaresSupplement() : u8 {
        30
    }

    public(friend) fun F0WaresUpdate() : u8 {
        31
    }

    public(friend) fun SYSTEM_UID() : 0x1::string::String {
        0x1::string::utf8(b"admin")
    }

    public(friend) fun VERSION() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}


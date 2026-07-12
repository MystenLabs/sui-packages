module 0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::events {
    struct TreasuryRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        bro_type: vector<u8>,
    }

    struct Minted has copy, drop {
        bro_type: vector<u8>,
        amount: u64,
        broker: address,
    }

    struct Burned has copy, drop {
        bro_type: vector<u8>,
        amount: u64,
        broker: address,
    }

    public(friend) fun burned(arg0: vector<u8>, arg1: u64, arg2: address) {
        let v0 = Burned{
            bro_type : arg0,
            amount   : arg1,
            broker   : arg2,
        };
        0x2::event::emit<Burned>(v0);
    }

    public(friend) fun minted(arg0: vector<u8>, arg1: u64, arg2: address) {
        let v0 = Minted{
            bro_type : arg0,
            amount   : arg1,
            broker   : arg2,
        };
        0x2::event::emit<Minted>(v0);
    }

    public(friend) fun treasury_registered(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = TreasuryRegistered{
            vault_id : arg0,
            bro_type : arg1,
        };
        0x2::event::emit<TreasuryRegistered>(v0);
    }

    // decompiled from Move bytecode v7
}


module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events {
    struct CollectionMint<phantom T0> has copy, drop {
        number: u64,
        to: address,
    }

    struct MaxSupplyChanged<phantom T0> has copy, drop {
        old_max: u64,
        new_max: u64,
    }

    struct TypeCreated<phantom T0> has copy, drop {
        type_id: 0x2::object::ID,
        name: 0x1::string::String,
        max_supply: 0x1::option::Option<u64>,
    }

    struct SftMinted<phantom T0> has copy, drop {
        type_id: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct SftBurned<phantom T0> has copy, drop {
        type_id: 0x2::object::ID,
        amount: u64,
    }

    struct SftTransferred<phantom T0> has copy, drop {
        type_id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
    }

    struct Migrated<phantom T0> has copy, drop {
        key: vector<u8>,
    }

    public(friend) fun collection_mint<T0>(arg0: u64, arg1: address) {
        let v0 = CollectionMint<T0>{
            number : arg0,
            to     : arg1,
        };
        0x2::event::emit<CollectionMint<T0>>(v0);
    }

    public(friend) fun max_supply_changed<T0>(arg0: u64, arg1: u64) {
        let v0 = MaxSupplyChanged<T0>{
            old_max : arg0,
            new_max : arg1,
        };
        0x2::event::emit<MaxSupplyChanged<T0>>(v0);
    }

    public(friend) fun migrated<T0>(arg0: vector<u8>) {
        let v0 = Migrated<T0>{key: arg0};
        0x2::event::emit<Migrated<T0>>(v0);
    }

    public(friend) fun sft_burned<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SftBurned<T0>{
            type_id : arg0,
            amount  : arg1,
        };
        0x2::event::emit<SftBurned<T0>>(v0);
    }

    public(friend) fun sft_minted<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = SftMinted<T0>{
            type_id : arg0,
            to      : arg1,
            amount  : arg2,
        };
        0x2::event::emit<SftMinted<T0>>(v0);
    }

    public(friend) fun sft_transferred<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = SftTransferred<T0>{
            type_id : arg0,
            from    : arg1,
            to      : arg2,
            amount  : arg3,
        };
        0x2::event::emit<SftTransferred<T0>>(v0);
    }

    public(friend) fun type_created<T0>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) {
        let v0 = TypeCreated<T0>{
            type_id    : arg0,
            name       : arg1,
            max_supply : arg2,
        };
        0x2::event::emit<TypeCreated<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}


module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity {
    struct Rarity has store, key {
        id: 0x2::object::UID,
        number: u16,
        data: RarityData,
    }

    struct RarityData has store {
        class: 0x1::string::String,
        rank: u16,
        score: u64,
    }

    struct CreateRarityCap has store, key {
        id: 0x2::object::UID,
        number: u16,
    }

    public fun create_rarity(arg0: CreateRarityCap, arg1: 0x1::string::String, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Rarity {
        let v0 = RarityData{
            class : arg1,
            rank  : arg2,
            score : arg3,
        };
        let v1 = Rarity{
            id     : 0x2::object::new(arg4),
            number : arg0.number,
            data   : v0,
        };
        let CreateRarityCap {
            id     : v2,
            number : _,
        } = arg0;
        0x2::object::delete(v2);
        v1
    }

    public(friend) fun create_rarity_cap_id(arg0: &CreateRarityCap) : 0x2::object::ID {
        0x2::object::id<CreateRarityCap>(arg0)
    }

    public(friend) fun issue_create_rarity_cap(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : CreateRarityCap {
        CreateRarityCap{
            id     : 0x2::object::new(arg1),
            number : arg0,
        }
    }

    public(friend) fun number(arg0: &Rarity) : u16 {
        arg0.number
    }

    // decompiled from Move bytecode v6
}


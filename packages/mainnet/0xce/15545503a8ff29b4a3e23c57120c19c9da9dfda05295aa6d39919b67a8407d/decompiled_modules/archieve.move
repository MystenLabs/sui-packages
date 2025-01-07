module 0x8f2e22c9bf84796ffccbd65bd167525b9d261bebe0799e2e8c7db2d93b61c947::archieve {
    struct ARCHIEVE has drop {
        dummy_field: bool,
    }

    struct UserArchieve has store, key {
        id: 0x2::object::UID,
    }

    struct UserReg has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    struct NftArchieve has store, key {
        id: 0x2::object::UID,
        nonce: u64,
        owner: address,
    }

    struct NftOwner has copy, drop, store {
        owner: address,
    }

    fun init(arg0: ARCHIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserReg{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<UserReg>(v0);
    }

    public entry fun register(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 8003);
        let v1 = UserArchieve{id: 0x2::object::new(arg1)};
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        0x2::transfer::public_transfer<UserArchieve>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun register2(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = NftOwner{owner: 0x2::tx_context::sender(arg1)};
        assert!(!0x2::dynamic_field::exists_with_type<NftOwner, 0x2::object::ID>(&mut arg0.id, v0), 8003);
        let v1 = NftArchieve{
            id    : 0x2::object::new(arg1),
            nonce : 0,
            owner : 0x2::tx_context::sender(arg1),
        };
        let v2 = NftOwner{owner: 0x2::tx_context::sender(arg1)};
        0x2::dynamic_field::add<NftOwner, bool>(&mut arg0.id, v2, true);
        0x2::transfer::public_transfer<NftArchieve>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun verify(arg0: &mut UserArchieve) {
    }

    public fun verify2(arg0: &mut NftArchieve, arg1: address) {
        assert!(arg0.owner == arg1, 1000);
    }

    // decompiled from Move bytecode v6
}


module 0x35fd0b6b7de337c56b066ead3789bb1554740214d94ce920787462d4e14a0a30::vote {
    struct VOTE has drop {
        dummy_field: bool,
    }

    struct Mintlist has key {
        id: 0x2::object::UID,
        mintlist: 0x2::table::Table<address, u64>,
    }

    struct VoteToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct VoteStore has key {
        id: 0x2::object::UID,
        proposals: 0x2::object_table::ObjectTable<0x1::string::String, Proposal>,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        votes: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VOTE>, arg1: &mut Mintlist, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, u64>(&arg1.mintlist, v0), 1);
        0x2::table::add<address, u64>(&mut arg1.mintlist, v0, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<VOTE>>(0x2::coin::mint<VOTE>(arg0, 100, arg2), v0);
    }

    public entry fun vote<T0>(arg0: &VoteToken<T0>, arg1: &mut VoteStore, arg2: 0x1::string::String) {
        assert!(arg0.amount > 0, 1);
        assert!(0x2::object_table::contains<0x1::string::String, Proposal>(&arg1.proposals, arg2), 2);
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Proposal>(&mut arg1.proposals, arg2);
        v0.votes = v0.votes + arg0.amount;
    }

    fun init(arg0: VOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Mintlist{
            id       : 0x2::object::new(arg1),
            mintlist : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = VoteStore{
            id        : 0x2::object::new(arg1),
            proposals : 0x2::object_table::new<0x1::string::String, Proposal>(arg1),
        };
        let v2 = Proposal{
            id    : 0x2::object::new(arg1),
            votes : 0,
        };
        let (v3, v4) = 0x2::coin::create_currency<VOTE>(arg0, 6, b"VOTE", b"VOTE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::object_table::add<0x1::string::String, Proposal>(&mut v1.proposals, 0x1::string::utf8(b"letsctf"), v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOTE>>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Mintlist>(v0);
        0x2::transfer::share_object<VoteStore>(v1);
    }

    public entry fun register_voter<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteToken<T0>{
            id     : 0x2::object::new(arg0),
            amount : 100,
        };
        0x2::transfer::public_transfer<VoteToken<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}


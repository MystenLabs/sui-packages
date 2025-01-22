module 0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::committed {
    struct Committed has key {
        id: 0x2::object::UID,
        dao_fund_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        amount: u64,
    }

    struct CommittedMintedEvent has copy, drop {
        committed_id: 0x2::object::ID,
        dao_fund_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        owner: address,
        amount: u64,
    }

    struct CommittedBurnedEvent has copy, drop {
        committed_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct CommittedIncreasedEvent has copy, drop {
        committed_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct CommittedDecreasedEvent has copy, drop {
        committed_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct COMMITTED has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer(arg0: Committed, arg1: address) {
        0x2::transfer::transfer<Committed>(arg0, arg1);
    }

    public(friend) fun burn_and_emit(arg0: Committed, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CommittedBurnedEvent{
            committed_id : 0x2::object::id<Committed>(&arg0),
            owner        : 0x2::tx_context::sender(arg1),
            amount       : arg0.amount,
        };
        0x2::event::emit<CommittedBurnedEvent>(v0);
        let Committed {
            id          : v1,
            dao_fund_id : _,
            image_url   : _,
            amount      : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun decrease_commit_amount(arg0: &mut Committed, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.amount = arg0.amount - arg1;
        let v0 = CommittedDecreasedEvent{
            committed_id : 0x2::object::id<Committed>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            amount       : arg1,
        };
        0x2::event::emit<CommittedDecreasedEvent>(v0);
    }

    public(friend) fun get_committed_amount(arg0: &Committed) : u64 {
        arg0.amount
    }

    public(friend) fun get_committed_dao(arg0: &Committed) : 0x2::object::ID {
        arg0.dao_fund_id
    }

    public(friend) fun increase_commit_amount(arg0: &mut Committed, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.amount = arg0.amount + arg1;
        let v0 = CommittedIncreasedEvent{
            committed_id : 0x2::object::id<Committed>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            amount       : arg1,
        };
        0x2::event::emit<CommittedIncreasedEvent>(v0);
    }

    fun init(arg0: COMMITTED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidaos Committed NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidaos Committed NFT"));
        let v4 = 0x2::package::claim<COMMITTED>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Committed>(&v4, v0, v2, arg1);
        0x2::display::update_version<Committed>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Committed>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_and_emit(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Committed {
        let v0 = Committed{
            id          : 0x2::object::new(arg2),
            dao_fund_id : arg0,
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLK2IrzRcJe2AnqE5MbsrmIBrm0gzhAzY-cw&s"),
            amount      : arg1,
        };
        let v1 = CommittedMintedEvent{
            committed_id : 0x2::object::id<Committed>(&v0),
            dao_fund_id  : arg0,
            image_url    : v0.image_url,
            owner        : 0x2::tx_context::sender(arg2),
            amount       : arg1,
        };
        0x2::event::emit<CommittedMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}


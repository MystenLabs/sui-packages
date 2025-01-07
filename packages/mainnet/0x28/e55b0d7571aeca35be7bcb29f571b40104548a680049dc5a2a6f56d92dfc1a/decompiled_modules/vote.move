module 0x28e55b0d7571aeca35be7bcb29f571b40104548a680049dc5a2a6f56d92dfc1a::vote {
    struct Poll has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        options: vector<0x1::string::String>,
        votes_count: vector<u64>,
        votes: 0x2::table::Table<0x1::string::String, u64>,
        isActive: bool,
    }

    struct PollCollection has key {
        id: 0x2::object::UID,
        poll_coll: vector<0x2::object::ID>,
    }

    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct VOTE has drop {
        dummy_field: bool,
    }

    public entry fun changeStatus(arg0: &mut Poll, arg1: bool) {
        arg0.isActive = arg1;
    }

    public entry fun createPoll(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: &mut PollCollection, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = Poll{
            id          : 0x2::object::new(arg3),
            question    : arg0,
            options     : arg1,
            votes_count : v0,
            votes       : 0x2::table::new<0x1::string::String, u64>(arg3),
            isActive    : true,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.poll_coll, 0x2::object::id<Poll>(&v2));
        0x2::transfer::transfer<Poll>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun getVotesCount(arg0: &mut Poll) : vector<u64> {
        arg0.votes_count
    }

    fun init(arg0: VOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<VOTE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = PollCollection{
            id        : 0x2::object::new(arg1),
            poll_coll : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<PollCollection>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun registerVote(arg0: u64, arg1: 0x1::string::String, arg2: &mut Poll, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg2.votes_count, arg0);
        *v0 = *v0 + 1;
        0x2::table::add<0x1::string::String, u64>(&mut arg2.votes, arg1, arg0);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Nas NFT"),
            description : 0x1::string::utf8(b"Ja sam glasao!"),
            image_url   : 0x1::string::utf8(b"https://media.istockphoto.com/id/1204426739/vector/i-voted-sticker-with-us-american-flag.jpg?s=612x612&w=0&k=20&c=Qe88b5NShFhgGczuYJSXWyOFNUhoPnMg3tDyWUAo69o="),
        };
        0x2::transfer::transfer<NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}


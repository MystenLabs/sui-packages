module 0xa945d82c8139b216557c4b0ecb74b2d03635d8f894f4925a9b3c69959091f383::voting {
    struct Poll has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        options: vector<0x1::string::String>,
        vote_counts: vector<u64>,
        votes: 0x2::table::Table<0x1::string::String, u64>,
        isActive: bool,
    }

    struct PollCollection has key {
        id: 0x2::object::UID,
        poll_collection: vector<0x2::object::ID>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        descripton: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct VOTING has drop {
        dummy_field: bool,
    }

    public entry fun changePollStatus(arg0: &mut Poll, arg1: bool) {
        arg0.isActive = arg1;
    }

    public entry fun createPoll(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: &mut PollCollection, arg3: &mut 0x2::tx_context::TxContext) : bool {
        if (0x1::vector::length<0x1::string::String>(&arg1) == 0) {
            abort 3
        };
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
            vote_counts : v0,
            votes       : 0x2::table::new<0x1::string::String, u64>(arg3),
            isActive    : true,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.poll_collection, 0x2::object::id<Poll>(&v2));
        0x2::transfer::transfer<Poll>(v2, 0x2::tx_context::sender(arg3));
        true
    }

    public entry fun getPollVotes(arg0: &Poll) : vector<u64> {
        arg0.vote_counts
    }

    fun init(arg0: VOTING, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<VOTING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = PollCollection{
            id              : 0x2::object::new(arg1),
            poll_collection : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<PollCollection>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun registerVote(arg0: &mut Poll, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.votes, arg2)) {
            abort 1
        };
        if (!arg0.isActive) {
            abort 2
        };
        if (arg1 >= 0x1::vector::length<0x1::string::String>(&arg0.options)) {
            abort 3
        };
        0x2::table::add<0x1::string::String, u64>(&mut arg0.votes, arg2, arg1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.vote_counts, arg1);
        *v0 = *v0 + 1;
        let v1 = NFT{
            id         : 0x2::object::new(arg3),
            name       : 0x1::string::utf8(b"I voted"),
            descripton : 0x1::string::utf8(b"There was a poll and I was brave enough to state my opinion(anonymously lol)"),
            image_url  : 0x1::string::utf8(b"https://media.istockphoto.com/id/1204426739/vector/i-voted-sticker-with-us-american-flag.jpg?s=612x612&w=0&k=20&c=Qe88b5NShFhgGczuYJSXWyOFNUhoPnMg3tDyWUAo69o="),
        };
        0x2::transfer::transfer<NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}


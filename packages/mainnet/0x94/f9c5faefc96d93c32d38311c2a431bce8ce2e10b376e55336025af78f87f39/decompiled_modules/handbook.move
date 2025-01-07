module 0x94f9c5faefc96d93c32d38311c2a431bce8ce2e10b376e55336025af78f87f39::handbook {
    struct HANDBOOK has drop {
        dummy_field: bool,
    }

    struct HandBook has key {
        id: 0x2::object::UID,
        deploy_finished: 0x2::table_vec::TableVec<0x2::object::ID>,
        deploy_open: 0x2::table::Table<0x2::object::ID, bool>,
        vote_claimed: 0x2::table_vec::TableVec<0x2::object::ID>,
        vote_unclaimed: 0x2::table::Table<0x2::object::ID, bool>,
        deploy_count: u64,
        vote_count: u64,
        points: u64,
        alpha: 0x1::string::String,
    }

    struct MintHandBook has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    public fun alpha(arg0: &HandBook) : 0x1::string::String {
        arg0.alpha
    }

    public(friend) fun claim_vote(arg0: 0x2::object::ID, arg1: &mut HandBook) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.vote_unclaimed, arg0)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.vote_unclaimed, arg0);
            0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.vote_claimed, arg0);
        };
    }

    public fun deploy_count(arg0: &HandBook) : u64 {
        arg0.deploy_count
    }

    public fun deploy_finished(arg0: &HandBook) : &0x2::table_vec::TableVec<0x2::object::ID> {
        &arg0.deploy_finished
    }

    public fun deploy_open(arg0: &HandBook) : &0x2::table::Table<0x2::object::ID, bool> {
        &arg0.deploy_open
    }

    fun init(arg0: HANDBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"points"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"HandBook"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x94f9c5faefc96d93c32d38311c2a431bce8ce2e10b376e55336025af78f87f39::vt_svg::generateSVG(b"{alpha}")));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{points}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://karmapi.ai/"));
        let v5 = 0x2::package::claim<HANDBOOK>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<HandBook>(&v5, v1, v3, arg1);
        0x2::display::update_version<HandBook>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<HandBook>>(v6, v0);
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = HandBook{
            id              : 0x2::object::new(arg0),
            deploy_finished : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            deploy_open     : 0x2::table::new<0x2::object::ID, bool>(arg0),
            vote_claimed    : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            vote_unclaimed  : 0x2::table::new<0x2::object::ID, bool>(arg0),
            deploy_count    : 0,
            vote_count      : 0,
            points          : 0,
            alpha           : 0x1::string::utf8(b"0.0"),
        };
        let v2 = MintHandBook{
            id     : 0x2::object::id<HandBook>(&v1),
            sender : v0,
        };
        0x2::event::emit<MintHandBook>(v2);
        0x2::transfer::transfer<HandBook>(v1, v0);
    }

    public(friend) fun new_deploy(arg0: 0x2::object::ID, arg1: &mut HandBook) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.deploy_open, arg0, true);
        arg1.deploy_count = arg1.deploy_count + 1;
        arg1.points = arg1.points + 3;
        update_alpha(arg1);
    }

    public(friend) fun new_vote(arg0: 0x2::object::ID, arg1: &mut HandBook) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.vote_unclaimed, arg0)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.vote_unclaimed, arg0, true);
            arg1.vote_count = arg1.vote_count + 1;
            arg1.points = arg1.points + 1;
            update_alpha(arg1);
        };
    }

    fun num_to_alpha(arg0: u64) : vector<u8> {
        let v0 = b"0123456789";
        let v1 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v1 = v1 + 1;
        };
        let v2 = b"";
        if (v1 < 10) {
            0x1::vector::push_back<u8>(&mut v2, 48);
            0x1::vector::push_back<u8>(&mut v2, 46);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v1));
        } else {
            0x1::vector::push_back<u8>(&mut v2, 49);
            0x1::vector::push_back<u8>(&mut v2, 46);
            0x1::vector::push_back<u8>(&mut v2, 48);
        };
        v2
    }

    public fun points(arg0: &HandBook) : u64 {
        arg0.points
    }

    public(friend) fun settle_deploy(arg0: 0x2::object::ID, arg1: &mut HandBook) {
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.deploy_open, arg0);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.deploy_finished, arg0);
    }

    fun update_alpha(arg0: &mut HandBook) {
        arg0.alpha = 0x1::string::utf8(num_to_alpha(arg0.points));
    }

    public fun vote_claimed(arg0: &HandBook) : &0x2::table_vec::TableVec<0x2::object::ID> {
        &arg0.vote_claimed
    }

    public fun vote_count(arg0: &HandBook) : u64 {
        arg0.vote_count
    }

    public fun vote_unclaimed(arg0: &HandBook) : &0x2::table::Table<0x2::object::ID, bool> {
        &arg0.vote_unclaimed
    }

    // decompiled from Move bytecode v6
}


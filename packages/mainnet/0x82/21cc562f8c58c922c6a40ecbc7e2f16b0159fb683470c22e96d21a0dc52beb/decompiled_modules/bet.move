module 0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::bet {
    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        phase: u8,
        title: 0x1::string::String,
        description: 0x1::string::String,
        quorum: u64,
        size: u64,
        players: vector<address>,
        judges: vector<address>,
        votes: 0x2::vec_map::VecMap<address, address>,
        funds: 0x2::vec_map::VecMap<address, 0x2::coin::Coin<T0>>,
        answers: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        most_votes: u64,
        winner: 0x1::option::Option<address>,
    }

    struct CreateBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        bet_title: 0x1::string::String,
    }

    struct BET has drop {
        dummy_field: bool,
    }

    public fun size<T0>(arg0: &Bet<T0>) : u64 {
        arg0.size
    }

    public entry fun cancel<T0>(arg0: &mut Bet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 103);
        assert!(0x2::vec_map::is_empty<address, 0x2::coin::Coin<T0>>(&arg0.funds), 300);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.players, &v0) || 0x1::vector::contains<address>(&arg0.judges, &v0), 301);
        arg0.phase = 3;
    }

    public entry fun create<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<address>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        let v1 = 0x1::vector::length<address>(&arg5);
        assert!(v0 >= 2 && v0 <= 256, 2);
        assert!(v1 >= 1 && v1 <= 32, 3);
        assert!(!0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vectors::has_duplicates<address>(&arg4), 4);
        assert!(!0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vectors::has_duplicates<address>(&arg5), 5);
        assert!(!0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vectors::intersect<address>(&arg4, &arg5), 0);
        assert!(arg2 > v1 / 2 && arg2 <= v1, 6);
        assert!(arg3 > 0, 7);
        let v2 = 0x2::object::new(arg6);
        let v3 = CreateBetEvent{
            bet_id    : 0x2::object::uid_to_inner(&v2),
            bet_title : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<CreateBetEvent>(v3);
        let v4 = Bet<T0>{
            id          : v2,
            phase       : 0,
            title       : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            quorum      : arg2,
            size        : arg3,
            players     : arg4,
            judges      : arg5,
            votes       : 0x2::vec_map::empty<address, address>(),
            funds       : 0x2::vec_map::empty<address, 0x2::coin::Coin<T0>>(),
            answers     : 0x2::vec_map::empty<address, 0x1::string::String>(),
            most_votes  : 0,
            winner      : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Bet<T0>>(v4);
    }

    public fun description<T0>(arg0: &Bet<T0>) : &0x1::string::String {
        &arg0.description
    }

    public entry fun fund<T0>(arg0: &mut Bet<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.phase == 0, 103);
        assert!(0x1::vector::contains<address>(&arg0.players, &v0), 100);
        assert!(!0x2::vec_map::contains<address, 0x2::coin::Coin<T0>>(&arg0.funds, &v0), 101);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg0.size, 102);
        let v2 = v1 - arg0.size;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::vec_map::insert<address, 0x2::coin::Coin<T0>>(&mut arg0.funds, v0, arg2);
        0x2::vec_map::insert<address, 0x1::string::String>(&mut arg0.answers, v0, 0x1::string::utf8(arg1));
        if (0x2::vec_map::size<address, 0x2::coin::Coin<T0>>(&arg0.funds) == 0x1::vector::length<address>(&arg0.players)) {
            arg0.phase = 1;
        };
    }

    public fun funds<T0>(arg0: &Bet<T0>) : &0x2::vec_map::VecMap<address, 0x2::coin::Coin<T0>> {
        &arg0.funds
    }

    fun init(arg0: BET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BET>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Bet: {title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://gotbeef.app/bet/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://gotbeef.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://polymedia.app"));
        let v5 = 0x2::display::new_with_fields<Bet<0x2::sui::SUI>>(&v0, v1, v3, arg1);
        0x2::display::update_version<Bet<0x2::sui::SUI>>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Bet<0x2::sui::SUI>>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun is_stalemate<T0>(arg0: &Bet<T0>) : bool {
        0x1::vector::length<address>(&arg0.judges) - 0x2::vec_map::size<address, address>(&arg0.votes) < arg0.quorum - arg0.most_votes
    }

    public fun judges<T0>(arg0: &Bet<T0>) : &vector<address> {
        &arg0.judges
    }

    public fun most_votes<T0>(arg0: &Bet<T0>) : u64 {
        arg0.most_votes
    }

    public fun phase<T0>(arg0: &Bet<T0>) : u8 {
        arg0.phase
    }

    public fun players<T0>(arg0: &Bet<T0>) : &vector<address> {
        &arg0.players
    }

    public fun quorum<T0>(arg0: &Bet<T0>) : u64 {
        arg0.quorum
    }

    public fun title<T0>(arg0: &Bet<T0>) : &0x1::string::String {
        &arg0.title
    }

    public entry fun vote<T0>(arg0: &mut Bet<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.phase == 1, 200);
        assert!(0x1::vector::contains<address>(&arg0.judges, &v0), 201);
        assert!(!0x2::vec_map::contains<address, address>(&arg0.votes, &v0), 202);
        assert!(0x1::vector::contains<address>(&arg0.players, &arg1), 203);
        0x2::vec_map::insert<address, address>(&mut arg0.votes, v0, arg1);
        let v1 = 0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vec_maps::count_value<address, address>(&arg0.votes, &arg1);
        if (v1 > arg0.most_votes) {
            arg0.most_votes = v1;
        };
        if (v1 == arg0.quorum) {
            0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::transfers::send_all<address, T0>(&mut arg0.funds, arg1, arg2);
            arg0.winner = 0x1::option::some<address>(arg1);
            arg0.phase = 2;
            return
        };
        if (is_stalemate<T0>(arg0)) {
            0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::transfers::refund_all<T0>(&mut arg0.funds);
            arg0.phase = 4;
            return
        };
    }

    public fun votes<T0>(arg0: &Bet<T0>) : &0x2::vec_map::VecMap<address, address> {
        &arg0.votes
    }

    public fun winner<T0>(arg0: &Bet<T0>) : &0x1::option::Option<address> {
        &arg0.winner
    }

    // decompiled from Move bytecode v6
}


module 0xf4517da5dbd2379382d7d09934308aa55c5fdd9a9b0684c3e12e5e997cf5ce2c::suidouble_score {
    struct NewSuiScoreEvent has copy, drop {
        sui_score_id: 0x2::object::ID,
        for: address,
        score: u64,
    }

    struct SUIDOUBLE_SCORE has drop {
        dummy_field: bool,
    }

    struct SuiScore has store, key {
        id: 0x2::object::UID,
        for: address,
        score: u64,
        metadata: vector<u8>,
    }

    struct SuiScoreMaintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        score_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun change_fee(arg0: &mut SuiScoreMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut SuiScoreMaintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public fun id(arg0: &SuiScore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: SUIDOUBLE_SCORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Human Score"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-bot-score-04f61376a410.herokuapp.com/score/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suidouble.github.io/scores/{score}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"I am {score}% human"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-bot-score-04f61376a410.herokuapp.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidouble"));
        let v4 = 0x2::package::claim<SUIDOUBLE_SCORE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiScore>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiScore>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiScore>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SuiScoreMaintainer{
            id                 : 0x2::object::new(arg1),
            maintainer_address : 0x2::tx_context::sender(arg1),
            score_count        : 0,
            fee                : 200000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SuiScoreMaintainer>(v6);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg1, v1);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun mint(arg0: &mut SuiScoreMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_and_split(arg1, arg0.fee, arg5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg5));
        let v2 = SuiScore{
            id       : 0x2::object::new(arg5),
            for      : arg3,
            score    : arg2,
            metadata : arg4,
        };
        let v3 = NewSuiScoreEvent{
            sui_score_id : 0x2::object::uid_to_inner(&v2.id),
            for          : arg3,
            score        : arg2,
        };
        0x2::event::emit<NewSuiScoreEvent>(v3);
        arg0.score_count = arg0.score_count + 1;
        0x2::transfer::transfer<SuiScore>(v2, arg3);
    }

    public entry fun pay_maintainer(arg0: &mut SuiScoreMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


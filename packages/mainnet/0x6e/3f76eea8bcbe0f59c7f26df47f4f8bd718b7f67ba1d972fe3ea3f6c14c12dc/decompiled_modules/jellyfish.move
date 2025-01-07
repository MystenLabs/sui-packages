module 0x6e3f76eea8bcbe0f59c7f26df47f4f8bd718b7f67ba1d972fe3ea3f6c14c12dc::jellyfish {
    struct JELLYFISH has drop {
        dummy_field: bool,
    }

    struct JellyFish has store, key {
        id: 0x2::object::UID,
        amount: u64,
        color: 0x1::string::String,
        alpha: 0x1::string::String,
    }

    struct MintRepo has key {
        id: 0x2::object::UID,
        supply: u64,
        remain: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SplitRepo has key {
        id: 0x2::object::UID,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RepoCap has store, key {
        id: 0x2::object::UID,
    }

    struct NewJellyFish has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        color: 0x1::string::String,
    }

    struct BurnJellyFish has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        amount: u64,
        message: 0x1::string::String,
    }

    public entry fun split(arg0: &mut JellyFish, arg1: &mut SplitRepo, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<JellyFish>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun alpha(arg0: &JellyFish) : 0x1::string::String {
        arg0.alpha
    }

    public fun amount(arg0: &JellyFish) : u64 {
        arg0.amount
    }

    public entry fun burn(arg0: JellyFish, arg1: &mut MintRepo, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        do_burn(arg0, arg1, arg2, arg3);
    }

    public fun color(arg0: &JellyFish) : 0x1::string::String {
        arg0.color
    }

    public fun do_burn(arg0: JellyFish, arg1: &mut MintRepo, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.supply = arg1.supply - arg0.amount;
        let v0 = BurnJellyFish{
            id      : 0x2::object::id<JellyFish>(&arg0),
            sender  : 0x2::tx_context::sender(arg3),
            amount  : arg0.amount,
            message : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<BurnJellyFish>(v0);
        drop_jellyfish(arg0);
    }

    public fun do_merge(arg0: &mut JellyFish, arg1: JellyFish) {
        arg0.amount = arg0.amount + arg1.amount;
        drop_jellyfish(arg1);
    }

    public fun do_split(arg0: &mut JellyFish, arg1: &mut SplitRepo, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : JellyFish {
        assert!(arg3 > 0 && arg0.amount > arg3, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.fee, 0x2::coin::split<0x2::sui::SUI>(arg2, 1000000, arg4));
        arg0.amount = arg0.amount - arg3;
        new_jellyfish(arg3, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee), arg4)
    }

    fun drop_jellyfish(arg0: JellyFish) {
        let JellyFish {
            id     : v0,
            amount : _,
            color  : _,
            alpha  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"JellyPi"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x6e3f76eea8bcbe0f59c7f26df47f4f8bd718b7f67ba1d972fe3ea3f6c14c12dc::svg::generateSVG(b"{color}", b"{alpha}")));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://karmapi.ai/"));
        let v5 = 0x2::package::claim<JELLYFISH>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<JellyFish>(&v5, v1, v3, arg1);
        0x2::display::update_version<JellyFish>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<JellyFish>>(v6, v0);
        let v7 = MintRepo{
            id      : 0x2::object::new(arg1),
            supply  : 2620000,
            remain  : 2620000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MintRepo>(v7);
        let v8 = SplitRepo{
            id  : 0x2::object::new(arg1),
            fee : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SplitRepo>(v8);
        let v9 = RepoCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RepoCap>(v9, v0);
        0x2::transfer::public_transfer<JellyFish>(new_jellyfish(2500000, 0, arg1), v0);
    }

    public entry fun merge(arg0: &mut JellyFish, arg1: JellyFish) {
        do_merge(arg0, arg1);
    }

    public entry fun mint(arg0: &mut MintRepo, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg1, 100000000, arg2));
        0x2::transfer::public_transfer<JellyFish>(new_jellyfish(32, arg0.remain, arg2), v0);
        arg0.remain = arg0.remain - 32;
    }

    fun new_jellyfish(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : JellyFish {
        assert!(arg0 > 0, 1);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x6e3f76eea8bcbe0f59c7f26df47f4f8bd718b7f67ba1d972fe3ea3f6c14c12dc::utils::data_to_RGB(0x2::object::uid_to_bytes(&v0), arg1);
        let v2 = NewJellyFish{
            id     : 0x2::object::uid_to_inner(&v0),
            sender : 0x2::tx_context::sender(arg2),
            color  : v1,
        };
        0x2::event::emit<NewJellyFish>(v2);
        JellyFish{
            id     : v0,
            amount : arg0,
            color  : v1,
            alpha  : 0x1::string::utf8(0x6e3f76eea8bcbe0f59c7f26df47f4f8bd718b7f67ba1d972fe3ea3f6c14c12dc::utils::num_to_alpha(arg0)),
        }
    }

    public fun remain(arg0: &MintRepo) : u64 {
        arg0.remain
    }

    public fun supply(arg0: &MintRepo) : u64 {
        arg0.supply
    }

    public fun withdraw_mint_repo(arg0: &RepoCap, arg1: &mut MintRepo, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_split_repo(arg0: &RepoCap, arg1: &mut SplitRepo, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fee), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


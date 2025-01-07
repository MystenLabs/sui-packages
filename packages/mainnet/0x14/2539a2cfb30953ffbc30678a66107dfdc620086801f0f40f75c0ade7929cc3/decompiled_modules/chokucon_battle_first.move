module 0x729123f3ef6d25548cfd055f8749a86ccc5accc62bdf5fd5d96c7085fc4a090c::chokucon_battle_first {
    struct CHOKUCON_BATTLE_FIRST has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Director has store, key {
        id: 0x2::object::UID,
        paused: bool,
        participants: 0x2::table::Table<address, bool>,
        minted: 0x2::table::Table<address, bool>,
        rewarded: 0x2::table::Table<address, bool>,
        mint_success_reward: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ChallengerNFT has store, key {
        id: 0x2::object::UID,
    }

    struct MasterNFT has store, key {
        id: 0x2::object::UID,
    }

    struct Reward<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun add_mint_success_reward(arg0: &mut Director, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.mint_success_reward, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun add_reward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Reward<T0>>(v0);
    }

    public fun admin_add_participants(arg0: &AdminCap, arg1: &mut Director, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, bool>(&arg1.participants, v1) == false) {
                0x2::table::add<address, bool>(&mut arg1.participants, v1, true);
            };
            v0 = v0 - 1;
        };
    }

    public fun admin_pause(arg0: &AdminCap, arg1: &mut Director) {
        arg1.paused = true;
    }

    public fun admin_resume(arg0: &AdminCap, arg1: &mut Director) {
        arg1.paused = false;
    }

    public fun admin_update_image_url(arg0: &AdminCap, arg1: &mut 0x2::display::Display<ChallengerNFT>, arg2: 0x1::string::String) {
        0x2::display::edit<ChallengerNFT>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<ChallengerNFT>(arg1);
    }

    public entry fun admin_withdraw_mint_reward(arg0: &AdminCap, arg1: &mut Director, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.mint_success_reward), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun admin_withdraw_reward<T0>(arg0: &AdminCap, arg1: &mut Reward<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun get_reward<T0>(arg0: &ChallengerNFT, arg1: &mut Director, arg2: &mut Reward<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused == false, 100);
        assert!(0x2::table::contains<address, bool>(&arg1.participants, 0x2::tx_context::sender(arg3)) == true, 101);
        assert!(0x2::table::contains<address, bool>(&arg1.rewarded, 0x2::tx_context::sender(arg3)) == false, 103);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg3), 0x2::tx_context::sender(arg3));
        0x2::table::add<address, bool>(&mut arg1.rewarded, 0x2::tx_context::sender(arg3), true);
        let v0 = MasterNFT{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<MasterNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: CHOKUCON_BATTLE_FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Chokucon Battle 1st Challenger NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://yefpkulasxjrieeyvjzj.supabase.co/storage/v1/object/public/images/Chokucon_Battle_1st_Challenger_NFT.png"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Chokucon Battle 1st Master NFT"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://yefpkulasxjrieeyvjzj.supabase.co/storage/v1/object/public/images/Chokucon_Battle_1st_Master_NFT.png"));
        let v8 = 0x2::package::claim<CHOKUCON_BATTLE_FIRST>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<ChallengerNFT>(&v8, v0, v2, arg1);
        0x2::display::update_version<ChallengerNFT>(&mut v9);
        let v10 = 0x2::display::new_with_fields<MasterNFT>(&v8, v4, v6, arg1);
        0x2::display::update_version<MasterNFT>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<ChallengerNFT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MasterNFT>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v11, 0x2::tx_context::sender(arg1));
        let v12 = Director{
            id                  : 0x2::object::new(arg1),
            paused              : true,
            participants        : 0x2::table::new<address, bool>(arg1),
            minted              : 0x2::table::new<address, bool>(arg1),
            rewarded            : 0x2::table::new<address, bool>(arg1),
            mint_success_reward : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<Director>(v12, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut Director, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 100);
        assert!(0x2::table::contains<address, bool>(&arg0.participants, 0x2::tx_context::sender(arg1)) == true, 101);
        assert!(0x2::table::contains<address, bool>(&arg0.minted, 0x2::tx_context::sender(arg1)) == false, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.mint_success_reward, 5000000000), arg1), 0x2::tx_context::sender(arg1));
        0x2::table::add<address, bool>(&mut arg0.minted, 0x2::tx_context::sender(arg1), true);
        let v0 = ChallengerNFT{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ChallengerNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


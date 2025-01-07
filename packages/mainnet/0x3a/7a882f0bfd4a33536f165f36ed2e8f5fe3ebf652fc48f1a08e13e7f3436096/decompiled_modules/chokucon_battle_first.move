module 0x3a7a882f0bfd4a33536f165f36ed2e8f5fe3ebf652fc48f1a08e13e7f3436096::chokucon_battle_first {
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
    }

    struct KeyNFT has store, key {
        id: 0x2::object::UID,
    }

    struct Reward<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun add_participant(arg0: &AdminCap, arg1: &mut Director, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.participants, arg2) == false) {
            0x2::table::add<address, bool>(&mut arg1.participants, arg2, true);
        };
    }

    public fun add_participants(arg0: &AdminCap, arg1: &mut Director, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            add_participant(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 - 1;
        };
    }

    public entry fun add_reward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Reward<T0>>(v0);
    }

    public fun admin_pause(arg0: &AdminCap, arg1: &mut Director) {
        arg1.paused = true;
    }

    public fun admin_resume(arg0: &AdminCap, arg1: &mut Director) {
        arg1.paused = false;
    }

    public fun admin_update_image_url(arg0: &AdminCap, arg1: &mut 0x2::display::Display<KeyNFT>, arg2: 0x1::string::String) {
        0x2::display::edit<KeyNFT>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<KeyNFT>(arg1);
    }

    public entry fun get_reward<T0>(arg0: &KeyNFT, arg1: &Director, arg2: &mut Reward<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg1.participants, 0x2::tx_context::sender(arg3)) == true, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: CHOKUCON_BATTLE_FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Director{
            id           : 0x2::object::new(arg1),
            paused       : false,
            participants : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::transfer<Director>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Chokucon Battle First Key NFT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://yefpkulasxjrieeyvjzj.supabase.co/storage/v1/object/public/images/Chokucon_Battle_1st_KeyNFT.png"));
        let v6 = 0x2::package::claim<CHOKUCON_BATTLE_FIRST>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<KeyNFT>(&v6, v2, v4, arg1);
        0x2::display::update_version<KeyNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<KeyNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &Director, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_(arg0, arg1);
        0x2::transfer::transfer<KeyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_(arg0: &Director, arg1: &mut 0x2::tx_context::TxContext) : KeyNFT {
        assert!(arg0.paused == false, 100);
        assert!(0x2::table::contains<address, bool>(&arg0.participants, 0x2::tx_context::sender(arg1)) == true, 101);
        KeyNFT{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}


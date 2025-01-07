module 0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::trader {
    struct TRADER has drop {
        dummy_field: bool,
    }

    struct Trader has key {
        id: 0x2::object::UID,
        last_name: 0x1::string::String,
        first_name: 0x1::string::String,
        card_img: 0x1::string::String,
        pfp_img: 0x1::string::String,
        birth: u64,
    }

    struct HostController has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        register_fee: u64,
    }

    struct Name has copy, drop, store {
        dummy_field: bool,
    }

    struct Rename has copy, drop {
        trader_id: 0x2::object::ID,
        new_first_name: 0x1::string::String,
        new_last_name: 0x1::string::String,
    }

    struct Mint has copy, drop {
        trader_id: 0x2::object::ID,
        new_first_name: 0x1::string::String,
        new_last_name: 0x1::string::String,
    }

    struct UpdatePFP has copy, drop {
        trader_id: 0x2::object::ID,
        pfp_img: 0x1::string::String,
        card_img: 0x1::string::String,
    }

    fun assert_if_balance_not_matched(arg0: &HostController, arg1: &0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg0.register_fee == 0x2::balance::value<0x2::sui::SUI>(arg1), 3);
    }

    fun assert_if_no_ns(arg0: &Trader) {
        let v0 = Name{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<Name>(&arg0.id, v0), 2);
    }

    public(friend) fun assert_if_ns_expired_by_card(arg0: &Trader, arg1: &0x2::clock::Clock) {
        let v0 = Name{dummy_field: false};
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(0x2::dynamic_object_field::borrow<Name, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.id, v0), arg1), 1);
    }

    fun assert_if_ns_expired_by_ns(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &0x2::clock::Clock) {
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg0, arg1), 1);
    }

    public fun birth(arg0: &Trader) : u64 {
        arg0.birth
    }

    public fun card_img(arg0: &Trader) : 0x1::string::String {
        arg0.card_img
    }

    public fun first_name(arg0: &Trader) : 0x1::string::String {
        arg0.first_name
    }

    public fun id(arg0: &Trader) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    fun init(arg0: TRADER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stingrey: {first_name} {last_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Trader Certificate"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator-devnet.walrus.space/v1/{card_img}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://stingray.walrus.site"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<TRADER>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Trader>(&v5, v0, v2, arg1);
        0x2::display::update_version<Trader>(&mut v6);
        let v7 = HostController{
            id           : 0x2::object::new(arg1),
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            register_fee : 10000000,
        };
        0x2::transfer::public_transfer<0x2::display::Display<Trader>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
        0x2::transfer::share_object<HostController>(v7);
    }

    public fun last_name(arg0: &Trader) : 0x1::string::String {
        arg0.last_name
    }

    public entry fun mint(arg0: &mut 0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::GlobalConfig, arg1: &mut HostController, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::assert_if_version_not_matched(arg0, 1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        assert_if_ns_expired_by_ns(&arg2, arg6);
        assert_if_balance_not_matched(arg1, &v0);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg2);
        let v2 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v1);
        let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg2);
        let v4 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(&v3);
        let v5 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v5, v2);
        0x1::string::append(&mut v5, v4);
        let v6 = Trader{
            id         : 0x2::object::new(arg7),
            last_name  : v4,
            first_name : v2,
            card_img   : arg4,
            pfp_img    : arg3,
            birth      : 0x2::clock::timestamp_ms(arg6),
        };
        let v7 = Name{dummy_field: false};
        0x2::dynamic_object_field::add<Name, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v6.id, v7, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, v0);
        let v8 = Mint{
            trader_id      : *0x2::object::uid_as_inner(&v6.id),
            new_first_name : v2,
            new_last_name  : v4,
        };
        0x2::event::emit<Mint>(v8);
        0x2::transfer::transfer<Trader>(v6, 0x2::tx_context::sender(arg7));
    }

    public fun name(arg0: &Trader) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, first_name(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v0, last_name(arg0));
        v0
    }

    public fun pfp_img(arg0: &Trader) : 0x1::string::String {
        arg0.pfp_img
    }

    public fun rename(arg0: &0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::GlobalConfig, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &mut Trader, arg3: &mut 0x2::tx_context::TxContext) {
        0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_no_ns(arg2);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg1);
        let v1 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg1);
        let v3 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(&v2);
        if (*0x1::string::as_bytes(&arg2.first_name) == *0x1::string::as_bytes(&v1) && *0x1::string::as_bytes(&arg2.last_name) == *0x1::string::as_bytes(&v3)) {
            abort 0
        };
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, arg2.first_name);
        0x1::string::append(&mut v4, arg2.last_name);
        arg2.first_name = v1;
        arg2.last_name = v3;
        v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, arg2.first_name);
        0x1::string::append(&mut v4, arg2.last_name);
        let v5 = Name{dummy_field: false};
        let v6 = Name{dummy_field: false};
        0x2::dynamic_object_field::add<Name, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg2.id, v6, arg1);
        let v7 = Rename{
            trader_id      : *0x2::object::uid_as_inner(&arg2.id),
            new_first_name : v1,
            new_last_name  : v3,
        };
        0x2::event::emit<Rename>(v7);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x2::dynamic_object_field::remove<Name, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg2.id, v5), 0x2::tx_context::sender(arg3));
    }

    public entry fun take_sui_ns(arg0: &mut Trader, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Name{dummy_field: false};
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, arg0.first_name);
        0x1::string::append(&mut v1, arg0.last_name);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x2::dynamic_object_field::remove<Name, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg0.id, v0), 0x2::tx_context::sender(arg1));
    }

    public fun updatePfp(arg0: &0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::GlobalConfig, arg1: &mut Trader, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::assert_if_version_not_matched(arg0, 1);
        arg1.pfp_img = arg2;
        arg1.card_img = arg3;
        let v0 = UpdatePFP{
            trader_id : *0x2::object::uid_as_inner(&arg1.id),
            pfp_img   : arg2,
            card_img  : arg3,
        };
        0x2::event::emit<UpdatePFP>(v0);
    }

    public fun withdraw(arg0: &0xe3736f5af2d7d11e898c5e6e7e4421b0c4738a1c5766f1541f6cc07a7b99f23e::config::AdminCap, arg1: &mut HostController, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}


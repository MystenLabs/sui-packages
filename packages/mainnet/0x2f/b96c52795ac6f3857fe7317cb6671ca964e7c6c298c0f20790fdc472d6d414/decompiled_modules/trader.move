module 0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::trader {
    struct TRADER has drop {
        dummy_field: bool,
    }

    struct Trader has key {
        id: 0x2::object::UID,
        last_name: 0x1::string::String,
        first_name: 0x1::string::String,
        card_img: 0x1::string::String,
        pfp_img: 0x1::string::String,
        description: 0x1::string::String,
        birth: u64,
    }

    struct HostController has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        register_fee: u64,
        mint_record: 0x2::table::Table<address, 0x2::object::ID>,
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
        minter: address,
        description: 0x1::string::String,
        pfp_img: 0x1::string::String,
    }

    struct UpdatePFP has copy, drop {
        trader_id: 0x2::object::ID,
        pfp_img: 0x1::string::String,
        card_img: 0x1::string::String,
    }

    fun assert_if_already_minted(arg0: &HostController, arg1: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.mint_record, 0x2::tx_context::sender(arg1)), 4);
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stingray: {first_name} {last_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/{card_img}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://stingraylabs.xyz"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<TRADER>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Trader>(&v5, v0, v2, arg1);
        0x2::display::update_version<Trader>(&mut v6);
        let v7 = HostController{
            id           : 0x2::object::new(arg1),
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            register_fee : 1000000000,
            mint_record  : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_transfer<0x2::display::Display<Trader>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
        0x2::transfer::share_object<HostController>(v7);
    }

    public fun last_name(arg0: &Trader) : 0x1::string::String {
        arg0.last_name
    }

    public entry fun mint(arg0: &mut 0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::GlobalConfig, arg1: &mut HostController, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::assert_if_version_not_matched(arg0, 1);
        assert_if_already_minted(arg1, arg8);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        assert_if_balance_not_matched(arg1, &v0);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v2 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v1);
        let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v4 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(&v3);
        let v5 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v5, v2);
        0x1::string::append(&mut v5, v4);
        let v6 = Trader{
            id          : 0x2::object::new(arg8),
            last_name   : v4,
            first_name  : v2,
            card_img    : arg4,
            pfp_img     : arg3,
            description : arg5,
            birth       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, v0);
        let v7 = Mint{
            trader_id      : *0x2::object::uid_as_inner(&v6.id),
            new_first_name : v2,
            new_last_name  : v4,
            minter         : 0x2::tx_context::sender(arg8),
            description    : arg5,
            pfp_img        : arg3,
        };
        0x2::event::emit<Mint>(v7);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.mint_record, 0x2::tx_context::sender(arg8), *0x2::object::uid_as_inner(&v6.id));
        0x2::transfer::transfer<Trader>(v6, 0x2::tx_context::sender(arg8));
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

    public fun rename(arg0: &0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::GlobalConfig, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &mut Trader, arg3: &mut 0x2::tx_context::TxContext) {
        0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::assert_if_version_not_matched(arg0, 1);
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

    public fun updatePfp(arg0: &0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::GlobalConfig, arg1: &mut Trader, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::assert_if_version_not_matched(arg0, 1);
        arg1.pfp_img = arg2;
        arg1.card_img = arg3;
        let v0 = UpdatePFP{
            trader_id : *0x2::object::uid_as_inner(&arg1.id),
            pfp_img   : arg2,
            card_img  : arg3,
        };
        0x2::event::emit<UpdatePFP>(v0);
    }

    public fun withdraw(arg0: &0x2fb96c52795ac6f3857fe7317cb6671ca964e7c6c298c0f20790fdc472d6d414::config::AdminCap, arg1: &mut HostController, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}


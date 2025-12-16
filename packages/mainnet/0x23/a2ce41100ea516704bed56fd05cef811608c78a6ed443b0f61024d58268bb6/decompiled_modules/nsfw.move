module 0x23a2ce41100ea516704bed56fd05cef811608c78a6ed443b0f61024d58268bb6::nsfw {
    struct NSFW has drop {
        dummy_field: bool,
    }

    struct RandomHentai has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        reference: 0x1::string::String,
    }

    struct Template has copy, drop, store {
        url: 0x1::string::String,
        name: 0x1::string::String,
        reference: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        templates: vector<Template>,
        balance: 0x2::balance::Balance<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun add_options(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == v0, 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = Template{
                url       : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                name      : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                reference : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
            };
            0x1::vector::push_back<Template>(&mut arg1.templates, v2);
            v1 = v1 + 1;
        };
    }

    entry fun burn(arg0: RandomHentai) {
        let RandomHentai {
            id        : v0,
            image_url : _,
            name      : _,
            reference : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NSFW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NSFW>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"reference"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"{reference}"));
        let v3 = 0x2::display::new_with_fields<RandomHentai>(&v0, v1, v2, arg1);
        0x2::display::update_version<RandomHentai>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RandomHentai>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = Registry{
            id        : 0x2::object::new(arg1),
            templates : 0x1::vector::empty<Template>(),
            balance   : 0x2::balance::zero<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(),
        };
        0x2::transfer::share_object<Registry>(v5);
    }

    entry fun mint(arg0: &mut Registry, arg1: 0x2::coin::Coin<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Template>(&arg0.templates);
        assert!(v0 > 0, 1);
        assert!(0x2::coin::value<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&arg1) >= 10000, 2);
        let v1 = 0x2::coin::into_balance<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(arg1);
        0x2::balance::join<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&mut arg0.balance, 0x2::balance::split<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&mut v1, 10000));
        if (0x2::balance::value<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>>(0x2::coin::from_balance<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(v1);
        };
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x1::vector::borrow<Template>(&arg0.templates, 0x2::random::generate_u64_in_range(&mut v2, 0, v0 - 1));
        let v4 = RandomHentai{
            id        : 0x2::object::new(arg3),
            image_url : v3.url,
            name      : v3.name,
            reference : v3.reference,
        };
        0x2::transfer::public_transfer<RandomHentai>(v4, 0x2::tx_context::sender(arg3));
    }

    entry fun remove_option(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg2 < 0x1::vector::length<Template>(&arg1.templates), 0);
        0x1::vector::swap_remove<Template>(&mut arg1.templates, arg2);
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>>(0x2::coin::take<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&mut arg1.balance, 0x2::balance::value<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


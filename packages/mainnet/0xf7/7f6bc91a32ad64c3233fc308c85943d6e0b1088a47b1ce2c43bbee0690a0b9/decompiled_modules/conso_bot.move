module 0xf77f6bc91a32ad64c3233fc308c85943d6e0b1088a47b1ce2c43bbee0690a0b9::conso_bot {
    struct CONSO_BOT has drop {
        dummy_field: bool,
    }

    struct ConsoBot has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted: u64,
        price: u64,
        is_open: bool,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x2::transfer::public_transfer<ConsoBot>(new_bot(arg1, arg4), arg3);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: CONSO_BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CONSO_BOT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Conso Bots collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://pbs.twimg.com/profile_images/2012401638288580608/sTOpVtIH_400x400.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Conso Bots"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Conso Bots"));
        let v5 = 0x2::display::new_with_fields<ConsoBot>(&v0, v1, v3, arg1);
        0x2::display::update_version<ConsoBot>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ConsoBot>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Collection{
            id      : 0x2::object::new(arg1),
            minted  : 0,
            price   : 0,
            is_open : false,
            funds   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Collection>(v7);
    }

    public fun mint(arg0: &mut Collection, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.price, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.price, arg2)));
        let v0 = new_bot(arg0, arg2);
        0x2::transfer::public_transfer<ConsoBot>(v0, 0x2::tx_context::sender(arg2));
    }

    fun new_bot(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) : ConsoBot {
        assert!(arg0.minted < 555, 0);
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = 0x1::string::utf8(b"Conso Bot #");
        0x1::string::append(&mut v1, 0x1::u64::to_string(v0));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Bot"), 0x1::string::utf8(b"Common"));
        ConsoBot{
            id         : 0x2::object::new(arg1),
            name       : v1,
            number     : v0,
            attributes : v2,
        }
    }

    public fun set_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun set_price(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        arg1.price = arg2;
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.funds, 0x2::balance::value<0x2::sui::SUI>(&arg1.funds), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}


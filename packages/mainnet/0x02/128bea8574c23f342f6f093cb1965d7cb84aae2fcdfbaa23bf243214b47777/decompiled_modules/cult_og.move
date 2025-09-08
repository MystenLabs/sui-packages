module 0x2128bea8574c23f342f6f093cb1965d7cb84aae2fcdfbaa23bf243214b47777::cult_og {
    struct CultOg has store, key {
        id: 0x2::object::UID,
    }

    struct MintTracker has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, u8>,
        mint_count: u64,
        mint_limit: u64,
        price: u64,
        recipient: address,
    }

    struct CULT_OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT_OG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Culture OG"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This unique OG NFT is the ultimate proof of your early and unwavering belief in the Sui Culture."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/nkDehpyo9qzuv8uCClQiPg9oDcOyKANgV-MBwiaHSVI"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.suiculture.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suiculture.sui"));
        let v4 = 0x2::package::claim<CULT_OG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CultOg>(&v4, v0, v2, arg1);
        let v6 = MintTracker{
            id         : 0x2::object::new(arg1),
            records    : 0x2::table::new<address, u8>(arg1),
            mint_count : 0,
            mint_limit : 69,
            price      : 2500000000,
            recipient  : 0x2::tx_context::sender(arg1),
        };
        0x2::display::update_version<CultOg>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CultOg>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintTracker>(v6);
    }

    public fun mint(arg0: &mut MintTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : CultOg {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, u8>(&arg0.records, v0), 0);
        assert!(arg0.mint_count < arg0.mint_limit, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 2);
        arg0.mint_count = arg0.mint_count + 1;
        0x2::table::add<address, u8>(&mut arg0.records, v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.recipient);
        CultOg{id: 0x2::object::new(arg2)}
    }

    // decompiled from Move bytecode v6
}


module 0x8ebad5259b2e2de6f396fcb7e3e1d9d292337234ee898824e70a392b017acc6e::nft {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attribute: Attributes,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct TreasuryOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) : Attributes {
        Attributes{map: arg0}
    }

    public fun from_vec(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : Attributes {
        new(from_vec_to_map<0x1::ascii::String, 0x1::ascii::String>(arg0, arg1))
    }

    public fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 1);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = TreasuryOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TreasuryOwnerCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Treasury{
            id      : 0x2::object::new(arg1),
            price   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v7);
    }

    public fun mint(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= 1729605600000, 1001);
        if (v0 >= 1729608300000 && v0 < 1729611000000) {
            arg0.price = 5550000000;
        } else if (v0 >= 1729611000000 && v0 < 1729618200000) {
            arg0.price = 7770000000;
        } else if (v0 >= 1729618200000) {
            arg0.price = 11110000000;
        };
        if (v0 >= 1729608300000) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.price, 1002);
            let v1 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg0.price);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1, arg0.price, arg8), @0xe245700132c452988cb51a3f111ba5be984e5ab80faba14a2828d6c20f7aec5a);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v1);
        };
        let v2 = Hero{
            id          : 0x2::object::new(arg8),
            name        : arg3,
            image_url   : arg4,
            description : arg5,
            attribute   : from_vec(arg6, arg7),
        };
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v2.id),
            creator   : v3,
            name      : v2.name,
        };
        0x2::event::emit<MintNFTEvent>(v4);
        0x2::transfer::public_transfer<Hero>(v2, v3);
    }

    // decompiled from Move bytecode v6
}


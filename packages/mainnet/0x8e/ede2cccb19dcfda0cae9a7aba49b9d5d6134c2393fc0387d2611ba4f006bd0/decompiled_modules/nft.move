module 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::nft {
    struct Factory has key {
        id: 0x2::object::UID,
        specs: 0x2::vec_map::VecMap<0x2::object::ID, Spec>,
    }

    struct Spec has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        supply: u64,
        available: u64,
        price: u64,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        spec_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id          : v0,
            spec_id     : _,
            name        : _,
            description : _,
            url         : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_spec(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut Factory, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Spec{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
            supply      : arg5,
            available   : arg5,
            price       : arg6,
        };
        0x2::vec_map::insert<0x2::object::ID, Spec>(&mut arg1.specs, 0x2::object::uid_to_inner(&v0.id), v0);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id    : 0x2::object::new(arg1),
            specs : 0x2::vec_map::empty<0x2::object::ID, Spec>(),
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://bob.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Eric Team"));
        let v5 = 0x2::package::claim<NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Nft>(&v5, v1, v3, arg1);
        0x2::display::update_version<Nft>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(0x2::vec_map::contains<0x2::object::ID, Spec>(&arg0.specs, &arg1), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Spec>(&mut arg0.specs, &arg1);
        assert!(v0.available != 0, 5);
        v0.available = v0.available - 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0.price, 6);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::deposit<0x2::sui::SUI>(arg2, arg3);
        let v1 = Nft{
            id          : 0x2::object::new(arg4),
            spec_id     : arg1,
            name        : v0.name,
            description : v0.description,
            url         : v0.url,
            image_url   : v0.url,
        };
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_nft_minted_event(0x2::object::id<Nft>(&v1), 0x2::tx_context::sender(arg4), v1.name);
        v1
    }

    // decompiled from Move bytecode v6
}


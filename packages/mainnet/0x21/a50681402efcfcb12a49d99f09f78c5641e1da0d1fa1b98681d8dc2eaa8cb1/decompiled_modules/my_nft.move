module 0x21a50681402efcfcb12a49d99f09f78c5641e1da0d1fa1b98681d8dc2eaa8cb1::my_nft {
    struct JOJONFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: JOJONFT) {
        0x2::table::remove<address, u64>(&mut arg0.record, arg1.recipient);
        let JOJONFT {
            id        : v0,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for your Github avatar"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        let v5 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v6 = 0x2::display::new<JOJONFT>(&v5, arg1);
        0x2::display::update_version<JOJONFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JOJONFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v4);
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, u64>(&arg0.record, arg3), 0);
        let v0 = 0x2::table::length<address, u64>(&arg0.record) + 1;
        0x2::table::add<address, u64>(&mut arg0.record, arg3, v0);
        assert!(v0 <= 46, 1);
        let v1 = JOJONFT{
            id        : 0x2::object::new(arg4),
            nft_id    : v0,
            name      : arg1,
            image_url : arg2,
            creator   : 0x2::tx_context::sender(arg4),
            recipient : arg3,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<JOJONFT>(&v1),
            creator   : 0x2::tx_context::sender(arg4),
            name      : arg1,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<JOJONFT>(v1, arg3);
    }

    // decompiled from Move bytecode v6
}


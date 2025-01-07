module 0x1702e3dcc6a39597e65d5edda6998e02499c29964a77c850c3e2bdb2ab0c1b2e::alexwaker_nft {
    struct ALEXWAKER_NFT has drop {
        dummy_field: bool,
    }

    struct AlexwakerNFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, vector<u64>>,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: AlexwakerNFT) {
        let v0 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.record, arg1.recipient);
        let (v1, v2) = 0x1::vector::index_of<u64>(v0, &arg1.nft_id);
        if (v1) {
            0x1::vector::remove<u64>(v0, v2);
        };
        if (0x1::vector::is_empty<u64>(v0)) {
            0x2::table::remove<address, vector<u64>>(&mut arg0.record, arg1.recipient);
        };
        let AlexwakerNFT {
            id        : v3,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    fun init(arg0: ALEXWAKER_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for AlexWaker's Github avatar"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, vector<u64>>(arg1),
        };
        let v5 = 0x2::package::claim<ALEXWAKER_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<AlexwakerNFT>(&v5, v0, v2, arg1);
        0x2::transfer::share_object<MintRecord>(v4);
        0x2::display::update_version<AlexwakerNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AlexwakerNFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<address, vector<u64>>(&arg0.record, arg3)) {
            0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.record, arg3))
        } else {
            0
        };
        assert!(v0 < 3, 2);
        let v1 = 0x2::table::length<address, vector<u64>>(&arg0.record) + 1;
        assert!(v1 <= 1000, 0);
        if (0x2::table::contains<address, vector<u64>>(&arg0.record, arg3)) {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.record, arg3), v1);
        } else {
            let v2 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v2, v1);
            0x2::table::add<address, vector<u64>>(&mut arg0.record, arg3, v2);
        };
        let v3 = AlexwakerNFT{
            id        : 0x2::object::new(arg4),
            nft_id    : v1,
            name      : arg1,
            image_url : arg2,
            creator   : 0x2::tx_context::sender(arg4),
            recipient : arg3,
        };
        let v4 = NFTMinted{
            object_id : 0x2::object::id<AlexwakerNFT>(&v3),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v3.name,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<AlexwakerNFT>(v3, arg3);
    }

    // decompiled from Move bytecode v6
}


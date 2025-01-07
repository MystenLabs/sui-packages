module 0x416a821364630e10171ca531af3495996e713756a29554c99bc13622cd67ce22::windynanzi_nft {
    struct WINDYNANZI_NFT has drop {
        dummy_field: bool,
    }

    struct Windynanzi_NFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: Windynanzi_NFT) {
        0x2::table::remove<address, u64>(&mut arg0.record, arg1.recipient);
        let Windynanzi_NFT {
            id        : v0,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: WINDYNANZI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WINDYNANZI_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A NFT for your Github avatar"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        let v6 = 0x2::display::new_with_fields<Windynanzi_NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<Windynanzi_NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Windynanzi_NFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v5);
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, u64>(&arg0.record, arg3), 1);
        let v0 = 0x2::table::length<address, u64>(&arg0.record) + 1;
        assert!(v0 <= 10, 0);
        0x2::table::add<address, u64>(&mut arg0.record, arg3, v0);
        let v1 = Windynanzi_NFT{
            id        : 0x2::object::new(arg4),
            nft_id    : v0,
            name      : arg1,
            image_url : arg2,
            creator   : 0x2::tx_context::sender(arg4),
            recipient : arg3,
        };
        let v2 = NFTMinted{
            id      : 0x2::object::id<Windynanzi_NFT>(&v1),
            creator : 0x2::tx_context::sender(arg4),
            name    : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Windynanzi_NFT>(v1, arg3);
    }

    // decompiled from Move bytecode v6
}


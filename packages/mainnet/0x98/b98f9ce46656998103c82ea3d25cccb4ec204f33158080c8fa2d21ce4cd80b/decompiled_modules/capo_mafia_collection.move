module 0x98b98f9ce46656998103c82ea3d25cccb4ec204f33158080c8fa2d21ce4cd80b::capo_mafia_collection {
    struct CAPO_MAFIA_COLLECTION has drop {
        dummy_field: bool,
    }

    struct CapoCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
    }

    struct CapoMafiaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
    }

    struct NFTBurned has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        burner: address,
    }

    public entry fun burn_nft(arg0: CapoMafiaNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let CapoMafiaNFT {
            id            : v0,
            name          : v1,
            description   : _,
            url           : _,
            collection_id : _,
        } = arg0;
        let v5 = v0;
        let v6 = NFTBurned{
            id     : 0x2::object::uid_to_inner(&v5),
            name   : v1,
            burner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTBurned>(v6);
        0x2::object::delete(v5);
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CapoCollection{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<CapoCollection>(v0);
    }

    fun init(arg0: CAPO_MAFIA_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAPO_MAFIA_COLLECTION>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<CapoCollection>(&v0, v1, v3, arg1);
        0x2::display::update_version<CapoCollection>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"collection_id"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{collection_id}"));
        let v10 = 0x2::display::new_with_fields<CapoMafiaNFT>(&v0, v6, v8, arg1);
        0x2::display::update_version<CapoMafiaNFT>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CapoCollection>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CapoMafiaNFT>>(v10, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut CapoCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CapoMafiaNFT{
            id            : 0x2::object::new(arg4),
            name          : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            url           : 0x2::url::new_unsafe_from_bytes(arg3),
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::transfer::transfer<CapoMafiaNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}


module 0xa863c4a5f90659507b9e063be52f752fb43d8e88b9805c345dd9efa7ed7e81f7::pandakey {
    struct PANDAKEY has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Attribute has drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct PandaKeyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: vector<Attribute>,
        alpha: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        attributes: vector<0x1::string::String>,
        alpha: 0x1::string::String,
    }

    struct NFTUpdated has copy, drop {
        object_id: 0x2::object::ID,
        field: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
        updater: address,
    }

    public fun transfer(arg0: PandaKeyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PandaKeyNFT>(arg0, arg1);
    }

    public fun url(arg0: &PandaKeyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun alpha(arg0: &PandaKeyNFT) : &0x1::string::String {
        &arg0.alpha
    }

    public fun attributes(arg0: &PandaKeyNFT) : &vector<Attribute> {
        &arg0.attributes
    }

    public fun attributes_as_json(arg0: &PandaKeyNFT) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"[");
        let v1 = 0;
        let v2 = 0x1::vector::length<Attribute>(&arg0.attributes);
        while (v1 < v2) {
            let v3 = 0x1::vector::borrow<Attribute>(&arg0.attributes, v1);
            0x1::string::append(&mut v0, 0x1::string::utf8(b"{\"trait_type\":\""));
            0x1::string::append(&mut v0, v3.trait_type);
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\",\"value\":\""));
            0x1::string::append(&mut v0, v3.value);
            0x1::string::append(&mut v0, 0x1::string::utf8(b"\"}"));
            if (v1 < v2 - 1) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b","));
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"]"));
        v0
    }

    public entry fun batch_mint(arg0: &OwnerCap, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<vector<vector<u8>>>>, arg5: vector<vector<u8>>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 > 0 && v0 <= 50, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == v0, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == v0, 4);
        assert!(0x1::vector::length<vector<vector<vector<u8>>>>(&arg4) == v0, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 4);
        let v1 = 0;
        while (v1 < v0) {
            mint(arg0, 0x1::vector::remove<vector<u8>>(&mut arg1, 0), 0x1::vector::remove<vector<u8>>(&mut arg2, 0), 0x1::vector::remove<vector<u8>>(&mut arg3, 0), 0x1::vector::remove<vector<vector<vector<u8>>>>(&mut arg4, 0), 0x1::vector::remove<vector<u8>>(&mut arg5, 0), arg6, arg7);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        0x1::vector::destroy_empty<vector<u8>>(arg3);
        0x1::vector::destroy_empty<vector<vector<vector<u8>>>>(arg4);
        0x1::vector::destroy_empty<vector<u8>>(arg5);
    }

    public fun batch_transfer(arg0: vector<PandaKeyNFT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PandaKeyNFT>(&arg0)) {
            0x2::transfer::public_transfer<PandaKeyNFT>(0x1::vector::remove<PandaKeyNFT>(&mut arg0, 0), arg1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<PandaKeyNFT>(arg0);
    }

    public fun burn(arg0: &OwnerCap, arg1: PandaKeyNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let PandaKeyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
            alpha       : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PandaKeyNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: PANDAKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<PANDAKEY>(arg0, arg1);
        let v2 = 0x2::display::new<PandaKeyNFT>(&v1, arg1);
        0x2::display::add<PandaKeyNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PandaKeyNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PandaKeyNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<PandaKeyNFT>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes_as_json}"));
        0x2::display::update_version<PandaKeyNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<PandaKeyNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &OwnerCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<vector<u8>>>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Attribute>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<vector<u8>>>(&arg4)) {
            let v3 = 0x1::vector::remove<vector<vector<u8>>>(&mut arg4, 0);
            assert!(0x1::vector::length<vector<u8>>(&v3) == 2, 1);
            let v4 = 0x1::string::utf8(0x1::vector::remove<vector<u8>>(&mut v3, 0));
            let v5 = 0x1::string::utf8(0x1::vector::remove<vector<u8>>(&mut v3, 0));
            let v6 = Attribute{
                trait_type : v4,
                value      : v5,
            };
            0x1::vector::push_back<Attribute>(&mut v0, v6);
            0x1::string::append(&mut v4, 0x1::string::utf8(b":"));
            0x1::string::append(&mut v4, v5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v4);
            0x1::vector::destroy_empty<vector<u8>>(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<vector<u8>>>(arg4);
        let v7 = PandaKeyNFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes  : v0,
            alpha       : 0x1::string::utf8(arg5),
        };
        let v8 = NFTMinted{
            object_id  : 0x2::object::id<PandaKeyNFT>(&v7),
            creator    : 0x2::tx_context::sender(arg7),
            name       : v7.name,
            attributes : v1,
            alpha      : v7.alpha,
        };
        0x2::event::emit<NFTMinted>(v8);
        0x2::transfer::public_transfer<PandaKeyNFT>(v7, arg6);
    }

    public fun name(arg0: &PandaKeyNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_alpha(arg0: &OwnerCap, arg1: &mut PandaKeyNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg2) < 512, 2);
        arg1.alpha = 0x1::string::utf8(arg2);
        let v0 = NFTUpdated{
            object_id : 0x2::object::id<PandaKeyNFT>(arg1),
            field     : 0x1::string::utf8(b"alpha"),
            old_value : arg1.alpha,
            new_value : arg1.alpha,
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUpdated>(v0);
    }

    public entry fun update_attributes(arg0: &OwnerCap, arg1: &mut PandaKeyNFT, arg2: vector<vector<vector<u8>>>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.attributes = 0x1::vector::empty<Attribute>();
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<vector<u8>>>(&arg2)) {
            let v1 = 0x1::vector::remove<vector<vector<u8>>>(&mut arg2, 0);
            assert!(0x1::vector::length<vector<u8>>(&v1) == 2, 1);
            let v2 = Attribute{
                trait_type : 0x1::string::utf8(0x1::vector::remove<vector<u8>>(&mut v1, 0)),
                value      : 0x1::string::utf8(0x1::vector::remove<vector<u8>>(&mut v1, 0)),
            };
            0x1::vector::push_back<Attribute>(&mut arg1.attributes, v2);
            0x1::vector::destroy_empty<vector<u8>>(v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<vector<u8>>>(arg2);
        let v3 = NFTUpdated{
            object_id : 0x2::object::id<PandaKeyNFT>(arg1),
            field     : 0x1::string::utf8(b"attributes"),
            old_value : attributes_as_json(arg1),
            new_value : attributes_as_json(arg1),
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUpdated>(v3);
    }

    public entry fun update_description(arg0: &OwnerCap, arg1: &mut PandaKeyNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg2) < 1024, 2);
        arg1.description = 0x1::string::utf8(arg2);
        let v0 = NFTUpdated{
            object_id : 0x2::object::id<PandaKeyNFT>(arg1),
            field     : 0x1::string::utf8(b"description"),
            old_value : arg1.description,
            new_value : arg1.description,
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUpdated>(v0);
    }

    public entry fun update_name(arg0: &OwnerCap, arg1: &mut PandaKeyNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg2) < 256, 2);
        arg1.name = 0x1::string::utf8(arg2);
        let v0 = NFTUpdated{
            object_id : 0x2::object::id<PandaKeyNFT>(arg1),
            field     : 0x1::string::utf8(b"name"),
            old_value : arg1.name,
            new_value : arg1.name,
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUpdated>(v0);
    }

    public entry fun update_url(arg0: &OwnerCap, arg1: &mut PandaKeyNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg2) < 512, 2);
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = NFTUpdated{
            object_id : 0x2::object::id<PandaKeyNFT>(arg1),
            field     : 0x1::string::utf8(b"url"),
            old_value : 0x1::string::utf8(0x1::ascii::into_bytes(0x2::url::inner_url(&arg1.url))),
            new_value : 0x1::string::utf8(0x1::ascii::into_bytes(0x2::url::inner_url(&arg1.url))),
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}


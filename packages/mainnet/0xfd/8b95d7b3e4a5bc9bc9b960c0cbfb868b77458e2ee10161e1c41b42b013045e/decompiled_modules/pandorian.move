module 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian {
    struct PANDORIAN has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MintMetadataAddedEvent has copy, drop {
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: vector<u8>,
        attribute_keys: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
    }

    struct PandorianMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attribute_keys: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
    }

    struct MintMetadata has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: vector<u8>,
        attribute_keys: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
    }

    struct Pandorian has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::attributes::Attributes,
    }

    public fun get_description(arg0: &Pandorian) : 0x1::string::String {
        arg0.description
    }

    public fun get_name(arg0: &Pandorian) : 0x1::string::String {
        arg0.name
    }

    public fun get_url(arg0: &Pandorian) : 0x2::url::Url {
        arg0.url
    }

    fun init(arg0: PANDORIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PANDORIAN>(arg0, arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::collection::display(&v0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://pandorafi.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<Pandorian>(&v0, v1, v3, arg1);
        0x2::display::update_version<Pandorian>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Pandorian>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Pandorian>(&mut v9, &v8, 200, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Pandorian>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Pandorian>(&mut v9, &v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x2::transfer::public_transfer<0x2::display::Display<Pandorian>>(v5, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pandorian>>(v8, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pandorian>>(v9);
        0x2::transfer::public_share_object<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::collection::Collection>(0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::collection::new(arg1));
    }

    public(friend) fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0x2::tx_context::TxContext) : Pandorian {
        let v0 = Pandorian{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::attributes::new_from_vec(arg3, arg4),
        };
        let v1 = PandorianMintedEvent{
            id               : 0x2::object::id<Pandorian>(&v0),
            name             : arg0,
            description      : arg1,
            url              : v0.url,
            attribute_keys   : arg3,
            attribute_values : arg4,
        };
        0x2::event::emit<PandorianMintedEvent>(v1);
        v0
    }

    public(friend) fun mint_nft_by_metadata(arg0: MintMetadata, arg1: &mut 0x2::tx_context::TxContext) : Pandorian {
        let MintMetadata {
            name             : v0,
            description      : v1,
            url              : v2,
            attribute_keys   : v3,
            attribute_values : v4,
        } = arg0;
        let v5 = Pandorian{
            id          : 0x2::object::new(arg1),
            name        : v0,
            description : v1,
            url         : 0x2::url::new_unsafe_from_bytes(v2),
            attributes  : 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::attributes::new_from_vec(v3, v4),
        };
        let v6 = PandorianMintedEvent{
            id               : 0x2::object::id<Pandorian>(&v5),
            name             : v0,
            description      : v1,
            url              : v5.url,
            attribute_keys   : v3,
            attribute_values : v4,
        };
        0x2::event::emit<PandorianMintedEvent>(v6);
        v5
    }

    public(friend) fun new_mint_metadata(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) : MintMetadata {
        let v0 = MintMetadata{
            name             : arg0,
            description      : arg1,
            url              : arg2,
            attribute_keys   : arg3,
            attribute_values : arg4,
        };
        let v1 = MintMetadataAddedEvent{
            name             : arg0,
            description      : arg1,
            url              : arg2,
            attribute_keys   : arg3,
            attribute_values : arg4,
        };
        0x2::event::emit<MintMetadataAddedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}


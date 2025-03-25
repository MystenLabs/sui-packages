module 0xb0ced3eb4c57b776534bc0c5339234363c7ae649e1e7fd11556f863410bd8960::nft {
    struct Attribute has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Contents has copy, drop, store {
        attributes: vector<Attribute>,
    }

    struct Attributes has copy, drop, store {
        contents: Contents,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        edition: u64,
        date: u64,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
        attributes: Attributes,
    }

    public fun create_attribute(arg0: 0x1::string::String, arg1: 0x1::string::String) : Attribute {
        Attribute{
            key   : arg0,
            value : arg1,
        }
    }

    public fun create_attributes(arg0: Contents) : Attributes {
        Attributes{contents: arg0}
    }

    public fun create_contents(arg0: vector<Attribute>) : Contents {
        Contents{attributes: arg0}
    }

    public fun create_nft_with_ipfs(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id                 : 0x2::object::new(arg8),
            name               : arg1,
            description        : arg2,
            image_url          : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg3)),
            edition            : arg4,
            date               : arg5,
            kiosk_id           : arg6,
            kiosk_owner_cap_id : arg7,
            attributes         : create_attributes(create_contents(0x1::vector::empty<Attribute>())),
        }
    }

    public fun edition(arg0: &Nft) : u64 {
        arg0.edition
    }

    public fun get_attribute_at(arg0: &Nft, arg1: u64) : Attribute {
        *0x1::vector::borrow<Attribute>(&arg0.attributes.contents.attributes, arg1)
    }

    public fun get_attribute_count(arg0: &Nft) : u64 {
        0x1::vector::length<Attribute>(&arg0.attributes.contents.attributes)
    }

    public fun get_attributes(arg0: &Nft) : vector<Attribute> {
        arg0.attributes.contents.attributes
    }

    public fun image_url(arg0: &Nft) : 0x2::url::Url {
        arg0.image_url
    }

    public fun update_attributes(arg0: &mut Nft, arg1: vector<Attribute>) {
        arg0.attributes = create_attributes(create_contents(arg1));
    }

    public fun update_image_url(arg0: &mut Nft, arg1: 0x1::string::String) {
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg1));
    }

    public fun update_metadata(arg0: &mut Nft, arg1: 0x1::string::String, arg2: vector<Attribute>) {
        update_image_url(arg0, arg1);
        update_attributes(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}


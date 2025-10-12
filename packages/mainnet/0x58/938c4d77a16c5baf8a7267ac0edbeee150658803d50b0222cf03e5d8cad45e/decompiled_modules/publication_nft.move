module 0x58938c4d77a16c5baf8a7267ac0edbeee150658803d50b0222cf03e5d8cad45e::publication_nft {
    struct PublicationNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        authors: 0x1::string::String,
        publication_date: u64,
        doi: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        license: 0x1::string::String,
        field: 0x1::string::String,
        version: 0x1::string::String,
        external_url: 0x2::url::Url,
    }

    struct PUBLICATION_NFT has drop {
        dummy_field: bool,
    }

    struct PublicationMinted has copy, drop {
        object_id: address,
        creator: address,
        title: 0x1::string::String,
        authors: 0x1::string::String,
    }

    public fun url(arg0: &PublicationNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun authors(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.authors
    }

    public fun burn(arg0: PublicationNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PublicationNFT {
            id               : v0,
            title            : _,
            authors          : _,
            publication_date : _,
            doi              : _,
            url              : _,
            image_url        : _,
            description      : _,
            license          : _,
            field            : _,
            version          : _,
            external_url     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.description
    }

    public fun doi(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.doi
    }

    public fun external_url(arg0: &PublicationNFT) : &0x2::url::Url {
        &arg0.external_url
    }

    public fun field(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.field
    }

    public fun image_url(arg0: &PublicationNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: PUBLICATION_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"title"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"authors"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"publication_date"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"doi"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"license"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"field"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/tomespel/publication-nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Publication NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{authors}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{publication_date}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{doi}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{license}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{field}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{external_url}"));
        let v4 = 0x2::package::claim<PUBLICATION_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PublicationNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<PublicationNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PublicationNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun license(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.license
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicationNFT{
            id               : 0x2::object::new(arg12),
            title            : arg0,
            authors          : arg1,
            publication_date : arg2,
            doi              : arg3,
            url              : 0x2::url::new_unsafe_from_bytes(arg4),
            image_url        : 0x2::url::new_unsafe_from_bytes(arg5),
            description      : arg6,
            license          : arg7,
            field            : arg8,
            version          : arg9,
            external_url     : 0x2::url::new_unsafe_from_bytes(arg10),
        };
        let v1 = PublicationMinted{
            object_id : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg12),
            title     : arg0,
            authors   : arg1,
        };
        0x2::event::emit<PublicationMinted>(v1);
        0x2::transfer::public_transfer<PublicationNFT>(v0, arg11);
    }

    public fun publication_date(arg0: &PublicationNFT) : u64 {
        arg0.publication_date
    }

    public fun title(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.title
    }

    public fun transfer_nft(arg0: PublicationNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PublicationNFT>(arg0, arg1);
    }

    public fun version(arg0: &PublicationNFT) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v6
}


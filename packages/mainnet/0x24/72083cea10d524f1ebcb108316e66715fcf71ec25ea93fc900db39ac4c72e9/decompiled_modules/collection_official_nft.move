module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft {
    struct COLLECTION_OFFICIAL_NFT has drop {
        dummy_field: bool,
    }

    struct CollectionOfficialNft has store, key {
        id: 0x2::object::UID,
        index: u64,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        creator: address,
        total_support: u64,
        supporters: vector<CollectionOfficialSupporter>,
        supporter_index: u64,
        timestamp_ms: u64,
    }

    struct CollectionOfficialSupporter has copy, drop, store {
        supporter: address,
        amount: u64,
        index: u64,
    }

    struct CollectionOfficialNftRecord has drop, store {
        official_nft_id: 0x2::object::ID,
        royalties: u64,
    }

    public(friend) fun add_royalties(arg0: &mut CollectionOfficialNftRecord, arg1: u64) {
        arg0.royalties = arg0.royalties + arg1;
    }

    public(friend) fun create_nft_record(arg0: 0x2::object::ID) : CollectionOfficialNftRecord {
        CollectionOfficialNftRecord{
            official_nft_id : arg0,
            royalties       : 0,
        }
    }

    public(friend) fun create_supporter(arg0: &0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter) : CollectionOfficialSupporter {
        CollectionOfficialSupporter{
            supporter : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporter_supporter(arg0),
            amount    : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporter_support_amount(arg0),
            index     : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporter_index(arg0),
        }
    }

    fun init(arg0: COLLECTION_OFFICIAL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x2::package::claim<COLLECTION_OFFICIAL_NFT>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}: The Collection Official NFT #{index}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"This artwork was selected by the community for The Collection in Election #{index}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thecollection.ai"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/K_N97SKiJU-jv-O4_7MwEwRnuGt5z7rJJp3GKJcRqBs"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A collection of AI art as selected by the community."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Ethos"));
        let v5 = 0x2::display::new_with_fields<CollectionOfficialNft>(&v2, v0, v3, arg1);
        0x2::display::update_version<CollectionOfficialNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CollectionOfficialNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: u64, arg1: 0x2::url::Url, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: vector<CollectionOfficialSupporter>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : CollectionOfficialNft {
        CollectionOfficialNft{
            id              : 0x2::object::new(arg8),
            index           : arg0,
            image_url       : arg1,
            title           : arg2,
            creator         : arg3,
            total_support   : arg4,
            supporters      : arg5,
            supporter_index : arg6,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg7),
        }
    }

    // decompiled from Move bytecode v6
}


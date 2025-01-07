module 0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::collection {
    struct HouseCollectionNFT has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        level: u64,
        attributes: 0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::attributes::Attributes,
    }

    struct HouseCollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<HouseCollectionNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<HouseCollectionNFT>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public fun image_url(arg0: &HouseCollectionNFT) : 0x2::url::Url {
        arg0.url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<HouseCollectionNFT>(&v0, arg1);
        0x2::display::add<HouseCollectionNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Official House Collection NFT {level}"));
        0x2::display::add<HouseCollectionNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Official House Collection NFT"));
        0x2::display::add<HouseCollectionNFT>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<HouseCollectionNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<HouseCollectionNFT>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<HouseCollectionNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<HouseCollectionNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::royalty_rule::add<HouseCollectionNFT>(&mut v5, &v4, 600, 0);
        0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::kiosk_lock_rule::add<HouseCollectionNFT>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<HouseCollectionNFT>>(v5);
        let v6 = HouseCollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v4,
        };
        0x2::transfer::public_transfer<HouseCollectionInfo>(v6, @0x13);
    }

    public fun level(arg0: &HouseCollectionNFT) : u64 {
        arg0.level
    }

    public(friend) fun mint_(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : HouseCollectionNFT {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Character"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Level"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, u128_to_string(((arg0 as u128) - 1) / 8 + 1));
        0x1::vector::push_back<0x1::string::String>(v3, u128_to_string((arg0 as u128)));
        HouseCollectionNFT{
            id         : 0x2::object::new(arg1),
            url        : 0x2::url::new_unsafe_from_bytes(0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::constants::get_nft_image((arg0 as u64))),
            level      : (arg0 as u64),
            attributes : 0xd9e036671f62a9cf725739d30aa5d441edf0bdaa667023bfac2f1ce2913a3ea8::attributes::from_vec(&mut v0, &mut v2),
        }
    }

    fun u128_to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}


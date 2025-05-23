module 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct AdBoardNFT has store, key {
        id: 0x2::object::UID,
        ad_space_id: 0x2::object::ID,
        owner: address,
        brand_name: 0x1::string::String,
        content_url: 0x1::string::String,
        project_url: 0x1::string::String,
        lease_start: u64,
        lease_end: u64,
        is_active: bool,
        blob_id: 0x1::option::Option<0x1::string::String>,
        storage_source: 0x1::string::String,
    }

    struct AdContentUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        content_url: 0x1::string::String,
        updated_by: address,
        blob_id: 0x1::option::Option<0x1::string::String>,
        storage_source: 0x1::string::String,
    }

    struct AdStatusUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        is_active: bool,
        updated_by: address,
    }

    struct LeaseRenewed has copy, drop {
        nft_id: 0x2::object::ID,
        renewed_by: address,
        lease_end: u64,
        price: u64,
        blob_id: 0x1::option::Option<0x1::string::String>,
    }

    public fun create_nft(arg0: &0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : AdBoardNFT {
        assert!(arg4 >= 1 && arg4 <= 365, 3);
        let v0 = if (arg5 == 0) {
            0x2::clock::timestamp_ms(arg8) / 1000
        } else {
            arg5
        };
        let v1 = if (arg5 == 0) {
            0x2::clock::timestamp_ms(arg8) / 1000 + arg4 * 86400
        } else {
            arg5 + arg4 * 86400
        };
        AdBoardNFT{
            id             : 0x2::object::new(arg9),
            ad_space_id    : 0x2::object::id<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(arg0),
            owner          : 0x2::tx_context::sender(arg9),
            brand_name     : arg1,
            content_url    : arg2,
            project_url    : arg3,
            lease_start    : v0,
            lease_end      : v1,
            is_active      : true,
            blob_id        : arg6,
            storage_source : arg7,
        }
    }

    public fun get_ad_space_id(arg0: &AdBoardNFT) : 0x2::object::ID {
        arg0.ad_space_id
    }

    public fun get_lease_status(arg0: &AdBoardNFT, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 <= arg0.lease_end
    }

    public fun get_owner(arg0: &AdBoardNFT) : address {
        arg0.owner
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"brand_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"lease_start"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"lease_end"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"blob_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"storage_source"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{brand_name} - Billboard Ad"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A digital billboard advertisement space in the metaverse"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{content_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{brand_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{lease_start}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{lease_end}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{is_active}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{storage_source}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AdBoardNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AdBoardNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AdBoardNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_active(arg0: &AdBoardNFT) : bool {
        arg0.is_active
    }

    public fun renew_lease(arg0: &mut AdBoardNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg1 >= 1 && arg1 <= 365, 3);
        arg0.lease_end = arg0.lease_end + arg1 * 86400;
        let v0 = LeaseRenewed{
            nft_id     : 0x2::object::id<AdBoardNFT>(arg0),
            renewed_by : 0x2::tx_context::sender(arg3),
            lease_end  : arg0.lease_end,
            price      : arg1 * 86400,
            blob_id    : arg0.blob_id,
        };
        0x2::event::emit<LeaseRenewed>(v0);
    }

    public fun set_active_status(arg0: &mut AdBoardNFT, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.is_active = arg1;
        let v0 = AdStatusUpdated{
            nft_id     : 0x2::object::id<AdBoardNFT>(arg0),
            is_active  : arg1,
            updated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdStatusUpdated>(v0);
    }

    public fun transfer_nft(arg0: AdBoardNFT, arg1: address) {
        0x2::transfer::transfer<AdBoardNFT>(arg0, arg1);
    }

    public fun update_content(arg0: &mut AdBoardNFT, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 <= arg0.lease_end, 2);
        arg0.content_url = arg1;
        arg0.blob_id = arg2;
        arg0.storage_source = arg3;
        let v0 = AdContentUpdated{
            nft_id         : 0x2::object::id<AdBoardNFT>(arg0),
            content_url    : arg1,
            updated_by     : 0x2::tx_context::sender(arg5),
            blob_id        : arg2,
            storage_source : arg3,
        };
        0x2::event::emit<AdContentUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}


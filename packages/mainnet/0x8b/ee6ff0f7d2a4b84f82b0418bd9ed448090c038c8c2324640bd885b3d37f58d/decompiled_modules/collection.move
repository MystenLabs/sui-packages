module 0x8bee6ff0f7d2a4b84f82b0418bd9ed448090c038c8c2324640bd885b3d37f58d::collection {
    struct HouseCollectionBannerNFT has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        tier: u64,
    }

    struct HouseCollectionBannerInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<HouseCollectionBannerNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<HouseCollectionBannerNFT>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    public fun image_url(arg0: &HouseCollectionBannerNFT) : 0x2::url::Url {
        arg0.url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<HouseCollectionBannerNFT>(&v0, arg1);
        0x2::display::add<HouseCollectionBannerNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Generis HC Banner #{tier}"));
        0x2::display::add<HouseCollectionBannerNFT>(&mut v1, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<HouseCollectionBannerNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{url}.ipfs.nftstorage.link/"));
        0x2::display::update_version<HouseCollectionBannerNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<HouseCollectionBannerNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x8bee6ff0f7d2a4b84f82b0418bd9ed448090c038c8c2324640bd885b3d37f58d::royalty_rule::add<HouseCollectionBannerNFT>(&mut v5, &v4, 600, 0);
        0x8bee6ff0f7d2a4b84f82b0418bd9ed448090c038c8c2324640bd885b3d37f58d::kiosk_lock_rule::add<HouseCollectionBannerNFT>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<HouseCollectionBannerNFT>>(v5);
        let v6 = HouseCollectionBannerInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v4,
        };
        0x2::transfer::public_transfer<HouseCollectionBannerInfo>(v6, @0x13);
    }

    public fun mint(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : HouseCollectionBannerNFT {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 10000000000, 0);
        assert!(arg0 > 0, 1);
        assert!(arg0 <= 8, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 175 / 1000, arg2), @0xb9728a1e9bab5baaec570cac6400d9499cd02e3d6256382fa13d7fa178f0573b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 175 / 1000, arg2), @0x1e74b41d4fbd76a3fd623bf079715f74cbc8823d2420b8c94d90cd79513cdb7f);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 175 / 1000, arg2), @0xd025596112c461476cdfad4ad39a4875fa21eefb76fe80b5c6ec136be3a81e38);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 175 / 1000, arg2), @0x9c740b0f351d6c300d6b2de7c46b56916f870eb548e160fd7b6499ec32d7500e);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 5 / 100, arg2), @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 5 / 100, arg2), @0x9da2dd62e4be7aaa1d20413c7d242ee79f2f21186460709d30cf216731e6ad16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
        let v0 = HouseCollectionBannerNFT{
            id   : 0x2::object::new(arg2),
            url  : 0x2::url::new_unsafe_from_bytes(0x8bee6ff0f7d2a4b84f82b0418bd9ed448090c038c8c2324640bd885b3d37f58d::constant::get_nft_image(arg0)),
            tier : arg0,
        };
        let v1 = MintEvent{nft: 0x2::object::id<HouseCollectionBannerNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}


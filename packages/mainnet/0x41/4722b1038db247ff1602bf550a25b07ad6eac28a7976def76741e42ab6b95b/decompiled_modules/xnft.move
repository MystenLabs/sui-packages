module 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft {
    struct XNFT has drop {
        dummy_field: bool,
    }

    struct XNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
        creator: 0x1::string::String,
        xid: u128,
        type: u8,
        rare: u16,
    }

    struct XNAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftPegVault has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        validator: 0x1::option::Option<vector<u8>>,
        display: 0x1::option::Option<0x2::display::Display<XNft>>,
        policyCap: 0x1::option::Option<0x2::transfer_policy::TransferPolicyCap<XNft>>,
    }

    struct PegNFTReq has copy, store {
        owner: address,
        xid: u128,
        type: u8,
        rare: u16,
        nonce: u128,
    }

    struct PegNFT has copy, drop {
        owner: address,
        xid: u128,
        type: u8,
        rare: u16,
        nonce: u128,
    }

    struct DePegNFT has copy, drop {
        owner: address,
        xid: u128,
        type: u8,
        rare: u16,
        nonce: u128,
    }

    struct PayXBirdRule has drop {
        dummy_field: bool,
    }

    struct PayXBirdRuleConfig has drop, store {
        vaule: u16,
    }

    struct PayCoinRule has drop {
        dummy_field: bool,
    }

    struct PayCoinRuleConfig has drop, store {
        vaule: u16,
    }

    fun burnNft(arg0: XNft) : (u128, u8, u16) {
        let XNft {
            id        : v0,
            name      : _,
            link      : _,
            image_url : _,
            creator   : _,
            xid       : v5,
            type      : v6,
            rare      : v7,
        } = arg0;
        0x2::object::delete(v0);
        (v5, v6, v7)
    }

    public fun createPayCoinPolicy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<XNft>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = PayCoinRule{dummy_field: false};
        let v5 = PayCoinRuleConfig{vaule: 10};
        0x2::transfer_policy::add_rule<XNft, PayCoinRule, PayCoinRuleConfig>(v4, &mut v3, &v2, v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<XNft>>(v3);
        0x2::transfer::public_freeze_object<0x2::transfer_policy::TransferPolicyCap<XNft>>(v2);
    }

    public fun createPayXBirdPolicy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<XNft>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = PayXBirdRule{dummy_field: false};
        let v5 = PayXBirdRuleConfig{vaule: 10};
        0x2::transfer_policy::add_rule<XNft, PayXBirdRule, PayXBirdRuleConfig>(v4, &mut v3, &v2, v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<XNft>>(v3);
        0x2::transfer::public_freeze_object<0x2::transfer_policy::TransferPolicyCap<XNft>>(v2);
    }

    public fun depegNft(arg0: &mut NftPegVault, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::archieve::UserArchieve, arg2: XNft, arg3: &0x2::clock::Clock, arg4: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = burnNft(arg2);
        let v3 = DePegNFT{
            owner : 0x2::tx_context::sender(arg5),
            xid   : v0,
            type  : v1,
            rare  : v2,
            nonce : 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::archieve::increaseGetNftDepegNonce(arg1),
        };
        0x2::event::emit<DePegNFT>(v3);
    }

    fun init(arg0: XNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<XNFT>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        createPayXBirdPolicy(&v0, arg1);
        createPayCoinPolicy(&v0, arg1);
        let v2 = NftPegVault{
            id        : 0x2::object::new(arg1),
            publisher : v0,
            validator : 0x1::option::none<vector<u8>>(),
            display   : 0x1::option::some<0x2::display::Display<XNft>>(v1),
            policyCap : 0x1::option::none<0x2::transfer_policy::TransferPolicyCap<XNft>>(),
        };
        0x2::transfer::public_share_object<NftPegVault>(v2);
        let v3 = XNAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<XNAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mintNftDefault(arg0: u128, arg1: u8, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : XNft {
        XNft{
            id        : 0x2::object::new(arg3),
            name      : 0x1::string::utf8(b"Default Nft"),
            link      : 0x2::url::new_unsafe_from_bytes(b"https://bird.io/worm/{id}"),
            image_url : 0x2::url::new_unsafe_from_bytes(b"ipfs://{img_url}"),
            creator   : 0x1::string::utf8(b"Bird Labs"),
            xid       : arg0,
            type      : arg1,
            rare      : arg2,
        }
    }

    public fun payByCoin<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<XNft>, arg1: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::Order, arg2: 0x2::coin::Coin<T0>) {
        let (v0, v1, v2) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::orderInfo(arg1);
        assert!(v0 == 0x2::transfer_policy::item<XNft>(arg0), 2002);
        assert!(v2 <= 0x2::coin::value<T0>(&arg2), 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        let v3 = PayCoinRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<XNft, PayCoinRule>(v3, arg0);
    }

    public fun payByXBird(arg0: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::BirdPegVault, arg1: &mut 0x2::transfer_policy::TransferRequest<XNft>, arg2: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::Order, arg3: 0x2::token::Token<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::orderInfo(arg2);
        assert!(v0 == 0x2::transfer_policy::item<XNft>(arg1), 2002);
        assert!(v2 <= 0x2::token::value<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>(&arg3), 2001);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>(0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::borrowMutTreasure(arg0), 0x2::token::transfer<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>(arg3, v1, arg4), arg4);
        let v7 = PayXBirdRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<XNft, PayXBirdRule>(v7, arg1);
    }

    public fun pegNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::archieve::UserArchieve, arg4: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::archieve::verifySignature(arg0, arg1, &mut arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        let v3 = 0x2::bcs::peel_u8(&mut v0);
        let v4 = 0x2::bcs::peel_u16(&mut v0);
        let v5 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v1 == 0x2::tx_context::sender(arg5), 2003);
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::archieve::verUpdateNftPegNonce(v5, arg3);
        let v6 = mintNftDefault(v2, v3, v4, arg5);
        0x2::transfer::transfer<XNft>(v6, 0x2::tx_context::sender(arg5));
        let v7 = PegNFT{
            owner : v1,
            xid   : v2,
            type  : v3,
            rare  : v4,
            nonce : v5,
        };
        0x2::event::emit<PegNFT>(v7);
    }

    public fun setValidator(arg0: &XNAdminCap, arg1: vector<u8>, arg2: &mut NftPegVault, arg3: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::version::Version) {
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<XNft> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rare"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{xid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rare}"));
        let v4 = 0x2::display::new_with_fields<XNft>(arg0, v0, v2, arg1);
        0x2::display::update_version<XNft>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}


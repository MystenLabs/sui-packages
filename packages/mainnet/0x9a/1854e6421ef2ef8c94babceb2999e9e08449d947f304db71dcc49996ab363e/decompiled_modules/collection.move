module 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::collection {
    struct BabyBlubNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::attributes::Attributes,
        balance: 0x2::balance::Balance<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>,
    }

    struct BabyBlubNftData has store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::attributes::Attributes,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::attributes::Attributes,
    }

    struct BurnEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct WITNESS_RULE has drop {
        dummy_field: bool,
    }

    public fun attributes(arg0: &BabyBlubNft) : 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::attributes::Attributes {
        arg0.attributes
    }

    public fun burn(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<BabyBlubNft>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB> {
        0x2::kiosk::list<BabyBlubNft>(arg1, arg2, arg0, 0);
        let (v0, v1) = 0x2::kiosk::purchase<BabyBlubNft>(arg1, arg0, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v2 = v1;
        let v3 = v0;
        let v4 = WITNESS_RULE{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<BabyBlubNft, WITNESS_RULE>(v4, arg3, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<BabyBlubNft>(arg3, v2);
        let v8 = BurnEvent{nft: 0x2::object::id<BabyBlubNft>(&v3)};
        0x2::event::emit<BurnEvent>(v8);
        let BabyBlubNft {
            id         : v9,
            name       : _,
            url        : _,
            attributes : _,
            balance    : v13,
        } = v3;
        0x2::object::delete(v9);
        0x2::coin::from_balance<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(v13, arg4)
    }

    public(friend) fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut vector<0x1::string::String>, arg3: &mut vector<0x1::string::String>) : BabyBlubNftData {
        BabyBlubNftData{
            name       : arg0,
            url        : arg1,
            attributes : 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::attributes::from_vec(arg2, arg3),
        }
    }

    public fun data_name(arg0: &BabyBlubNftData) : 0x1::string::String {
        arg0.name
    }

    public fun image_url(arg0: &BabyBlubNft) : 0x1::string::String {
        arg0.url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<BabyBlubNft>(&v0, arg1);
        0x2::display::add<BabyBlubNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"BabyBlub #{name}"));
        0x2::display::add<BabyBlubNft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"BabyBlub club NFT. The NFT collection of BabyBlub coin."));
        0x2::display::add<BabyBlubNft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<BabyBlubNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::update_version<BabyBlubNft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<BabyBlubNft>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BabyBlubNft>>(v2);
        let (v4, v5) = 0x2::transfer_policy::new<BabyBlubNft>(&v0, arg1);
        let v6 = v5;
        let v7 = v4;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<BabyBlubNft, WITNESS_RULE>(&mut v7, &v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BabyBlubNft>>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BabyBlubNft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BabyBlubNft>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BabyBlubNft>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: BabyBlubNftData, arg1: 0x2::coin::Coin<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>, arg2: &mut 0x2::tx_context::TxContext) : BabyBlubNft {
        let BabyBlubNftData {
            name       : v0,
            url        : v1,
            attributes : v2,
        } = arg0;
        let v3 = BabyBlubNft{
            id         : 0x2::object::new(arg2),
            name       : v0,
            url        : v1,
            attributes : v2,
            balance    : 0x2::coin::into_balance<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(arg1),
        };
        let v4 = MintEvent{
            nft        : 0x2::object::id<BabyBlubNft>(&v3),
            name       : v0,
            url        : v1,
            attributes : v2,
        };
        0x2::event::emit<MintEvent>(v4);
        v3
    }

    public fun name(arg0: &BabyBlubNft) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}


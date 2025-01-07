module 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::mint {
    struct MINT has drop {
        dummy_field: bool,
    }

    struct DestroyMintReceiptCap has key {
        id: 0x2::object::UID,
        number: u16,
    }

    struct Mint has key {
        id: 0x2::object::UID,
        number: u16,
        pfp: 0x1::option::Option<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>,
        payment: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        is_revealed: bool,
        minted_by: address,
        claim_expiration_epoch: u64,
    }

    struct MintReceipt has key {
        id: 0x2::object::UID,
        number: u16,
        mint_id: 0x2::object::ID,
    }

    struct MintSettings has key {
        id: 0x2::object::UID,
        price: u64,
        status: u8,
    }

    struct MintClaimedEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u16,
        claimed_by: address,
    }

    struct MintEvent has copy, drop {
        mint_id: 0x2::object::ID,
        pfp_id: 0x2::object::ID,
        pfp_number: u16,
        minted_by: address,
    }

    public fun admin_initialize_leaderboard(arg0: &0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::admin::AdminCap, arg1: &MintSettings, arg2: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::registry::Registry, arg3: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::leaderboard::Leaderboard, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        while (v0 <= arg4) {
            let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg5);
            let (v2, v3) = public_mint(v1, arg1, arg2, arg5);
            claim_mint(v3, v2, arg3, arg5);
            v0 = v0 + 1;
        };
    }

    public fun admin_refund_mint(arg0: &0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::admin::AdminCap, arg1: Mint, arg2: &0x2::transfer_policy::TransferPolicy<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg1.claim_expiration_epoch, 16);
        let v0 = DestroyMintReceiptCap{
            id     : 0x2::object::new(arg3),
            number : arg1.number,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.payment), arg1.minted_by);
        0x2::transfer::transfer<DestroyMintReceiptCap>(v0, arg1.minted_by);
        destroy_mint_internal(arg1);
    }

    public fun admin_set_mint_price(arg0: &0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::admin::AdminCap, arg1: u64, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        arg2.price = arg1;
    }

    public fun admin_set_mint_status(arg0: &0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::admin::AdminCap, arg1: u8, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.status == 0 || arg2.status == 1, 9);
        arg2.status = arg1;
    }

    public fun claim_mint(arg0: MintReceipt, arg1: Mint, arg2: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::leaderboard::Leaderboard, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.mint_id == 0x2::object::id<Mint>(&arg1), 8);
        let v0 = 0x1::option::extract<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>(&mut arg1.pfp);
        let v1 = MintClaimedEvent{
            pfp_id     : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::id(&v0),
            pfp_number : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::number(&v0),
            claimed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintClaimedEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.payment), 0x2::tx_context::sender(arg3));
        0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::leaderboard::add(&v0, arg2);
        0x2::transfer::public_transfer<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>(v0, 0x2::tx_context::sender(arg3));
        destroy_mint_internal(arg1);
        let MintReceipt {
            id      : v2,
            number  : _,
            mint_id : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun claim_points(arg0: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra, arg1: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::leaderboard::Leaderboard, arg2: u64) {
        0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::set_points(arg0, arg2);
        0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::leaderboard::add(arg0, arg1);
    }

    fun destroy_mint_internal(arg0: Mint) {
        let Mint {
            id                     : v0,
            number                 : _,
            pfp                    : v2,
            payment                : v3,
            is_revealed            : _,
            minted_by              : _,
            claim_expiration_epoch : _,
        } = arg0;
        0x1::option::destroy_none<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>(v2);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x2::object::delete(v0);
    }

    public fun destroy_mint_receipt(arg0: DestroyMintReceiptCap, arg1: MintReceipt) {
        assert!(arg0.number == arg1.number, 2);
        let DestroyMintReceiptCap {
            id     : v0,
            number : _,
        } = arg0;
        0x2::object::delete(v0);
        let MintReceipt {
            id      : v2,
            number  : _,
            mint_id : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MINT>(arg0, arg1);
        let v1 = 0x2::display::new<MintReceipt>(&v0, arg1);
        0x2::display::add<MintReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Chakra Mint Receipt #{number}"));
        0x2::display::add<MintReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A receipt that can be used to claim Chakra #{number}."));
        0x2::display::add<MintReceipt>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<MintReceipt>(&mut v1, 0x1::string::utf8(b"mint_id"), 0x1::string::utf8(b"{mint_id}"));
        0x2::display::add<MintReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://source.boomplaymusic.com/buzzgroup1/M00/18/E5/rBEevF_cRkmALJL2AADixAQNp4M606.jpg"));
        0x2::display::update_version<MintReceipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<MintReceipt>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = MintSettings{
            id     : 0x2::object::new(arg1),
            price  : 0,
            status : 1,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintSettings>(v2);
    }

    fun mint_internal(arg0: 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : (Mint, MintReceipt) {
        let v0 = Mint{
            id                     : 0x2::object::new(arg2),
            number                 : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::number(&arg0),
            pfp                    : 0x1::option::none<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>(),
            payment                : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg1),
            is_revealed            : false,
            minted_by              : 0x2::tx_context::sender(arg2),
            claim_expiration_epoch : 0x2::tx_context::epoch(arg2) + 30,
        };
        let v1 = MintReceipt{
            id      : 0x2::object::new(arg2),
            number  : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::number(&arg0),
            mint_id : 0x2::object::id<Mint>(&v0),
        };
        let v2 = MintEvent{
            mint_id    : 0x2::object::id<Mint>(&v0),
            pfp_id     : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::id(&arg0),
            pfp_number : 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::number(&arg0),
            minted_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintEvent>(v2);
        0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::set_minted_by_address(&mut arg0, 0x2::tx_context::sender(arg2));
        0x1::option::fill<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::Chakra>(&mut v0.pfp, arg0);
        0x2::transfer::public_transfer<0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::image::CreateImageCap>(0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::image::issue_create_image_cap(0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::number(&arg0), 0, 0x2::object::id<Mint>(&v0), arg2), 0x2::tx_context::sender(arg2));
        (v0, v1)
    }

    public fun public_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &MintSettings, arg2: &mut 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : (Mint, MintReceipt) {
        assert!(arg1.status == 1, 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.price, 4);
        let v0 = 0x207b34b57f4c80d167770a53e0f82d2525501770d5a4a6b21644dbc31f2404e6::chakra::create(arg2, arg3);
        mint_internal(v0, arg0, arg3)
    }

    // decompiled from Move bytecode v6
}


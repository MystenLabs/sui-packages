module 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::mint {
    struct MINT has drop {
        dummy_field: bool,
    }

    struct DestroyMintReceiptCap has key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct Mint has key {
        id: 0x2::object::UID,
        number: u64,
        pfp: 0x1::option::Option<0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra>,
        is_revealed: bool,
        minted_by: address,
        claim_expiration_epoch: u64,
    }

    struct MintReceipt has key {
        id: 0x2::object::UID,
        number: u64,
        mint_id: 0x2::object::ID,
    }

    struct MintSettings has key {
        id: 0x2::object::UID,
        price: u64,
        status: u8,
    }

    struct MintClaimedEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        claimed_by: address,
    }

    struct MintEvent has copy, drop {
        mint_id: 0x2::object::ID,
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        minted_by: address,
    }

    public fun admin_initialize_leaderboard(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::admin::AdminCap, arg1: &MintSettings, arg2: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::registry::Registry, arg3: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::Leaderboard, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::count(arg3) as u64) + 1;
        while (v0 < v0 + arg4) {
            let v1 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::create(v0);
            0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::add(&v1, arg3);
            v0 = v0 + 1;
        };
    }

    public fun admin_refund_mint(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::admin::AdminCap, arg1: Mint, arg2: &0x2::transfer_policy::TransferPolicy<0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg1.claim_expiration_epoch, 16);
        let v0 = DestroyMintReceiptCap{
            id     : 0x2::object::new(arg3),
            number : arg1.number,
        };
        0x2::transfer::transfer<DestroyMintReceiptCap>(v0, arg1.minted_by);
        destroy_mint_internal(arg1);
    }

    public fun admin_set_mint_price(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::admin::AdminCap, arg1: u64, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        arg2.price = arg1;
    }

    public fun admin_set_mint_status(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::admin::AdminCap, arg1: u8, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.status == 0 || arg2.status == 1, 9);
        arg2.status = arg1;
    }

    public fun burn_chakra(arg0: u64, arg1: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::Leaderboard) {
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::remove(arg0, arg1);
    }

    public fun claim_mint(arg0: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::Leaderboard, arg1: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::registry::Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::create(arg2);
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::add(&v0, arg0);
    }

    public fun claim_points(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra, arg1: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::Leaderboard, arg2: u64) {
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::add(arg0, arg1);
    }

    public fun claim_points_middle(arg0: &0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra, arg1: &mut 0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::Leaderboard, arg2: u64) {
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::remove(arg2, arg1);
        0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::leaderboard::add(arg0, arg1);
    }

    fun destroy_mint_internal(arg0: Mint) {
        let Mint {
            id                     : v0,
            number                 : _,
            pfp                    : v2,
            is_revealed            : _,
            minted_by              : _,
            claim_expiration_epoch : _,
        } = arg0;
        0x1::option::destroy_none<0x88df0e25aeb8dccd0a4d54eb09acaf49957ee1c87add4273a48725f97fb30a15::chakra::Chakra>(v2);
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

    // decompiled from Move bytecode v6
}


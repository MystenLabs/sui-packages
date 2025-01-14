module 0xafc357d855deb42b30ff3b9964d8c8fc843f062067735a0f5220107987120894::capybara_lootbox {
    struct CAPYBARA_LOOTBOX has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct LootBoxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxArgTBS has drop {
        user: 0x1::string::String,
        uid: u64,
        valid_until: u64,
        count: u64,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        min_amount: u64,
    }

    struct DataStorage has key {
        id: 0x2::object::UID,
        total_lootbox: u64,
        total_lootbox_opened: u64,
        ids: 0x2::table::Table<u64, bool>,
        pk: vector<u8>,
        check_signature: bool,
    }

    struct NFTLootbox has store, key {
        id: 0x2::object::UID,
        idx: u64,
    }

    struct EmptyTransferPolicy<phantom T0> has key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<T0>,
    }

    struct MintLootbox has copy, drop {
        from: address,
        lootboxes: vector<0x2::object::ID>,
        lootbox_idxs: vector<u64>,
        random_id: u64,
    }

    struct OpenLootbox has copy, drop {
        from: address,
        lootbox_id: 0x2::object::ID,
        lootbox_idx: u64,
        reward: u64,
    }

    fun get_random_reward(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 100);
        let v2 = 0;
        if (v1 <= 10) {
            v2 = 15000000;
        };
        if (v1 > 10 && v1 <= 25) {
            v2 = 7500000;
        };
        if (v1 > 25 && v1 <= 55) {
            v2 = 6000000;
        };
        if (v1 > 55 && v1 <= 80) {
            v2 = 5000000;
        };
        if (v1 > 80 && v1 <= 100) {
            v2 = 4000000;
        };
        v2
    }

    fun init(arg0: CAPYBARA_LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAPYBARA_LOOTBOX>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Money Bag"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"556e6c6f636b20746865206d797374657279212054686973204d6f6e657920426167204e465420636f6e7461696e7320612068696464656e206e756d626572206f6620696e2d67616d6520636f696e73e280946f70656e20697420746f2072657665616c20796f7572207265776172642120546865206d6f726520796f75206f70656e2c20746865206d6f726520796f752063616e2067726f7720796f757220636f696e2062616c616e63652e20537461727420756e6c6f636b696e6720796f7572204d6f6e6579204261677320746f64617921"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/bag"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/bag"));
        let v5 = 0x2::display::new_with_fields<NFTLootbox>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFTLootbox>(&mut v5);
        let v6 = 0x2::address::from_bytes(0x2::address::to_bytes(@0xf322f525e7370de05cf773b522c4611b483c94533b61f2da4cb9d4f81d3ff2d));
        let v7 = DataStorage{
            id                   : 0x2::object::new(arg1),
            total_lootbox        : 0,
            total_lootbox_opened : 0,
            ids                  : 0x2::table::new<u64, bool>(arg1),
            pk                   : x"031d9cd3748b019a247773cae4c6e34abba70ba9fd25f86fff1595b012337d3150",
            check_signature      : true,
        };
        0x2::transfer::share_object<DataStorage>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFTLootbox>>(v5, v6);
    }

    public fun mint_and_share_empty_transfer_policy<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = EmptyTransferPolicy<T0>{
            id              : 0x2::object::new(arg1),
            transfer_policy : v0,
        };
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<EmptyTransferPolicy<T0>>(v2);
    }

    public fun mint_lootbox(arg0: &mut DataStorage, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        if (arg0.check_signature) {
            assert!(arg3 >= 0x2::clock::timestamp_ms(arg1) / 1000, 105);
            assert!(!0x2::table::contains<u64, bool>(&arg0.ids, arg2), 103);
            let v1 = serialize_lootbox_args(v0, arg2, arg3, arg4);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pk, &v1, 1), 104);
        };
        0x2::table::add<u64, bool>(&mut arg0.ids, arg2, true);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        while (arg4 > 0) {
            arg0.total_lootbox = arg0.total_lootbox + 1;
            let v4 = new_lootbox(arg8, arg0.total_lootbox);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<NFTLootbox>(&v4));
            0x1::vector::push_back<u64>(&mut v3, v4.idx);
            0x2::kiosk::place<NFTLootbox>(arg6, arg7, v4);
            arg4 = arg4 - 1;
        };
        let v5 = MintLootbox{
            from         : v0,
            lootboxes    : v2,
            lootbox_idxs : v3,
            random_id    : arg2,
        };
        0x2::event::emit<MintLootbox>(v5);
    }

    fun new_lootbox(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : NFTLootbox {
        NFTLootbox{
            id  : 0x2::object::new(arg0),
            idx : arg1,
        }
    }

    public entry fun open_lootbox(arg0: &mut DataStorage, arg1: &0x2::random::Random, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: &EmptyTransferPolicy<NFTLootbox>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<NFTLootbox>(arg2, 0x2::kiosk::list_with_purchase_cap<NFTLootbox>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<NFTLootbox>(&arg5.transfer_policy, v2);
        let NFTLootbox {
            id  : v6,
            idx : v7,
        } = v1;
        0x2::object::delete(v6);
        arg0.total_lootbox_opened = arg0.total_lootbox_opened + 1;
        let v8 = OpenLootbox{
            from        : v0,
            lootbox_id  : arg4,
            lootbox_idx : v7,
            reward      : get_random_reward(arg1, arg6),
        };
        0x2::event::emit<OpenLootbox>(v8);
    }

    public fun serialize_lootbox_args(arg0: address, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = LootboxArgTBS{
            user        : 0x2::address::to_string(arg0),
            uid         : arg1,
            valid_until : arg2,
            count       : arg3,
        };
        0x1::bcs::to_bytes<LootboxArgTBS>(&v0)
    }

    public fun update_storage(arg0: &0xafc357d855deb42b30ff3b9964d8c8fc843f062067735a0f5220107987120894::capybara_game_card::AdminCap, arg1: vector<u8>, arg2: bool, arg3: &mut DataStorage, arg4: &mut 0x2::tx_context::TxContext) {
        arg3.pk = arg1;
        arg3.check_signature = arg2;
    }

    // decompiled from Move bytecode v6
}


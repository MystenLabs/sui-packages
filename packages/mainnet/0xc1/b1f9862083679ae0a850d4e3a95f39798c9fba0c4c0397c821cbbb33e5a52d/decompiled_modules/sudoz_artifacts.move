module 0xc1b1f9862083679ae0a850d4e3a95f39798c9fba0c4c0397c821cbbb33e5a52d::sudoz_artifacts {
    struct SUDOZ_ARTIFACTS has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        level: u8,
        path: u8,
        points: u64,
        total_invested: u64,
    }

    struct EvolvedNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        original_id: 0x2::object::ID,
    }

    struct BurnManager has store, key {
        id: 0x2::object::UID,
        burn_policy: 0x2::transfer_policy::TransferPolicy<Nft>,
    }

    struct EvolvedTracker has key {
        id: 0x2::object::UID,
        used_ids: vector<u64>,
        total_evolved: u64,
    }

    struct LevelUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        new_level: u8,
        cost_paid: u64,
        path_selected: u8,
    }

    struct EvolutionEvent has copy, drop {
        original_nft_id: 0x2::object::ID,
        evolved_nft_id: 0x2::object::ID,
        evolved_nft_number: u64,
        final_level: u8,
    }

    struct RefundBurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        level: u8,
        points_earned: u64,
        total_invested: u64,
        refund_amount: u64,
        burner: address,
    }

    public fun mint_edition_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &0x2::clock::Clock, arg3: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::kiosk::Kiosk, arg19: &0x2::kiosk::KioskOwnerCap, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg7, arg8, arg9, arg10, arg11, arg20);
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_edition_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, v0, arg18, arg19, arg20);
    }

    public fun mint_nft(arg0: &0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg5, arg6, arg7, arg8, arg9, arg15);
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, arg15);
    }

    public fun mint_order(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::clock::Clock, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun update_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::update_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg8, arg9, arg1);
        v0.name = arg2;
        v0.description = arg3;
        v0.media_url = arg4;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg5, arg6);
    }

    public entry fun bulk_level_up(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg1, arg2, arg0);
        assert!(v0.level == 0, 3);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u8(&mut v1) % 7 + 1;
        v0.path = v2;
        v0.level = 10;
        v0.points = 2 + (10 as u64);
        v0.total_invested = 0;
        update_nft_metadata_for_level(v0, 10);
        let v3 = LevelUpEvent{
            nft_id        : arg0,
            new_level     : 10,
            cost_paid     : 0,
            path_selected : v2,
        };
        0x2::event::emit<LevelUpEvent>(v3);
    }

    public entry fun burn_for_refund(arg0: &BurnManager, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<Nft>(arg2, arg3, arg1);
        assert!(v0.level >= 5, 4);
        let v1 = v0.total_invested;
        burn_nft_from_friend_contract(arg0, arg1, arg2, arg3, arg4);
        let v2 = RefundBurnEvent{
            nft_id         : arg1,
            level          : v0.level,
            points_earned  : v0.points,
            total_invested : v1,
            refund_amount  : v1 * 80 / 100,
            burner         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RefundBurnEvent>(v2);
    }

    public(friend) fun burn_nft_from_friend_contract(arg0: &BurnManager, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Nft>(arg2, 0x2::kiosk::list_with_purchase_cap<Nft>(arg2, arg3, arg1, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Nft>(&arg0.burn_policy, v1);
        let Nft {
            id             : v5,
            name           : _,
            description    : _,
            media_url      : _,
            attributes     : _,
            level          : _,
            path           : _,
            points         : _,
            total_invested : _,
        } = v0;
        0x2::object::delete(v5);
    }

    fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id             : 0x2::object::new(arg5),
            name           : arg0,
            description    : arg1,
            media_url      : arg2,
            attributes     : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
            level          : 0,
            path           : 0,
            points         : 2,
            total_invested : 0,
        }
    }

    public entry fun direct_mint(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id             : 0x2::object::new(arg2),
            name           : 0x1::string::utf8(b"Sudoz Artifact"),
            description    : 0x1::string::utf8(b"A mystical artifact with hidden powers waiting to be unlocked."),
            media_url      : 0x1::string::utf8(b"https://walrus.tusky.io/tVHvHhsxTrqh4jMdJCkB8tlXy4IS0_I-onA7QKgIuH4"),
            attributes     : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            level          : 0,
            path           : 0,
            points         : 2,
            total_invested : 0,
        };
        0x2::kiosk::place<Nft>(arg0, arg1, v0);
    }

    public entry fun evolve_nft(arg0: &BurnManager, arg1: &mut EvolvedTracker, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<Nft>(arg3, arg4, arg2);
        assert!(v0.level == 10, 0);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let (v2, v3) = 0x2::vec_map::into_keys_values<0x1::string::String, 0x1::string::String>(v0.attributes);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::string::String>(&v5)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&v5, v6), *0x1::vector::borrow<0x1::string::String>(&v4, v6));
            v6 = v6 + 1;
        };
        burn_nft_from_friend_contract(arg0, arg2, arg3, arg4, arg6);
        let v7 = 0x2::random::new_generator(arg5, arg6);
        let v8 = 0x2::random::generate_u64(&mut v7) % 5555 + 1;
        if (!0x1::vector::contains<u64>(&arg1.used_ids, &v8)) {
            0x1::vector::push_back<u64>(&mut arg1.used_ids, v8);
        };
        arg1.total_evolved = arg1.total_evolved + 1;
        let v9 = 0x1::string::utf8(b"THE SUDOZ #");
        0x1::string::append(&mut v9, u64_to_string(v8));
        let v10 = 0x1::string::utf8(b"ipfs://bafybeic7kknhjbvdrrkzlthi7zvqg7ilxeeckcq3d7y54qv3xngiw2pjui/metadata/");
        0x1::string::append(&mut v10, u64_to_string(v8));
        0x1::string::append(&mut v10, 0x1::string::utf8(b".json"));
        let v11 = EvolvedNft{
            id          : 0x2::object::new(arg6),
            name        : v9,
            description : 0x1::string::utf8(b"The evolved form of Sudoz Artifacts, achieved through dedication and commitment to the Sui ecosystem."),
            media_url   : v10,
            attributes  : v1,
            original_id : arg2,
        };
        let v12 = EvolutionEvent{
            original_nft_id    : arg2,
            evolved_nft_id     : 0x2::object::id<EvolvedNft>(&v11),
            evolved_nft_number : v8,
            final_level        : 10,
        };
        0x2::event::emit<EvolutionEvent>(v12);
        0x2::transfer::public_transfer<EvolvedNft>(v11, 0x2::tx_context::sender(arg6));
    }

    public fun get_nft_level(arg0: &Nft) : u8 {
        arg0.level
    }

    public fun get_nft_path(arg0: &Nft) : u8 {
        arg0.path
    }

    public fun get_nft_points(arg0: &Nft) : u64 {
        arg0.points
    }

    public fun get_nft_total_invested(arg0: &Nft) : u64 {
        arg0.total_invested
    }

    fun init(arg0: SUDOZ_ARTIFACTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUDOZ_ARTIFACTS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b" Sudoz Artifacts"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"496e74726f647563696e67205375646f7a2041727469666163747320612067726f756e64627265616b696e67204e46542064726f7020666f722074727565205375692065636f73797374656d2062656c6965766572732e0a4e6f206d696e742e204a75737420636c61696d20e28094206f6e6c7920666f72205375692065636f73797374656d20686f6c646572732e0a54686573652041727469666163747320756e6c6f636b2061636365737320746f20736f6d657468696e672062696767657220e280942061206761746577617920746f20746865205355444f5a0a0a436c61696d20796f7572205375646f7a204172746966616374206e6f7720616e64206f776e2061207069656365206f6620686973746f72792e0a0a0a"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"https://walrus.tusky.io/tVHvHhsxTrqh4jMdJCkB8tlXy4IS0_I-onA7QKgIuH4"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"path"), 0x1::string::utf8(b"{path}"));
        0x2::display::update_version<Nft>(&mut v1);
        let v2 = 0x2::display::new<EvolvedNft>(&v0, arg1);
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Evolved Sudoz Artifacts"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"The evolved form of Sudoz Artifacts, achieved through dedication and commitment to the Sui ecosystem."));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<EvolvedNft>(&mut v2, 0x1::string::utf8(b"original_id"), 0x1::string::utf8(b"{original_id}"));
        0x2::display::update_version<EvolvedNft>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v6, &v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v6, &v5, 500, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EvolvedNft>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v6);
        let v7 = EvolvedTracker{
            id            : 0x2::object::new(arg1),
            used_ids      : 0x1::vector::empty<u64>(),
            total_evolved : 0,
        };
        0x2::transfer::share_object<EvolvedTracker>(v7);
    }

    entry fun init_burn_nfts(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Nft>(arg0, arg1);
        let v2 = BurnManager{
            id          : 0x2::object::new(arg1),
            burn_policy : v0,
        };
        0x2::transfer::share_object<BurnManager>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun level_up(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg1, arg2, arg0);
        assert!(v0.level < 10, 2);
        let v1 = v0.level + 1;
        let v2 = 0;
        if (v0.level == 0) {
            let v3 = 0x2::random::new_generator(arg3, arg4);
            let v4 = 0x2::random::generate_u8(&mut v3) % 7 + 1;
            v2 = v4;
            v0.path = v4;
        };
        v0.level = v1;
        v0.points = v0.points + 1;
        v0.total_invested = v0.total_invested + 0;
        update_nft_metadata_for_level(v0, v1);
        let v5 = LevelUpEvent{
            nft_id        : arg0,
            new_level     : v1,
            cost_paid     : 0,
            path_selected : v2,
        };
        0x2::event::emit<LevelUpEvent>(v5);
    }

    public entry fun test_nft_access(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<Nft>(arg1, arg2, arg0);
        let v1 = LevelUpEvent{
            nft_id        : arg0,
            new_level     : v0.level,
            cost_paid     : 0,
            path_selected : 0,
        };
        0x2::event::emit<LevelUpEvent>(v1);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            let v1 = 0x1::vector::empty<u8>();
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v1, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            let v2 = 0x1::vector::length<u8>(&v1);
            let v3 = 0;
            while (v3 < v2) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, v2 - v3 - 1));
                v3 = v3 + 1;
            };
        };
        0x1::string::utf8(v0)
    }

    public fun update_nft_from_friend_contract(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg6, arg7, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
    }

    fun update_nft_metadata_for_level(arg0: &mut Nft, arg1: u8) {
        if (arg1 > 0 && arg0.path > 0) {
            let v0 = vector[b"SUDO-A5 Frostbark", b"SUDO-E8 Toxinpup", b"SUDO-N0 Cryoblink", b"SUDO-V9 Emberfang", b"SUDO-X7 Glitchtail", b"SUDO-Z1 Aurapup", b"SUDO-Z3 Voidpaw"];
            arg0.name = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, ((arg0.path - 1) as u64)));
            0x1::string::append(&mut arg0.name, 0x1::string::utf8(b" - Level "));
            let v1 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v1, arg1 + 48);
            0x1::string::append(&mut arg0.name, 0x1::string::utf8(v1));
        };
        let v2 = if (arg1 >= 8) {
            let v3 = 0x1::string::utf8(b"ipfs://bafybeicccn26n64qg46bbb4vkde64krkfmxxhbcpqmt264enfz5yd4lkbe/shared/level");
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v4, arg1 + 48);
            0x1::string::append(&mut v3, 0x1::string::utf8(v4));
            v3
        } else if (arg1 > 0 && arg0.path > 0) {
            let v5 = vector[b"frostbark", b"toxinpup", b"cryoblink", b"emberfang", b"glitchtail", b"aurapup", b"voidpaw"];
            let v6 = 0x1::string::utf8(b"ipfs://bafybeicccn26n64qg46bbb4vkde64krkfmxxhbcpqmt264enfz5yd4lkbe/");
            0x1::string::append(&mut v6, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, ((arg0.path - 1) as u64))));
            0x1::string::append(&mut v6, 0x1::string::utf8(b"/level"));
            let v7 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v7, arg1 + 48);
            0x1::string::append(&mut v6, 0x1::string::utf8(v7));
            v6
        } else {
            arg0.media_url
        };
        arg0.media_url = v2;
        let v8 = 0x1::string::utf8(b"level");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v8)) {
            let v9 = 0x1::string::utf8(b"level");
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v9);
        };
        let v12 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v12, arg1 + 48);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"level"), 0x1::string::utf8(v12));
        if (arg0.path > 0) {
            let v13 = 0x1::string::utf8(b"path_name");
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v13)) {
                let v14 = 0x1::string::utf8(b"path_name");
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v14);
            };
            let v17 = vector[b"SUDO-A5 Frostbark", b"SUDO-E8 Toxinpup", b"SUDO-N0 Cryoblink", b"SUDO-V9 Emberfang", b"SUDO-X7 Glitchtail", b"SUDO-Z1 Aurapup", b"SUDO-Z3 Voidpaw"];
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"path_name"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v17, ((arg0.path - 1) as u64))));
            let v18 = 0x1::string::utf8(b"path");
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v18)) {
                let v19 = 0x1::string::utf8(b"path");
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v19);
            };
            let v22 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v22, arg0.path + 48);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"path"), 0x1::string::utf8(v22));
        };
    }

    // decompiled from Move bytecode v6
}


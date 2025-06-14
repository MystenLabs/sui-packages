module 0x1572d7f637fbba0fd2b7788ccbb0ddb64fba0ff9daf33c72c255c2f10b1c8a1f::evolved_sudoz {
    struct EvolvedSudoz has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        number: u64,
        metadata_id: u64,
        original_artifact_number: u64,
        original_path: u8,
        background: 0x1::string::String,
        skin: 0x1::string::String,
        clothes: 0x1::string::String,
        hats: 0x1::string::String,
        eyewear: 0x1::string::String,
        mouth: 0x1::string::String,
        earrings: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct EvolvedAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EvolvedStats has key {
        id: 0x2::object::UID,
        evolved_minted: u64,
        available_metadata_ids: vector<u64>,
        royalty_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        evolved_artifacts: 0x2::table::Table<u64, bool>,
        transfer_policy_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SharedTransferPolicy has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct EvolutionAuth has store, key {
        id: 0x2::object::UID,
    }

    struct EVOLVED_SUDOZ has drop {
        dummy_field: bool,
    }

    struct EvolvedMinted has copy, drop {
        evolved_id: 0x2::object::ID,
        recipient: address,
        number: u64,
        metadata_id: u64,
        original_artifact_number: u64,
        original_path: u8,
    }

    struct EvolvedMintedAndLocked has copy, drop {
        evolved_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        recipient: address,
        number: u64,
        metadata_id: u64,
        original_artifact_number: u64,
        original_path: u8,
    }

    struct RoyaltyCollected has copy, drop {
        amount: u64,
        from_trade: 0x2::object::ID,
    }

    fun build_evolved_name(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"THE SUDOZ #");
        0x1::vector::append<u8>(&mut v0, u64_to_string_bytes(arg0));
        0x1::string::utf8(v0)
    }

    public fun get_available_count(arg0: &EvolvedStats) : u64 {
        0x1::vector::length<u64>(&arg0.available_metadata_ids)
    }

    public fun get_background(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.background
    }

    public fun get_clothes(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.clothes
    }

    public fun get_earrings(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.earrings
    }

    public fun get_evolved_minted(arg0: &EvolvedStats) : u64 {
        arg0.evolved_minted
    }

    public fun get_evolved_number(arg0: &EvolvedSudoz) : u64 {
        arg0.number
    }

    public fun get_evolved_remaining(arg0: &EvolvedStats) : u64 {
        5555 - arg0.evolved_minted
    }

    fun get_evolved_url(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"https://ipfs.io/ipfs/bafybeic7ymazpspv6ojxwrr6rqu3glnrtzbj3ej477nowr73brmb4hkkka/nfts/");
        0x1::vector::append<u8>(&mut v0, u64_to_string_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b".webp");
        0x1::string::utf8(v0)
    }

    public fun get_eyewear(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.eyewear
    }

    public fun get_hats(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.hats
    }

    public fun get_metadata_id(arg0: &EvolvedSudoz) : u64 {
        arg0.metadata_id
    }

    public fun get_mouth(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.mouth
    }

    public fun get_number(arg0: &EvolvedSudoz) : u64 {
        arg0.number
    }

    public fun get_original_artifact_number(arg0: &EvolvedSudoz) : u64 {
        arg0.original_artifact_number
    }

    public fun get_original_path(arg0: &EvolvedSudoz) : u8 {
        arg0.original_path
    }

    fun get_path_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Frostbark")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Toxinpup")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Cryoblink")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Emberfang")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Glitchtail")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Aurapup")
        } else {
            0x1::string::utf8(b"Voidpaw")
        }
    }

    public fun get_skin(arg0: &EvolvedSudoz) : 0x1::string::String {
        arg0.skin
    }

    public fun get_transfer_policy_id(arg0: &EvolvedStats) : 0x1::option::Option<0x2::object::ID> {
        arg0.transfer_policy_id
    }

    fun init(arg0: EVOLVED_SUDOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EVOLVED_SUDOZ>(arg0, arg1);
        let v1 = 0x2::display::new<EvolvedSudoz>(&v0, arg1);
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"#{number}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"metadata_id"), 0x1::string::utf8(b"{metadata_id}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"original_artifact_number"), 0x1::string::utf8(b"#{original_artifact_number}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"original_path"), 0x1::string::utf8(b"{original_path}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{background}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"skin"), 0x1::string::utf8(b"{skin}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"clothes"), 0x1::string::utf8(b"{clothes}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"hats"), 0x1::string::utf8(b"{hats}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"eyewear"), 0x1::string::utf8(b"{eyewear}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"mouth"), 0x1::string::utf8(b"{mouth}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"earrings"), 0x1::string::utf8(b"{earrings}"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://sudoz.xyz"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SUDOZ"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"THE SUDOZ"));
        0x2::display::add<EvolvedSudoz>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<EvolvedSudoz>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<EvolvedSudoz>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EvolvedSudoz>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvolvedSudoz>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvolvedSudoz>>(v2);
        let v4 = EvolvedAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<EvolvedAdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 1;
        while (v6 <= 5555) {
            0x1::vector::push_back<u64>(&mut v5, v6);
            v6 = v6 + 1;
        };
        let v7 = EvolvedStats{
            id                     : 0x2::object::new(arg1),
            evolved_minted         : 0,
            available_metadata_ids : v5,
            royalty_fees           : 0x2::balance::zero<0x2::sui::SUI>(),
            evolved_artifacts      : 0x2::table::new<u64, bool>(arg1),
            transfer_policy_id     : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<EvolvedStats>(v7);
        let v8 = EvolutionAuth{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<EvolutionAuth>(v8, 0x2::tx_context::sender(arg1));
    }

    public fun is_metadata_id_available(arg0: &EvolvedStats, arg1: u64) : bool {
        let v0 = &arg0.available_metadata_ids;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            if (*0x1::vector::borrow<u64>(v0, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun list_for_sale(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<EvolvedSudoz>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_and_lock_to_kiosk(arg0: &EvolvedAdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<EvolvedSudoz>, arg4: u64, arg5: &mut EvolvedStats, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.evolved_minted < 5555, 0);
        assert!(arg4 >= 1 && arg4 <= 5555, 2);
        let v0 = &mut arg5.available_metadata_ids;
        assert!(remove_specific_metadata_id(v0, arg4), 3);
        let v1 = arg5.evolved_minted + 1;
        let v2 = 0x1::string::utf8(b"Unknown");
        let v3 = 0x1::string::utf8(b"Unknown");
        let v4 = 0x1::string::utf8(b"Unknown");
        let v5 = 0x1::string::utf8(b"Unknown");
        let v6 = 0x1::string::utf8(b"Unknown");
        let v7 = 0x1::string::utf8(b"Unknown");
        let v8 = 0x1::string::utf8(b"Unknown");
        let v9 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Background"), v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Skin"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Clothes"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Hats"), v5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Eyewear"), v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Mouth"), v7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Earrings"), v8);
        let v10 = EvolvedSudoz{
            id                       : 0x2::object::new(arg6),
            name                     : build_evolved_name(arg4),
            description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
            image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(arg4))),
            number                   : v1,
            metadata_id              : arg4,
            original_artifact_number : 0,
            original_path            : 0,
            background               : v2,
            skin                     : v3,
            clothes                  : v4,
            hats                     : v5,
            eyewear                  : v6,
            mouth                    : v7,
            earrings                 : v8,
            attributes               : v9,
        };
        arg5.evolved_minted = arg5.evolved_minted + 1;
        0x2::kiosk::lock<EvolvedSudoz>(arg1, arg2, arg3, v10);
        let v11 = EvolvedMinted{
            evolved_id               : 0x2::object::id<EvolvedSudoz>(&v10),
            recipient                : 0x2::tx_context::sender(arg6),
            number                   : v1,
            metadata_id              : arg4,
            original_artifact_number : 0,
            original_path            : 0,
        };
        0x2::event::emit<EvolvedMinted>(v11);
    }

    public entry fun mint_developer_reserve_batch(arg0: &EvolvedAdminCap, arg1: address, arg2: u64, arg3: &mut EvolvedStats, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 50, 4);
        assert!(arg3.evolved_minted + arg2 <= 5555, 0);
        assert!(0x1::vector::length<u64>(&arg3.available_metadata_ids) >= arg2, 0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let (v2, v3) = 0x2::kiosk::new(arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0;
        while (v6 < arg2) {
            let v7 = 0x1::vector::swap_remove<u64>(&mut arg3.available_metadata_ids, 0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<u64>(&arg3.available_metadata_ids) - 1));
            let v8 = arg3.evolved_minted + 1;
            let v9 = 0x1::string::utf8(b"Unknown");
            let v10 = 0x1::string::utf8(b"Unknown");
            let v11 = 0x1::string::utf8(b"Unknown");
            let v12 = 0x1::string::utf8(b"Unknown");
            let v13 = 0x1::string::utf8(b"Unknown");
            let v14 = 0x1::string::utf8(b"Unknown");
            let v15 = 0x1::string::utf8(b"Unknown");
            let v16 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Background"), v9);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Skin"), v10);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Clothes"), v11);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Hats"), v12);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Eyewear"), v13);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Mouth"), v14);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Earrings"), v15);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Metadata ID"), u64_to_string(v7));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Number"), u64_to_string(v8));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, 0x1::string::utf8(b"Type"), 0x1::string::utf8(b"Developer Reserve"));
            let v17 = EvolvedSudoz{
                id                       : 0x2::object::new(arg5),
                name                     : build_evolved_name(v7),
                description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
                image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(v7))),
                number                   : v8,
                metadata_id              : v7,
                original_artifact_number : 0,
                original_path            : 0,
                background               : v9,
                skin                     : v10,
                clothes                  : v11,
                hats                     : v12,
                eyewear                  : v13,
                mouth                    : v14,
                earrings                 : v15,
                attributes               : v16,
            };
            let v18 = 0x2::object::id<EvolvedSudoz>(&v17);
            arg3.evolved_minted = arg3.evolved_minted + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v18);
            let v19 = EvolvedMinted{
                evolved_id               : v18,
                recipient                : arg1,
                number                   : v8,
                metadata_id              : v7,
                original_artifact_number : 0,
                original_path            : 0,
            };
            0x2::event::emit<EvolvedMinted>(v19);
            0x2::kiosk::place<EvolvedSudoz>(&mut v5, &v4, v17);
            v6 = v6 + 1;
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, arg1);
    }

    public entry fun mint_developer_reserve_one_of_ones(arg0: &EvolvedAdminCap, arg1: address, arg2: &mut EvolvedStats, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.transfer_policy_id), 7);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 504);
        0x1::vector::push_back<u64>(&mut v0, 998);
        0x1::vector::push_back<u64>(&mut v0, 1529);
        0x1::vector::push_back<u64>(&mut v0, 2016);
        0x1::vector::push_back<u64>(&mut v0, 2530);
        0x1::vector::push_back<u64>(&mut v0, 3022);
        0x1::vector::push_back<u64>(&mut v0, 3533);
        0x1::vector::push_back<u64>(&mut v0, 4059);
        0x1::vector::push_back<u64>(&mut v0, 4555);
        0x1::vector::push_back<u64>(&mut v0, 5190);
        let (v1, v2) = 0x2::kiosk::new(arg3);
        let v3 = v2;
        let v4 = v1;
        0x2::object::id<0x2::kiosk::Kiosk>(&v4);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v0)) {
            let v7 = *0x1::vector::borrow<u64>(&v0, v6);
            let v8 = &mut arg2.available_metadata_ids;
            assert!(remove_specific_metadata_id(v8, v7), 3);
            let v9 = arg2.evolved_minted + 1;
            let v10 = 0x1::string::utf8(b"Unknown");
            let v11 = 0x1::string::utf8(b"Unknown");
            let v12 = 0x1::string::utf8(b"Unknown");
            let v13 = 0x1::string::utf8(b"Unknown");
            let v14 = 0x1::string::utf8(b"Unknown");
            let v15 = 0x1::string::utf8(b"Unknown");
            let v16 = 0x1::string::utf8(b"Unknown");
            let v17 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Background"), v10);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Skin"), v11);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Clothes"), v12);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Hats"), v13);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Eyewear"), v14);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Mouth"), v15);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Earrings"), v16);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Metadata ID"), u64_to_string(v7));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Number"), u64_to_string(v9));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v17, 0x1::string::utf8(b"Type"), 0x1::string::utf8(b"Developer Reserve"));
            let v18 = EvolvedSudoz{
                id                       : 0x2::object::new(arg3),
                name                     : build_evolved_name(v7),
                description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
                image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(v7))),
                number                   : v9,
                metadata_id              : v7,
                original_artifact_number : 0,
                original_path            : 0,
                background               : v10,
                skin                     : v11,
                clothes                  : v12,
                hats                     : v13,
                eyewear                  : v14,
                mouth                    : v15,
                earrings                 : v16,
                attributes               : v17,
            };
            let v19 = 0x2::object::id<EvolvedSudoz>(&v18);
            arg2.evolved_minted = arg2.evolved_minted + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v19);
            let v20 = EvolvedMinted{
                evolved_id               : v19,
                recipient                : arg1,
                number                   : v9,
                metadata_id              : v7,
                original_artifact_number : 0,
                original_path            : 0,
            };
            0x2::event::emit<EvolvedMinted>(v20);
            0x2::kiosk::place<EvolvedSudoz>(&mut v4, &v3, v18);
            v6 = v6 + 1;
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg1);
    }

    public entry fun mint_developer_reserve_specific(arg0: &EvolvedAdminCap, arg1: address, arg2: u64, arg3: &mut EvolvedStats, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.evolved_minted < 5555, 0);
        assert!(arg2 >= 1 && arg2 <= 5555, 2);
        let v0 = &mut arg3.available_metadata_ids;
        assert!(remove_specific_metadata_id(v0, arg2), 3);
        let v1 = arg3.evolved_minted + 1;
        let v2 = 0x1::string::utf8(b"Unknown");
        let v3 = 0x1::string::utf8(b"Unknown");
        let v4 = 0x1::string::utf8(b"Unknown");
        let v5 = 0x1::string::utf8(b"Unknown");
        let v6 = 0x1::string::utf8(b"Unknown");
        let v7 = 0x1::string::utf8(b"Unknown");
        let v8 = 0x1::string::utf8(b"Unknown");
        let v9 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Background"), v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Skin"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Clothes"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Hats"), v5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Eyewear"), v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Mouth"), v7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Earrings"), v8);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Metadata ID"), u64_to_string(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Number"), u64_to_string(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Type"), 0x1::string::utf8(b"Developer Reserve - 1/1"));
        let v10 = EvolvedSudoz{
            id                       : 0x2::object::new(arg4),
            name                     : build_evolved_name(arg2),
            description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
            image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(arg2))),
            number                   : v1,
            metadata_id              : arg2,
            original_artifact_number : 0,
            original_path            : 0,
            background               : v2,
            skin                     : v3,
            clothes                  : v4,
            hats                     : v5,
            eyewear                  : v6,
            mouth                    : v7,
            earrings                 : v8,
            attributes               : v9,
        };
        arg3.evolved_minted = arg3.evolved_minted + 1;
        let (v11, v12) = 0x2::kiosk::new(arg4);
        let v13 = v12;
        let v14 = v11;
        0x2::kiosk::place<EvolvedSudoz>(&mut v14, &v13, v10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v14);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v13, arg1);
        let v15 = EvolvedMinted{
            evolved_id               : 0x2::object::id<EvolvedSudoz>(&v10),
            recipient                : arg1,
            number                   : v1,
            metadata_id              : arg2,
            original_artifact_number : 0,
            original_path            : 0,
        };
        0x2::event::emit<EvolvedMinted>(v15);
    }

    public entry fun mint_developer_reserve_to_kiosk(arg0: &EvolvedAdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: u64, arg4: &mut EvolvedStats, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.evolved_minted < 5555, 0);
        assert!(arg3 >= 1 && arg3 <= 5555, 2);
        let v0 = &mut arg4.available_metadata_ids;
        assert!(remove_specific_metadata_id(v0, arg3), 3);
        let v1 = arg4.evolved_minted + 1;
        let v2 = 0x1::string::utf8(b"Unknown");
        let v3 = 0x1::string::utf8(b"Unknown");
        let v4 = 0x1::string::utf8(b"Unknown");
        let v5 = 0x1::string::utf8(b"Unknown");
        let v6 = 0x1::string::utf8(b"Unknown");
        let v7 = 0x1::string::utf8(b"Unknown");
        let v8 = 0x1::string::utf8(b"Unknown");
        let v9 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Background"), v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Skin"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Clothes"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Hats"), v5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Eyewear"), v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Mouth"), v7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9, 0x1::string::utf8(b"Earrings"), v8);
        let v10 = EvolvedSudoz{
            id                       : 0x2::object::new(arg5),
            name                     : build_evolved_name(arg3),
            description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
            image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(arg3))),
            number                   : v1,
            metadata_id              : arg3,
            original_artifact_number : 0,
            original_path            : 0,
            background               : v2,
            skin                     : v3,
            clothes                  : v4,
            hats                     : v5,
            eyewear                  : v6,
            mouth                    : v7,
            earrings                 : v8,
            attributes               : v9,
        };
        arg4.evolved_minted = arg4.evolved_minted + 1;
        0x2::kiosk::place<EvolvedSudoz>(arg1, arg2, v10);
        let v11 = EvolvedMinted{
            evolved_id               : 0x2::object::id<EvolvedSudoz>(&v10),
            recipient                : 0x2::tx_context::sender(arg5),
            number                   : v1,
            metadata_id              : arg3,
            original_artifact_number : 0,
            original_path            : 0,
        };
        0x2::event::emit<EvolvedMinted>(v11);
    }

    public fun mint_evolved(arg0: &EvolvedAdminCap, arg1: address, arg2: u64, arg3: u8, arg4: &mut EvolvedStats, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) : EvolvedSudoz {
        assert!(arg4.evolved_minted < 5555, 0);
        assert!(!0x1::vector::is_empty<u64>(&arg4.available_metadata_ids), 0);
        let v0 = 0x2::random::new_generator(arg5, arg6);
        let v1 = 0x1::vector::swap_remove<u64>(&mut arg4.available_metadata_ids, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&arg4.available_metadata_ids) - 1));
        let v2 = arg4.evolved_minted + 1;
        let v3 = 0x1::string::utf8(b"Unknown");
        let v4 = 0x1::string::utf8(b"Unknown");
        let v5 = 0x1::string::utf8(b"Unknown");
        let v6 = 0x1::string::utf8(b"Unknown");
        let v7 = 0x1::string::utf8(b"Unknown");
        let v8 = 0x1::string::utf8(b"Unknown");
        let v9 = 0x1::string::utf8(b"Unknown");
        let v10 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Background"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Skin"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Clothes"), v5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Hats"), v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Eyewear"), v7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Mouth"), v8);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Earrings"), v9);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Metadata ID"), u64_to_string(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Number"), u64_to_string(v2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Original Artifact"), u64_to_string(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Original Path"), get_path_name(arg3));
        let v11 = EvolvedSudoz{
            id                       : 0x2::object::new(arg6),
            name                     : build_evolved_name(v1),
            description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
            image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(v1))),
            number                   : v2,
            metadata_id              : v1,
            original_artifact_number : arg2,
            original_path            : arg3,
            background               : v3,
            skin                     : v4,
            clothes                  : v5,
            hats                     : v6,
            eyewear                  : v7,
            mouth                    : v8,
            earrings                 : v9,
            attributes               : v10,
        };
        arg4.evolved_minted = arg4.evolved_minted + 1;
        let v12 = EvolvedMinted{
            evolved_id               : 0x2::object::id<EvolvedSudoz>(&v11),
            recipient                : arg1,
            number                   : v2,
            metadata_id              : v1,
            original_artifact_number : arg2,
            original_path            : arg3,
        };
        0x2::event::emit<EvolvedMinted>(v12);
        v11
    }

    public entry fun mint_evolved_and_lock(arg0: &EvolvedAdminCap, arg1: address, arg2: u64, arg3: u8, arg4: &mut EvolvedStats, arg5: &0x2::transfer_policy::TransferPolicy<EvolvedSudoz>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_evolved(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<EvolvedSudoz>(&mut v4, &v3, arg5, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg1);
    }

    public fun mint_evolved_for_evolution(arg0: &EvolutionAuth, arg1: u64, arg2: u8, arg3: &mut EvolvedStats, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : EvolvedSudoz {
        assert!(!0x2::table::contains<u64, bool>(&arg3.evolved_artifacts, arg1), 6);
        assert!(arg3.evolved_minted < 5555, 0);
        assert!(!0x1::vector::is_empty<u64>(&arg3.available_metadata_ids), 0);
        0x2::table::add<u64, bool>(&mut arg3.evolved_artifacts, arg1, true);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = 0x1::vector::swap_remove<u64>(&mut arg3.available_metadata_ids, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&arg3.available_metadata_ids) - 1));
        let v2 = arg3.evolved_minted + 1;
        let v3 = 0x1::string::utf8(b"Unknown");
        let v4 = 0x1::string::utf8(b"Unknown");
        let v5 = 0x1::string::utf8(b"Unknown");
        let v6 = 0x1::string::utf8(b"Unknown");
        let v7 = 0x1::string::utf8(b"Unknown");
        let v8 = 0x1::string::utf8(b"Unknown");
        let v9 = 0x1::string::utf8(b"Unknown");
        let v10 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Background"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Skin"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Clothes"), v5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Hats"), v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Eyewear"), v7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Mouth"), v8);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Earrings"), v9);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Metadata ID"), u64_to_string(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Number"), u64_to_string(v2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Original Artifact"), u64_to_string(arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"Original Path"), get_path_name(arg2));
        let v11 = EvolvedSudoz{
            id                       : 0x2::object::new(arg5),
            name                     : build_evolved_name(v1),
            description              : 0x1::string::utf8(b"An evolved form of the SUDOZ artifact with unique traits"),
            image_url                : 0x2::url::new_unsafe(0x1::string::to_ascii(get_evolved_url(v1))),
            number                   : v2,
            metadata_id              : v1,
            original_artifact_number : arg1,
            original_path            : arg2,
            background               : v3,
            skin                     : v4,
            clothes                  : v5,
            hats                     : v6,
            eyewear                  : v7,
            mouth                    : v8,
            earrings                 : v9,
            attributes               : v10,
        };
        arg3.evolved_minted = arg3.evolved_minted + 1;
        let v12 = EvolvedMinted{
            evolved_id               : 0x2::object::id<EvolvedSudoz>(&v11),
            recipient                : 0x2::tx_context::sender(arg5),
            number                   : v2,
            metadata_id              : v1,
            original_artifact_number : arg1,
            original_path            : arg2,
        };
        0x2::event::emit<EvolvedMinted>(v12);
        v11
    }

    public fun place_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: EvolvedSudoz, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::place<EvolvedSudoz>(arg0, arg1, arg2);
    }

    public fun purchase_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<EvolvedSudoz>, arg4: &mut 0x2::tx_context::TxContext) : EvolvedSudoz {
        let (v0, v1) = 0x2::kiosk::purchase<EvolvedSudoz>(arg0, arg1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<EvolvedSudoz>(arg3, v1);
        v0
    }

    fun remove_specific_metadata_id(arg0: &mut vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<u64>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun set_transfer_policy(arg0: &EvolvedAdminCap, arg1: &mut EvolvedStats, arg2: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut arg1.transfer_policy_id, arg2);
    }

    public entry fun setup_and_share_transfer_policy(arg0: &EvolvedAdminCap, arg1: &0x2::package::Publisher, arg2: &mut EvolvedStats, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = setup_transfer_policy(arg0, arg1, arg2, arg3);
        let v2 = v0;
        let v3 = SharedTransferPolicy{
            id        : 0x2::object::new(arg3),
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<EvolvedSudoz>>(&v2),
        };
        0x2::transfer::share_object<SharedTransferPolicy>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EvolvedSudoz>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EvolvedSudoz>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun setup_transfer_policy(arg0: &EvolvedAdminCap, arg1: &0x2::package::Publisher, arg2: &mut EvolvedStats, arg3: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<EvolvedSudoz>, 0x2::transfer_policy::TransferPolicyCap<EvolvedSudoz>) {
        let (v0, v1) = 0x2::transfer_policy::new<EvolvedSudoz>(arg1, arg3);
        let v2 = v0;
        0x1::option::fill<0x2::object::ID>(&mut arg2.transfer_policy_id, 0x2::object::id<0x2::transfer_policy::TransferPolicy<EvolvedSudoz>>(&v2));
        (v2, v1)
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    fun u64_to_string_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    public fun update_evolved_metadata(arg0: &EvolvedAdminCap, arg1: &mut EvolvedSudoz, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String) {
        arg1.background = arg2;
        arg1.skin = arg3;
        arg1.clothes = arg4;
        arg1.hats = arg5;
        arg1.eyewear = arg6;
        arg1.mouth = arg7;
        arg1.earrings = arg8;
        let v0 = 0x1::string::utf8(b"Background");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Background"), arg2);
        let v3 = 0x1::string::utf8(b"Skin");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Skin"), arg3);
        let v6 = 0x1::string::utf8(b"Clothes");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v6);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Clothes"), arg4);
        let v9 = 0x1::string::utf8(b"Hats");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v9);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Hats"), arg5);
        let v12 = 0x1::string::utf8(b"Eyewear");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v12);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Eyewear"), arg6);
        let v15 = 0x1::string::utf8(b"Mouth");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v15);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Mouth"), arg7);
        let v18 = 0x1::string::utf8(b"Earrings");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v18);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(b"Earrings"), arg8);
    }

    public fun update_image_url(arg0: &EvolvedAdminCap, arg1: &mut EvolvedSudoz, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    public fun withdraw_royalty_fees(arg0: &EvolvedAdminCap, arg1: &mut EvolvedStats, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.royalty_fees, 0x2::balance::value<0x2::sui::SUI>(&arg1.royalty_fees)), arg2)
    }

    // decompiled from Move bytecode v6
}


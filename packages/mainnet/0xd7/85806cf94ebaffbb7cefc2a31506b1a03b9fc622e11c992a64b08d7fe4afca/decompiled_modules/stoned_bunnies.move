module 0xd785806cf94ebaffbb7cefc2a31506b1a03b9fc622e11c992a64b08d7fe4afca::stoned_bunnies {
    struct STONED_BUNNIES has drop {
        dummy_field: bool,
    }

    struct StonedBunny has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        edition: u64,
        background: 0x1::string::String,
        headwear: 0x1::string::String,
        hair: 0x1::string::String,
        eyewear: 0x1::string::String,
        face: 0x1::string::String,
        outfit: 0x1::string::String,
        accessory: 0x1::string::String,
        companion: 0x1::string::String,
        strain: 0x1::string::String,
        potency: 0x1::string::String,
        grade: 0x1::string::String,
        session: 0x1::string::String,
        spot: 0x1::string::String,
    }

    struct CollectionState has store, key {
        id: 0x2::object::UID,
        minted: bool,
        display_v2_registered: bool,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    fun assert_admin(arg0: &CollectionState, arg1: &CollectionAdminCap) {
        assert!(is_admin(arg0, arg1), 2);
    }

    fun build_attributes() : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Background"), 0x1::string::utf8(b"Solid"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Headwear"), 0x1::string::utf8(b"Beanie + Ears"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Hair"), 0x1::string::utf8(b"Green"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Eyewear"), 0x1::string::utf8(b"Red Eyes"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Face"), 0x1::string::utf8(b"None"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Outfit"), 0x1::string::utf8(b"Tie-Dye Hoodie"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Accessory"), 0x1::string::utf8(b"Joint"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Companion"), 0x1::string::utf8(b"None"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Strain"), 0x1::string::utf8(b"Sativa"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Potency"), 0x1::string::utf8(b"High THC"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Grade"), 0x1::string::utf8(b"Level 3"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Session"), 0x1::string::utf8(b"Night Session"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Spot"), 0x1::string::utf8(b"Rooftop"));
        v0
    }

    public fun display_v2_registered(arg0: &CollectionState) : bool {
        arg0.display_v2_registered
    }

    fun ensure_display_v2_registered(arg0: &mut CollectionState, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: &mut 0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.display_v2_registered) {
            let (v0, v1) = 0x2::display_registry::new_with_publisher<StonedBunny>(arg1, arg2, arg3);
            let v2 = v1;
            let v3 = v0;
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{background}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"headwear"), 0x1::string::utf8(b"{headwear}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"hair"), 0x1::string::utf8(b"{hair}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"eyewear"), 0x1::string::utf8(b"{eyewear}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"face"), 0x1::string::utf8(b"{face}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"outfit"), 0x1::string::utf8(b"{outfit}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"accessory"), 0x1::string::utf8(b"{accessory}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"companion"), 0x1::string::utf8(b"{companion}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"strain"), 0x1::string::utf8(b"{strain}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"potency"), 0x1::string::utf8(b"{potency}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"grade"), 0x1::string::utf8(b"{grade}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"session"), 0x1::string::utf8(b"{session}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"spot"), 0x1::string::utf8(b"{spot}"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Suimon"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(x"53746f6e65642042756e6e69657320e2809420446973706c61792056322054657374"));
            0x2::display_registry::set<StonedBunny>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Isolated one-NFT test collection using the SUIBORG Display V2 registration pattern."));
            0x2::display_registry::share<StonedBunny>(v3);
            0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<StonedBunny>>(v2, 0x2::tx_context::sender(arg3));
            arg0.display_v2_registered = true;
        };
    }

    fun init(arg0: STONED_BUNNIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<STONED_BUNNIES>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<StonedBunny>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<StonedBunny>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<StonedBunny>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<StonedBunny>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v5 = CollectionState{
            id                    : 0x2::object::new(arg1),
            minted                : false,
            display_v2_registered : false,
        };
        let v6 = CollectionAdminCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<CollectionState>(&v5),
        };
        0x2::transfer::public_share_object<CollectionState>(v5);
        0x2::transfer::public_transfer<CollectionAdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    fun is_admin(arg0: &CollectionState, arg1: &CollectionAdminCap) : bool {
        arg1.collection_id == 0x2::object::id<CollectionState>(arg0)
    }

    public fun mint_test(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::package::Publisher, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        ensure_display_v2_registered(arg0, arg2, arg3, arg4);
        assert!(!arg0.minted, 1);
        arg0.minted = true;
        let v0 = StonedBunny{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(b"Green Bunny"),
            description : 0x1::string::utf8(b"Stoners: hand-drawn comic characters who run the smoke lounge. Strain, Potency, Grade, Session and Spot show each Stoner's place in the scene: the rarer the post, the higher their standing."),
            image_url   : 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeifsym3g46vm3gmyuzfsmnkudj4yt3a4lkl7k44s7yphtmkclxvpwu"),
            attributes  : build_attributes(),
            edition     : 7,
            background  : 0x1::string::utf8(b"Solid"),
            headwear    : 0x1::string::utf8(b"Beanie + Ears"),
            hair        : 0x1::string::utf8(b"Green"),
            eyewear     : 0x1::string::utf8(b"Red Eyes"),
            face        : 0x1::string::utf8(b"None"),
            outfit      : 0x1::string::utf8(b"Tie-Dye Hoodie"),
            accessory   : 0x1::string::utf8(b"Joint"),
            companion   : 0x1::string::utf8(b"None"),
            strain      : 0x1::string::utf8(b"Sativa"),
            potency     : 0x1::string::utf8(b"High THC"),
            grade       : 0x1::string::utf8(b"Level 3"),
            session     : 0x1::string::utf8(b"Night Session"),
            spot        : 0x1::string::utf8(b"Rooftop"),
        };
        0x2::transfer::public_transfer<StonedBunny>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}


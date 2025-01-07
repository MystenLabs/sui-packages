module 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    struct Kumo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
        accessory: 0x1::string::String,
        background: 0x1::string::String,
        eyes: 0x1::string::String,
        fur_colour: 0x1::string::String,
        mouth: 0x1::string::String,
        tail: 0x1::string::String,
        one_of_one: 0x1::string::String,
    }

    struct KumoMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        owner: address,
        mint_limit: u64,
        mint_count: u64,
    }

    struct KumoImageMutateAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        owner: address,
    }

    struct KumoMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun accessory(arg0: &Kumo) : 0x1::string::String {
        arg0.accessory
    }

    public fun background(arg0: &Kumo) : 0x1::string::String {
        arg0.background
    }

    public fun eyes(arg0: &Kumo) : 0x1::string::String {
        arg0.eyes
    }

    public fun fur_colour(arg0: &Kumo) : 0x1::string::String {
        arg0.fur_colour
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x84591c7cb325ff69742aabcafabfc77ef19b91a74e47c438ebe8b9049a6355e9;
        let v1 = 0x2::package::claim<KUMO>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://kumothekat.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v6 = 0x2::display::new_with_fields<Kumo>(&v1, v2, v4, arg1);
        0x2::display::update_version<Kumo>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Kumo>>(v6, v0);
        let (v7, v8) = 0x2::transfer_policy::new<Kumo>(&v1, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Kumo>(&mut v10, &v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Kumo>(&mut v10, &v9, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Kumo>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Kumo>>(v9, v0);
        let v11 = KumoMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Main Kumo mint authority"),
            owner       : v0,
            mint_limit  : 2222,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<KumoMintAuth>(v11, v0);
        let v12 = KumoImageMutateAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Main Kumo image mutate authority"),
            owner       : v0,
        };
        0x2::transfer::public_transfer<KumoImageMutateAuth>(v12, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun mint_kumo_to_kiosk(arg0: &mut KumoMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<Kumo>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = Kumo{
            id           : 0x2::object::new(arg6),
            name         : arg2,
            description  : 0x1::string::utf8(b"Minted at the Kumo NFT launch. The cat has entered the wallet."),
            image_hash   : arg3,
            rarity       : 0x1::string::utf8(b"Default"),
            rarity_score : 0,
            accessory    : 0x1::string::utf8(b"None"),
            background   : 0x1::string::utf8(b"Default"),
            eyes         : 0x1::string::utf8(b"Default"),
            fur_colour   : 0x1::string::utf8(b"Default"),
            mouth        : 0x1::string::utf8(b"Default"),
            tail         : 0x1::string::utf8(b"Default"),
            one_of_one   : 0x1::string::utf8(b"None"),
        };
        let v1 = 0x2::object::id<Kumo>(&v0);
        let v2 = KumoMintedEvent{
            id   : v1,
            name : arg2,
        };
        0x2::event::emit<KumoMintedEvent>(v2);
        arg0.mint_count = arg0.mint_count + 1;
        0x2::kiosk::lock<Kumo>(arg4, arg5, arg1, v0);
        v1
    }

    public fun mouth(arg0: &Kumo) : 0x1::string::String {
        arg0.mouth
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<Kumo>) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        0x2::display::edit<Kumo>(arg3, arg1, arg2);
        0x2::display::update_version<Kumo>(arg3);
    }

    public fun mutate_image_hash(arg0: &mut KumoImageMutateAuth, arg1: &mut Kumo, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg1.image_hash = arg2;
    }

    public fun one_of_one(arg0: &Kumo) : 0x1::string::String {
        arg0.one_of_one
    }

    public(friend) fun set_attribute<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: T0) {
        let v0 = 0x2::kiosk::borrow_mut<Kumo>(arg1, arg2, arg0);
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&mut v0.id, arg3), 2);
        if (arg3 == 0x1::string::utf8(b"Accessory")) {
            v0.accessory = arg4;
        } else if (arg3 == 0x1::string::utf8(b"Background")) {
            v0.background = arg4;
        } else if (arg3 == 0x1::string::utf8(b"Eyes")) {
            v0.eyes = arg4;
        } else if (arg3 == 0x1::string::utf8(b"FurColour")) {
            v0.fur_colour = arg4;
        } else if (arg3 == 0x1::string::utf8(b"Mouth")) {
            v0.mouth = arg4;
        } else if (arg3 == 0x1::string::utf8(b"Tail")) {
            v0.tail = arg4;
        } else if (arg3 == 0x1::string::utf8(b"OneOfOne")) {
            v0.one_of_one = arg4;
        };
        v0.rarity_score = v0.rarity_score + arg5;
        if (v0.rarity_score < 60) {
            v0.rarity = 0x1::string::utf8(b"Common");
        } else if (v0.rarity_score >= 800) {
            v0.rarity = 0x1::string::utf8(b"Mystic");
        } else if (v0.rarity_score >= 240) {
            v0.rarity = 0x1::string::utf8(b"Legendary");
        } else if (v0.rarity_score >= 160) {
            v0.rarity = 0x1::string::utf8(b"Epic");
        } else if (v0.rarity_score >= 120) {
            v0.rarity = 0x1::string::utf8(b"Rare");
        } else if (v0.rarity_score >= 60) {
            v0.rarity = 0x1::string::utf8(b"Uncommon");
        };
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut v0.id, arg3, arg6);
    }

    public fun tail(arg0: &Kumo) : 0x1::string::String {
        arg0.tail
    }

    // decompiled from Move bytecode v6
}


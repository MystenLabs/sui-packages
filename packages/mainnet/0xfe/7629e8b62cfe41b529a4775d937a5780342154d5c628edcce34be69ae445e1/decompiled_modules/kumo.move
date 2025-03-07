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

    struct KumoPaymentValidator has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        price: u64,
        available_kumos: u64,
        whitelist: vector<address>,
        paid: vector<address>,
        minted: vector<address>,
    }

    struct KumoMutationValidator has key {
        id: 0x2::object::UID,
        kumos: vector<0x2::object::ID>,
        image_hashes: vector<0x1::string::String>,
        rarity_scores: vector<u64>,
    }

    struct KumoMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun accessory(arg0: &Kumo) : 0x1::string::String {
        arg0.accessory
    }

    public fun add_addresses_to_payment_validator(arg0: &0x2::package::Publisher, arg1: &mut KumoPaymentValidator, arg2: vector<address>) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        0x1::vector::append<address>(&mut arg1.whitelist, arg2);
    }

    public fun add_entry_to_mutation_validator(arg0: &KumoImageMutateAuth, arg1: &mut KumoMutationValidator, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_address(arg2);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.kumos, &v0);
        if (v1) {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.image_hashes, arg3);
            0x1::vector::swap_remove<0x1::string::String>(&mut arg1.image_hashes, v2);
            0x1::vector::push_back<u64>(&mut arg1.rarity_scores, arg4);
            0x1::vector::swap_remove<u64>(&mut arg1.rarity_scores, v2);
        } else {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.kumos, v0);
            0x1::vector::push_back<0x1::string::String>(&mut arg1.image_hashes, arg3);
            0x1::vector::push_back<u64>(&mut arg1.rarity_scores, arg4);
        };
    }

    public fun background(arg0: &Kumo) : 0x1::string::String {
        arg0.background
    }

    public fun collect_payments(arg0: &0x2::package::Publisher, arg1: &mut KumoPaymentValidator, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun complete_mutation(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut KumoMutationValidator) {
        let v0 = 0x2::kiosk::borrow_mut<Kumo>(arg1, arg2, arg0);
        let v1 = 0x2::object::id<Kumo>(v0);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&arg3.kumos, &v1);
        assert!(v2, 10);
        v0.image_hash = *0x1::vector::borrow<0x1::string::String>(&arg3.image_hashes, v3);
        v0.rarity_score = *0x1::vector::borrow<u64>(&arg3.rarity_scores, v3);
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
        0x1::vector::remove<0x2::object::ID>(&mut arg3.kumos, v3);
        0x1::vector::remove<0x1::string::String>(&mut arg3.image_hashes, v3);
        0x1::vector::remove<u64>(&mut arg3.rarity_scores, v3);
    }

    public fun create_mutation_auth(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        let v0 = KumoImageMutateAuth{
            id          : 0x2::object::new(arg2),
            description : 0x1::string::utf8(b"Kumo mutation authority"),
            owner       : arg1,
        };
        0x2::transfer::public_transfer<KumoImageMutateAuth>(v0, arg1);
    }

    public fun create_mutation_validator(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        let v0 = KumoMutationValidator{
            id            : 0x2::object::new(arg1),
            kumos         : 0x1::vector::empty<0x2::object::ID>(),
            image_hashes  : 0x1::vector::empty<0x1::string::String>(),
            rarity_scores : vector[],
        };
        0x2::transfer::share_object<KumoMutationValidator>(v0);
    }

    public fun create_payment_validator(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: vector<address>, arg4: vector<address>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        let v0 = KumoPaymentValidator{
            id              : 0x2::object::new(arg6),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            price           : arg1,
            available_kumos : arg2,
            whitelist       : arg3,
            paid            : arg4,
            minted          : arg5,
        };
        0x2::transfer::share_object<KumoPaymentValidator>(v0);
    }

    public fun eyes(arg0: &Kumo) : 0x1::string::String {
        arg0.eyes
    }

    public fun fur_colour(arg0: &Kumo) : 0x1::string::String {
        arg0.fur_colour
    }

    public(friend) fun get_current_loadout(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) : vector<0x1::string::String> {
        let v0 = 0x2::kiosk::borrow_mut<Kumo>(arg1, arg2, arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.accessory);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.background);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.eyes);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.fur_colour);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.mouth);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.tail);
        0x1::vector::push_back<0x1::string::String>(&mut v1, v0.one_of_one);
        v1
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
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

    public fun mutate_kumo_name(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x1::string::String) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        0x2::kiosk::borrow_mut<Kumo>(arg2, arg3, 0x2::object::id_from_address(arg1)).name = arg4;
    }

    public fun mutate_payment_validator(arg0: &0x2::package::Publisher, arg1: &mut KumoPaymentValidator, arg2: u64, arg3: u64) {
        assert!(0x2::package::from_package<Kumo>(arg0), 1);
        arg1.available_kumos = arg2;
        arg1.price = arg3;
    }

    public fun one_of_one(arg0: &Kumo) : 0x1::string::String {
        arg0.one_of_one
    }

    public fun pay_for_mint(arg0: &mut KumoPaymentValidator, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 3);
        assert!(!0x1::vector::contains<address>(&arg0.paid, &v0), 4);
        assert!(!0x1::vector::contains<address>(&arg0.minted, &v0), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price, 6);
        assert!(arg0.available_kumos > 0, 7);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        0x1::vector::push_back<address>(&mut arg0.paid, v0);
        arg0.available_kumos = arg0.available_kumos - 1;
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

    public fun transfer_paid_kumo(arg0: &mut KumoPaymentValidator, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x84591c7cb325ff69742aabcafabfc77ef19b91a74e47c438ebe8b9049a6355e9, 9);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &arg2), 3);
        assert!(0x1::vector::contains<address>(&arg0.paid, &arg2), 8);
        assert!(!0x1::vector::contains<address>(&arg0.minted, &arg2), 5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
        0x1::vector::push_back<address>(&mut arg0.minted, arg2);
    }

    public(friend) fun unset_attribute<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::string::String) : T0 {
        let v0 = 0x2::kiosk::borrow_mut<Kumo>(arg1, arg2, arg0);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&v0.id, arg3), 11);
        if (arg3 == 0x1::string::utf8(b"Accessory")) {
            v0.accessory = 0x1::string::utf8(b"None");
        } else if (arg3 == 0x1::string::utf8(b"Background")) {
            v0.background = 0x1::string::utf8(b"Default");
        } else if (arg3 == 0x1::string::utf8(b"Eyes")) {
            v0.eyes = 0x1::string::utf8(b"Default");
        } else if (arg3 == 0x1::string::utf8(b"FurColour")) {
            v0.fur_colour = 0x1::string::utf8(b"Default");
        } else if (arg3 == 0x1::string::utf8(b"Mouth")) {
            v0.mouth = 0x1::string::utf8(b"Default");
        } else if (arg3 == 0x1::string::utf8(b"Tail")) {
            v0.tail = 0x1::string::utf8(b"Default");
        } else if (arg3 == 0x1::string::utf8(b"OneOfOne")) {
            v0.one_of_one = 0x1::string::utf8(b"None");
        };
        0x2::dynamic_object_field::remove<0x1::string::String, T0>(&mut v0.id, arg3)
    }

    // decompiled from Move bytecode v6
}


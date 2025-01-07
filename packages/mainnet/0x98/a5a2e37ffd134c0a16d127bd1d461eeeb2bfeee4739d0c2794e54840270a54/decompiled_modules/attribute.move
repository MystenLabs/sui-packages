module 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::attribute {
    struct ATTRIBUTE has drop {
        dummy_field: bool,
    }

    struct KumoAccessory has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoBackground has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoEyes has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoFurColour has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoMouth has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoTail has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoOneOfOne has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoAttributeMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        owner: address,
        accessory_count: u64,
        background_count: u64,
        eyes_count: u64,
        fur_colour_count: u64,
        mouth_count: u64,
        tail_count: u64,
        one_of_one_count: u64,
        total_mint_count: u64,
    }

    struct KumoAttributeMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        category: 0x1::string::String,
    }

    public(friend) fun accessory_name(arg0: &KumoAccessory) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun accessory_rarity_score(arg0: &KumoAccessory) : u64 {
        arg0.rarity_score
    }

    fun attach_accessory(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoAccessory) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoAccessory>(arg0, arg1, arg2, 0x1::string::utf8(b"Accessory"), accessory_name(&arg3), accessory_rarity_score(&arg3), arg3);
    }

    fun attach_background(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoBackground) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoBackground>(arg0, arg1, arg2, 0x1::string::utf8(b"Background"), background_name(&arg3), background_rarity_score(&arg3), arg3);
    }

    fun attach_eyes(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoEyes) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoEyes>(arg0, arg1, arg2, 0x1::string::utf8(b"Eyes"), eyes_name(&arg3), eyes_rarity_score(&arg3), arg3);
    }

    fun attach_fur_colour(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoFurColour) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoFurColour>(arg0, arg1, arg2, 0x1::string::utf8(b"FurColour"), fur_colour_name(&arg3), fur_colour_rarity_score(&arg3), arg3);
    }

    fun attach_mouth(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoMouth) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoMouth>(arg0, arg1, arg2, 0x1::string::utf8(b"Mouth"), mouth_name(&arg3), mouth_rarity_score(&arg3), arg3);
    }

    fun attach_one_of_one(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoOneOfOne) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoOneOfOne>(arg0, arg1, arg2, 0x1::string::utf8(b"OneOfOne"), one_of_one_name(&arg3), one_of_one_rarity_score(&arg3), arg3);
    }

    fun attach_tail(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoTail) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoTail>(arg0, arg1, arg2, 0x1::string::utf8(b"Tail"), tail_name(&arg3), tail_rarity_score(&arg3), arg3);
    }

    public(friend) fun background_name(arg0: &KumoBackground) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun background_rarity_score(arg0: &KumoBackground) : u64 {
        arg0.rarity_score
    }

    public(friend) fun eyes_name(arg0: &KumoEyes) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun eyes_rarity_score(arg0: &KumoEyes) : u64 {
        arg0.rarity_score
    }

    public(friend) fun fur_colour_name(arg0: &KumoFurColour) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun fur_colour_rarity_score(arg0: &KumoFurColour) : u64 {
        arg0.rarity_score
    }

    fun init(arg0: ATTRIBUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ATTRIBUTE>(arg0, arg1);
        setup_display<KumoAccessory>(&v1, arg1);
        setup_display<KumoBackground>(&v1, arg1);
        setup_display<KumoEyes>(&v1, arg1);
        setup_display<KumoFurColour>(&v1, arg1);
        setup_display<KumoMouth>(&v1, arg1);
        setup_display<KumoTail>(&v1, arg1);
        setup_display<KumoOneOfOne>(&v1, arg1);
        setup_transfer_policy<KumoAccessory>(&v1, arg1);
        setup_transfer_policy<KumoBackground>(&v1, arg1);
        setup_transfer_policy<KumoEyes>(&v1, arg1);
        setup_transfer_policy<KumoFurColour>(&v1, arg1);
        setup_transfer_policy<KumoMouth>(&v1, arg1);
        setup_transfer_policy<KumoTail>(&v1, arg1);
        setup_transfer_policy<KumoOneOfOne>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v2 = KumoAttributeMintAuth{
            id               : 0x2::object::new(arg1),
            description      : 0x1::string::utf8(b"Main Kumo Attribute mint authority"),
            owner            : v0,
            accessory_count  : 0,
            background_count : 0,
            eyes_count       : 0,
            fur_colour_count : 0,
            mouth_count      : 0,
            tail_count       : 0,
            one_of_one_count : 0,
            total_mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAttributeMintAuth>(v2, v0);
    }

    fun mint_accessory(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoAccessory {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoAccessory{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoAccessory>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Accessory"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.accessory_count = arg0.accessory_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_accessory_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_accessory(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoAccessory>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoAccessory>(&v0)
    }

    public fun mint_accessory_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_accessory(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_accessory(arg6, arg7, arg8, v0);
        0x2::object::id<KumoAccessory>(&v0)
    }

    public entry fun mint_attribute_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<KumoAccessory>(arg0), 1);
        let v0 = KumoAttributeMintAuth{
            id               : 0x2::object::new(arg2),
            description      : 0x1::string::utf8(b"Kumo Attribute Mint Authority"),
            owner            : arg1,
            accessory_count  : 0,
            background_count : 0,
            eyes_count       : 0,
            fur_colour_count : 0,
            mouth_count      : 0,
            tail_count       : 0,
            one_of_one_count : 0,
            total_mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAttributeMintAuth>(v0, arg1);
    }

    fun mint_background(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoBackground {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoBackground{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoBackground>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Background"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.background_count = arg0.background_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_background_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_background(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoBackground>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoBackground>(&v0)
    }

    public fun mint_background_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_background(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_background(arg6, arg7, arg8, v0);
        0x2::object::id<KumoBackground>(&v0)
    }

    fun mint_eyes(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoEyes {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoEyes{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoEyes>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Eyes"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.eyes_count = arg0.eyes_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_eyes_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_eyes(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoEyes>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoEyes>(&v0)
    }

    public fun mint_eyes_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_eyes(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_eyes(arg6, arg7, arg8, v0);
        0x2::object::id<KumoEyes>(&v0)
    }

    fun mint_fur_colour(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoFurColour {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoFurColour{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoFurColour>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"FurColour"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.fur_colour_count = arg0.fur_colour_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_fur_colour_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_fur_colour(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoFurColour>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoFurColour>(&v0)
    }

    public fun mint_fur_colour_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_fur_colour(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_fur_colour(arg6, arg7, arg8, v0);
        0x2::object::id<KumoFurColour>(&v0)
    }

    fun mint_mouth(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoMouth {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoMouth{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoMouth>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Mouth"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.mouth_count = arg0.mouth_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_mouth_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_mouth(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoMouth>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoMouth>(&v0)
    }

    public fun mint_mouth_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_mouth(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_mouth(arg6, arg7, arg8, v0);
        0x2::object::id<KumoMouth>(&v0)
    }

    fun mint_one_of_one(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoOneOfOne {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoOneOfOne{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoOneOfOne>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"OneOfOne"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.one_of_one_count = arg0.one_of_one_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_one_of_one_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_one_of_one(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoOneOfOne>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoOneOfOne>(&v0)
    }

    public fun mint_one_of_one_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_one_of_one(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_one_of_one(arg6, arg7, arg8, v0);
        0x2::object::id<KumoOneOfOne>(&v0)
    }

    fun mint_tail(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoTail {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoTail{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoTail>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Tail"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.tail_count = arg0.tail_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_tail_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_tail(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoTail>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoTail>(&v0)
    }

    public fun mint_tail_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_tail(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_tail(arg6, arg7, arg8, v0);
        0x2::object::id<KumoTail>(&v0)
    }

    public(friend) fun mouth_name(arg0: &KumoMouth) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun mouth_rarity_score(arg0: &KumoMouth) : u64 {
        arg0.rarity_score
    }

    public entry fun mutate_accessory_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoAccessory>) {
        assert!(0x2::package::from_package<KumoAccessory>(arg0), 1);
        0x2::display::edit<KumoAccessory>(arg3, arg1, arg2);
        0x2::display::update_version<KumoAccessory>(arg3);
    }

    public entry fun mutate_background_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoBackground>) {
        assert!(0x2::package::from_package<KumoBackground>(arg0), 1);
        0x2::display::edit<KumoBackground>(arg3, arg1, arg2);
        0x2::display::update_version<KumoBackground>(arg3);
    }

    public entry fun mutate_eyes_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoEyes>) {
        assert!(0x2::package::from_package<KumoEyes>(arg0), 1);
        0x2::display::edit<KumoEyes>(arg3, arg1, arg2);
        0x2::display::update_version<KumoEyes>(arg3);
    }

    public entry fun mutate_fur_colour_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoFurColour>) {
        assert!(0x2::package::from_package<KumoFurColour>(arg0), 1);
        0x2::display::edit<KumoFurColour>(arg3, arg1, arg2);
        0x2::display::update_version<KumoFurColour>(arg3);
    }

    public entry fun mutate_mouth_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoMouth>) {
        assert!(0x2::package::from_package<KumoMouth>(arg0), 1);
        0x2::display::edit<KumoMouth>(arg3, arg1, arg2);
        0x2::display::update_version<KumoMouth>(arg3);
    }

    public entry fun mutate_one_of_one_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoOneOfOne>) {
        assert!(0x2::package::from_package<KumoOneOfOne>(arg0), 1);
        0x2::display::edit<KumoOneOfOne>(arg3, arg1, arg2);
        0x2::display::update_version<KumoOneOfOne>(arg3);
    }

    public entry fun mutate_tail_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoTail>) {
        assert!(0x2::package::from_package<KumoTail>(arg0), 1);
        0x2::display::edit<KumoTail>(arg3, arg1, arg2);
        0x2::display::update_version<KumoTail>(arg3);
    }

    public(friend) fun one_of_one_name(arg0: &KumoOneOfOne) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun one_of_one_rarity_score(arg0: &KumoOneOfOne) : u64 {
        arg0.rarity_score
    }

    fun setup_display<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://kumothekat.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun setup_transfer_policy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<T0>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(&mut v3, &v2, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun tail_name(arg0: &KumoTail) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun tail_rarity_score(arg0: &KumoTail) : u64 {
        arg0.rarity_score
    }

    // decompiled from Move bytecode v6
}


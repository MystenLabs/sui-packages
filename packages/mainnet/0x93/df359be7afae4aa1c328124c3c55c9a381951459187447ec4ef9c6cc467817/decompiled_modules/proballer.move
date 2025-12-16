module 0x93df359be7afae4aa1c328124c3c55c9a381951459187447ec4ef9c6cc467817::proballer {
    struct PROBaller has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        edition: u64,
        created_at: u64,
        trait_background: 0x1::string::String,
        trait_body: 0x1::string::String,
        trait_eyes: 0x1::string::String,
        trait_mouth: 0x1::string::String,
        trait_accessory: 0x1::string::String,
        trait_special: 0x1::string::String,
        total_trait_updates: u64,
        total_name_updates: u64,
        last_updated_at: u64,
    }

    struct PROBALLER has drop {
        dummy_field: bool,
    }

    struct NameUpdatedEvent has copy, drop {
        proballer_id: 0x2::object::ID,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        updated_by: address,
        amount_paid: u64,
    }

    struct TraitUpdatedEvent has copy, drop {
        proballer_id: 0x2::object::ID,
        trait_key: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
        updated_by: address,
        amount_paid: u64,
    }

    struct MediaUpdatedEvent has copy, drop {
        proballer_id: 0x2::object::ID,
        old_media_url: 0x1::string::String,
        new_media_url: 0x1::string::String,
        updated_by: address,
    }

    struct PROBallerMintedEvent has copy, drop {
        proballer_id: 0x2::object::ID,
        name: 0x1::string::String,
        edition: u64,
        owner: address,
    }

    public fun created_at(arg0: &PROBaller) : u64 {
        arg0.created_at
    }

    public fun description(arg0: &PROBaller) : &0x1::string::String {
        &arg0.description
    }

    public fun edition(arg0: &PROBaller) : u64 {
        arg0.edition
    }

    public fun get_name_update_price() : u64 {
        3000000
    }

    public fun get_trait_update_price() : u64 {
        10000000
    }

    fun init(arg0: PROBALLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PROBALLER>(arg0, arg1);
        let v1 = 0x2::display::new<PROBaller>(&v0, arg1);
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://statsonsui.com"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"PROStats"));
        0x2::display::add<PROBaller>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"[{\"trait_type\":\"Background\",\"value\":\"{trait_background}\"},{\"trait_type\":\"Body\",\"value\":\"{trait_body}\"},{\"trait_type\":\"Eyes\",\"value\":\"{trait_eyes}\"},{\"trait_type\":\"Mouth\",\"value\":\"{trait_mouth}\"},{\"trait_type\":\"Accessory\",\"value\":\"{trait_accessory}\"},{\"trait_type\":\"Special\",\"value\":\"{trait_special}\"}]"));
        0x2::display::update_version<PROBaller>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PROBaller>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun last_updated_at(arg0: &PROBaller) : u64 {
        arg0.last_updated_at
    }

    public fun media_url(arg0: &PROBaller) : &0x1::string::String {
        &arg0.media_url
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 >= 1, 3);
        assert!(v1 <= 64, 2);
        let v2 = 0x2::object::new(arg5);
        let v3 = PROBaller{
            id                  : v2,
            name                : v0,
            description         : 0x1::string::utf8(arg1),
            media_url           : 0x1::string::utf8(arg2),
            edition             : arg3,
            created_at          : 0x2::tx_context::epoch(arg5),
            trait_background    : 0x1::string::utf8(b"Default"),
            trait_body          : 0x1::string::utf8(b"Default"),
            trait_eyes          : 0x1::string::utf8(b"Default"),
            trait_mouth         : 0x1::string::utf8(b"Default"),
            trait_accessory     : 0x1::string::utf8(b"None"),
            trait_special       : 0x1::string::utf8(b"None"),
            total_trait_updates : 0,
            total_name_updates  : 0,
            last_updated_at     : 0x2::tx_context::epoch(arg5),
        };
        let v4 = PROBallerMintedEvent{
            proballer_id : 0x2::object::uid_to_inner(&v2),
            name         : v3.name,
            edition      : arg3,
            owner        : arg4,
        };
        0x2::event::emit<PROBallerMintedEvent>(v4);
        0x2::transfer::public_transfer<PROBaller>(v3, arg4);
    }

    public entry fun mint_with_traits(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 >= 1, 3);
        assert!(v1 <= 64, 2);
        let v2 = 0x2::object::new(arg11);
        let v3 = PROBaller{
            id                  : v2,
            name                : v0,
            description         : 0x1::string::utf8(arg1),
            media_url           : 0x1::string::utf8(arg2),
            edition             : arg3,
            created_at          : 0x2::tx_context::epoch(arg11),
            trait_background    : 0x1::string::utf8(arg4),
            trait_body          : 0x1::string::utf8(arg5),
            trait_eyes          : 0x1::string::utf8(arg6),
            trait_mouth         : 0x1::string::utf8(arg7),
            trait_accessory     : 0x1::string::utf8(arg8),
            trait_special       : 0x1::string::utf8(arg9),
            total_trait_updates : 0,
            total_name_updates  : 0,
            last_updated_at     : 0x2::tx_context::epoch(arg11),
        };
        let v4 = PROBallerMintedEvent{
            proballer_id : 0x2::object::uid_to_inner(&v2),
            name         : v3.name,
            edition      : arg3,
            owner        : arg10,
        };
        0x2::event::emit<PROBallerMintedEvent>(v4);
        0x2::transfer::public_transfer<PROBaller>(v3, arg10);
    }

    public fun name(arg0: &PROBaller) : &0x1::string::String {
        &arg0.name
    }

    public fun total_name_updates(arg0: &PROBaller) : u64 {
        arg0.total_name_updates
    }

    public fun total_trait_updates(arg0: &PROBaller) : u64 {
        arg0.total_trait_updates
    }

    public fun trait_accessory(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_accessory
    }

    public fun trait_background(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_background
    }

    public fun trait_body(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_body
    }

    public fun trait_eyes(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_eyes
    }

    public fun trait_mouth(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_mouth
    }

    public fun trait_special(arg0: &PROBaller) : &0x1::string::String {
        &arg0.trait_special
    }

    public entry fun update_media_url(arg0: &mut PROBaller, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        arg0.media_url = v0;
        arg0.last_updated_at = 0x2::tx_context::epoch(arg2);
        let v1 = MediaUpdatedEvent{
            proballer_id  : 0x2::object::uid_to_inner(&arg0.id),
            old_media_url : arg0.media_url,
            new_media_url : v0,
            updated_by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MediaUpdatedEvent>(v1);
    }

    public entry fun update_name(arg0: &mut PROBaller, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 >= 1, 3);
        assert!(v1 <= 64, 2);
        arg0.name = v0;
        arg0.total_name_updates = arg0.total_name_updates + 1;
        arg0.last_updated_at = 0x2::tx_context::epoch(arg2);
        let v2 = NameUpdatedEvent{
            proballer_id : 0x2::object::uid_to_inner(&arg0.id),
            old_name     : arg0.name,
            new_name     : v0,
            updated_by   : 0x2::tx_context::sender(arg2),
            amount_paid  : 0,
        };
        0x2::event::emit<NameUpdatedEvent>(v2);
    }

    public entry fun update_name_paid<T0>(arg0: &mut PROBaller, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 == 3000000, 4);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::length(&v1);
        assert!(v2 >= 1, 3);
        assert!(v2 <= 64, 2);
        arg0.name = v1;
        arg0.total_name_updates = arg0.total_name_updates + 1;
        arg0.last_updated_at = 0x2::tx_context::epoch(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0xfc3660552ae09f4753b368c4b0bc2dbbad547394b8fd9605edfde0c71e8ddee6);
        let v3 = NameUpdatedEvent{
            proballer_id : 0x2::object::uid_to_inner(&arg0.id),
            old_name     : arg0.name,
            new_name     : v1,
            updated_by   : 0x2::tx_context::sender(arg3),
            amount_paid  : v0,
        };
        0x2::event::emit<NameUpdatedEvent>(v3);
    }

    public entry fun update_trait_paid<T0>(arg0: &mut PROBaller, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 == 10000000, 4);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::utf8(arg2);
        assert!(0x1::string::length(&v2) <= 128, 6);
        let v3 = if (v1 == 0x1::string::utf8(b"background")) {
            arg0.trait_background = v2;
            arg0.trait_background
        } else if (v1 == 0x1::string::utf8(b"body")) {
            arg0.trait_body = v2;
            arg0.trait_body
        } else if (v1 == 0x1::string::utf8(b"eyes")) {
            arg0.trait_eyes = v2;
            arg0.trait_eyes
        } else if (v1 == 0x1::string::utf8(b"mouth")) {
            arg0.trait_mouth = v2;
            arg0.trait_mouth
        } else if (v1 == 0x1::string::utf8(b"accessory")) {
            arg0.trait_accessory = v2;
            arg0.trait_accessory
        } else {
            assert!(v1 == 0x1::string::utf8(b"special"), 5);
            arg0.trait_special = v2;
            arg0.trait_special
        };
        arg0.total_trait_updates = arg0.total_trait_updates + 1;
        arg0.last_updated_at = 0x2::tx_context::epoch(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, @0xfc3660552ae09f4753b368c4b0bc2dbbad547394b8fd9605edfde0c71e8ddee6);
        let v4 = TraitUpdatedEvent{
            proballer_id : 0x2::object::uid_to_inner(&arg0.id),
            trait_key    : v1,
            old_value    : v3,
            new_value    : v2,
            updated_by   : 0x2::tx_context::sender(arg4),
            amount_paid  : v0,
        };
        0x2::event::emit<TraitUpdatedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}


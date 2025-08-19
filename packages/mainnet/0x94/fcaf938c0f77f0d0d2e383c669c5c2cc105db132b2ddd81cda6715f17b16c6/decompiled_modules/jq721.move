module 0x94fcaf938c0f77f0d0d2e383c669c5c2cc105db132b2ddd81cda6715f17b16c6::jq721 {
    struct Collection has store, key {
        id: 0x2::object::UID,
        initialized: bool,
        minted_supply: u64,
        metadata_count: u64,
        package: 0x1::string::String,
    }

    struct WeBump has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PendingMetadata has drop, store {
        token_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        token_id: u64,
    }

    struct CreateEvent has copy, drop {
        token_id: u64,
    }

    struct JQ721 has drop {
        dummy_field: bool,
    }

    public entry fun create(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut Collection, arg7: &mut 0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingMetadata{
            token_id    : arg0,
            name        : arg1,
            image_url   : arg2,
            description : arg3,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5),
        };
        let v1 = CreateEvent{token_id: arg0};
        0x2::event::emit<CreateEvent>(v1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg6.id, 0x1::u64::to_string(arg0))) {
            let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, PendingMetadata>(&mut arg6.id, 0x1::u64::to_string(arg0));
            v2.name = v0.name;
            v2.image_url = v0.image_url;
            v2.description = v0.description;
            v2.attributes = v0.attributes;
        } else {
            0x2::dynamic_field::add<0x1::string::String, PendingMetadata>(&mut arg6.id, 0x1::u64::to_string(arg0), v0);
            arg6.metadata_count = arg6.metadata_count + 1;
        };
    }

    fun init(arg0: JQ721, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<JQ721>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<WeBump>(&v0, arg1);
        let v3 = Collection{
            id             : 0x2::object::new(arg1),
            initialized    : false,
            minted_supply  : 0,
            metadata_count : 0,
            package        : 0x1::string::utf8(b""),
        };
        0x2::transfer::public_share_object<Collection>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<WeBump>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<WeBump>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16, arg4: &mut 0x2::transfer_policy::TransferPolicy<WeBump>, arg5: &mut 0x2::transfer_policy::TransferPolicyCap<WeBump>, arg6: &mut Collection, arg7: &mut 0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6.initialized == false, 2);
        let v0 = 0x2::display::new<WeBump>(arg7, arg8);
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"collection_name"), arg0);
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"collection_description"), arg1);
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"collection_media_url"), arg2);
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<WeBump>(&mut v0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<WeBump>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<WeBump>>(v0, 0x2::tx_context::sender(arg8));
        arg6.initialized = true;
        arg6.package = 0x1::string::from_ascii(*0x2::package::published_package(arg7));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<WeBump>(arg4, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<WeBump>(arg4, arg5, arg3, 0);
    }

    public entry fun mint(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<WeBump>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x94fcaf938c0f77f0d0d2e383c669c5c2cc105db132b2ddd81cda6715f17b16c6::permit::verify(arg2, &arg3, arg4), 1);
        let v0 = 0x1::string::utf8(b"minted_");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg2));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            abort 2
        };
        let PendingMetadata {
            token_id    : v1,
            name        : v2,
            image_url   : v3,
            description : v4,
            attributes  : v5,
        } = 0x2::dynamic_field::remove<0x1::string::String, PendingMetadata>(&mut arg0.id, 0x1::u64::to_string(arg2));
        let v6 = WeBump{
            id          : 0x2::object::new(arg4),
            token_id    : v1,
            name        : v2,
            image_url   : v3,
            description : v4,
            attributes  : v5,
        };
        let v7 = MintEvent{
            object_id : *0x2::object::uid_as_inner(&v6.id),
            recipient : 0x2::tx_context::sender(arg4),
            token_id  : v6.token_id,
        };
        0x2::event::emit<MintEvent>(v7);
        let (v8, v9) = 0x2::kiosk::new(arg4);
        let v10 = v9;
        let v11 = v8;
        0x2::kiosk::lock<WeBump>(&mut v11, &v10, arg1, v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v10, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v11);
        arg0.minted_supply = arg0.minted_supply + 1;
        0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, v0, true);
    }

    public entry fun transfer_collection_ownership(arg0: 0x2::package::Publisher, arg1: 0x2::transfer_policy::TransferPolicyCap<WeBump>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<WeBump>>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(arg0, arg2);
    }

    public entry fun update_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<WeBump>, arg4: &mut 0x2::package::Publisher, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::display::edit<WeBump>(arg3, 0x1::string::utf8(b"collection_name"), arg0);
        0x2::display::edit<WeBump>(arg3, 0x1::string::utf8(b"collection_description"), arg1);
        0x2::display::edit<WeBump>(arg3, 0x1::string::utf8(b"collection_media_url"), arg2);
        0x2::display::update_version<WeBump>(arg3);
    }

    // decompiled from Move bytecode v6
}


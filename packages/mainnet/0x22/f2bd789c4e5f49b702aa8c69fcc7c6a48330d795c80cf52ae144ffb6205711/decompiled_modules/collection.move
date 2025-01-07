module 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::collection {
    struct DegenRabbit has store, key {
        id: 0x2::object::UID,
        name: u64,
        url: 0x1::string::String,
        attributes: 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::Attributes,
        level: u8,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<DegenRabbit>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<DegenRabbit>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::Attributes, arg3: &mut 0x2::tx_context::TxContext) : DegenRabbit {
        DegenRabbit{
            id         : 0x2::object::new(arg3),
            name       : arg0,
            url        : arg1,
            attributes : arg2,
            level      : 0,
        }
    }

    public fun add_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<DegenRabbit>, arg1: &CollectionInfo) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::kiosk_lock_rule::add<DegenRabbit>(arg0, &arg1.policy_cap);
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<DegenRabbit>, arg1: &CollectionInfo) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::royalty_rule::add<DegenRabbit>(arg0, &arg1.policy_cap, 600, 0);
    }

    public fun add_royalty_rule_12(arg0: &mut 0x2::transfer_policy::TransferPolicy<DegenRabbit>, arg1: &CollectionInfo) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::royalty_rule::add<DegenRabbit>(arg0, &arg1.policy_cap, 1200, 0);
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<DegenRabbit>(&v0, arg1);
        0x2::display::add<DegenRabbit>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Degen Rabbit #{name}"));
        0x2::display::add<DegenRabbit>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<DegenRabbit>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::update_version<DegenRabbit>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<DegenRabbit>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DegenRabbit>>(v2);
        let v4 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v3,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun level(arg0: &DegenRabbit) : u8 {
        arg0.level
    }

    public fun name(arg0: &DegenRabbit) : u64 {
        arg0.name
    }

    public fun remove_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<DegenRabbit>, arg1: &CollectionInfo) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::kiosk_lock_rule::remove<DegenRabbit>(arg0, &arg1.policy_cap);
    }

    public fun remove_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<DegenRabbit>, arg1: &CollectionInfo) {
        0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::royalty_rule::remove<DegenRabbit>(arg0, &arg1.policy_cap);
    }

    public(friend) fun replace_attributes(arg0: &mut DegenRabbit, arg1: 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::Attributes) {
        arg0.attributes = arg1;
    }

    public(friend) fun upgrade(arg0: &mut DegenRabbit, arg1: 0x1::string::String, arg2: 0x93195daadbc4f26c0c498f4ceac92593682d2325ce3a0f5ba9f2db3b6a9733dd::attributes::Attributes) {
        assert!(arg0.level < 2, 0);
        arg0.url = arg1;
        arg0.attributes = arg2;
        arg0.level = arg0.level + 1;
    }

    // decompiled from Move bytecode v6
}


module 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::collection {
    struct FusionOfTheGods has store, key {
        id: 0x2::object::UID,
        name: u64,
        url: 0x1::string::String,
        attributes: 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::attributes::Attributes,
        level: u8,
    }

    struct FusionOfTheGodsData has store {
        name: u64,
        url: 0x1::string::String,
        attributes: 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::attributes::Attributes,
        level: u8,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<FusionOfTheGods>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<FusionOfTheGods>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::attributes::Attributes) : FusionOfTheGodsData {
        FusionOfTheGodsData{
            name       : arg0,
            url        : arg1,
            attributes : arg2,
            level      : 0,
        }
    }

    public fun add_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<FusionOfTheGods>, arg1: &CollectionInfo) {
        0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::kiosk_lock_rule::add<FusionOfTheGods>(arg0, &arg1.policy_cap);
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<FusionOfTheGods>, arg1: &CollectionInfo) {
        0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::royalty_rule::add<FusionOfTheGods>(arg0, &arg1.policy_cap, 1200, 0);
    }

    public fun add_royalty_rule_12(arg0: &mut 0x2::transfer_policy::TransferPolicy<FusionOfTheGods>, arg1: &CollectionInfo) {
        0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::royalty_rule::add<FusionOfTheGods>(arg0, &arg1.policy_cap, 1200, 0);
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<FusionOfTheGods>(&v0, arg1);
        0x2::display::add<FusionOfTheGods>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Fusion Of The Gods #{name}"));
        0x2::display::add<FusionOfTheGods>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<FusionOfTheGods>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::update_version<FusionOfTheGods>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<FusionOfTheGods>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<FusionOfTheGods>>(v2);
        let v4 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v3,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun level(arg0: &FusionOfTheGods) : u8 {
        arg0.level
    }

    public fun name(arg0: &FusionOfTheGods) : u64 {
        arg0.name
    }

    public(friend) fun new_from_data(arg0: FusionOfTheGodsData, arg1: &mut 0x2::tx_context::TxContext) : FusionOfTheGods {
        let FusionOfTheGodsData {
            name       : v0,
            url        : v1,
            attributes : v2,
            level      : v3,
        } = arg0;
        FusionOfTheGods{
            id         : 0x2::object::new(arg1),
            name       : v0,
            url        : v1,
            attributes : v2,
            level      : v3,
        }
    }

    public fun remove_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<FusionOfTheGods>, arg1: &CollectionInfo) {
        0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::kiosk_lock_rule::remove<FusionOfTheGods>(arg0, &arg1.policy_cap);
    }

    public fun remove_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<FusionOfTheGods>, arg1: &CollectionInfo) {
        0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::royalty_rule::remove<FusionOfTheGods>(arg0, &arg1.policy_cap);
    }

    public(friend) fun replace_attributes(arg0: &mut FusionOfTheGods, arg1: 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::attributes::Attributes) {
        arg0.attributes = arg1;
    }

    public(friend) fun upgrade(arg0: &mut FusionOfTheGods, arg1: 0x1::string::String, arg2: 0xd25ff2f31e133b7b9cd3c5de648621ed45df40cc434bd53e81545c8672df72cc::attributes::Attributes) {
        assert!(arg0.level < 1, 0);
        arg0.url = arg1;
        arg0.attributes = arg2;
        arg0.level = arg0.level + 1;
    }

    // decompiled from Move bytecode v6
}


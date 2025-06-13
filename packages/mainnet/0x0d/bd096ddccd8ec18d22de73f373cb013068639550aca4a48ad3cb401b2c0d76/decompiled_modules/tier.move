module 0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::tier {
    struct TierCreated has copy, drop {
        tier_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        max_supply: u64,
    }

    struct TierDeleted has copy, drop {
        tier_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct TierMinted has copy, drop {
        tier_id: 0x2::object::ID,
        current_minted: u64,
        phase_id: 0x2::object::ID,
    }

    struct Tier has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        current_minted: u64,
    }

    public fun new(arg0: &mut 0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::Collection, arg1: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::allocate_supply(arg0, arg5);
        let v0 = 0x2::object::id<0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::Collection>(arg0);
        let v1 = 0x2::object::new(arg6);
        let v2 = TierCreated{
            tier_id       : 0x2::object::uid_to_inner(&v1),
            collection_id : v0,
            name          : arg2,
            max_supply    : arg5,
        };
        0x2::event::emit<TierCreated>(v2);
        let v3 = Tier{
            id             : v1,
            collection_id  : v0,
            name           : arg2,
            description    : arg3,
            image_url      : arg4,
            max_supply     : arg5,
            current_minted : 0,
        };
        0x2::transfer::share_object<Tier>(v3);
    }

    public fun collection_id(arg0: &Tier) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun current_minted(arg0: &Tier) : u64 {
        arg0.current_minted
    }

    public fun delete_tier(arg0: Tier, arg1: &mut 0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::Collection, arg2: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap) {
        let Tier {
            id             : v0,
            collection_id  : v1,
            name           : v2,
            description    : _,
            image_url      : _,
            max_supply     : v5,
            current_minted : v6,
        } = arg0;
        assert!(0x2::object::id<0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::Collection>(arg1) == v1, 1);
        assert!(v6 == 0, 2);
        0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection::deallocate_supply(arg1, v5 - v6);
        0x2::object::delete(v0);
        let v7 = TierDeleted{
            tier_id       : 0x2::object::uid_to_inner(&arg0.id),
            collection_id : v1,
            name          : v2,
        };
        0x2::event::emit<TierDeleted>(v7);
    }

    public fun description(arg0: &Tier) : 0x1::string::String {
        arg0.description
    }

    public fun has_supply_available(arg0: &Tier) : bool {
        arg0.current_minted < arg0.max_supply
    }

    public fun image_url(arg0: &Tier) : 0x1::string::String {
        arg0.image_url
    }

    public fun max_supply(arg0: &Tier) : u64 {
        arg0.max_supply
    }

    public fun name(arg0: &Tier) : 0x1::string::String {
        arg0.name
    }

    public fun update_image_url(arg0: &mut Tier, arg1: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.image_url = arg2;
    }

    public fun update_metadata(arg0: &mut Tier, arg1: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg0.name = arg2;
        arg0.description = arg3;
    }

    public(friend) fun validate_and_record_mint(arg0: &mut Tier, arg1: 0x2::object::ID) {
        let v0 = arg0.current_minted + 1;
        assert!(v0 <= arg0.max_supply, 0);
        arg0.current_minted = v0;
        let v1 = TierMinted{
            tier_id        : 0x2::object::uid_to_inner(&arg0.id),
            current_minted : arg0.current_minted,
            phase_id       : arg1,
        };
        0x2::event::emit<TierMinted>(v1);
    }

    // decompiled from Move bytecode v6
}


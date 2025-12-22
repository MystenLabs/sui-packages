module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct DonorPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        owner: address,
        amount_total: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
        refunded: bool,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : DonorPosition<T0> {
        DonorPosition<T0>{
            id            : 0x2::object::new(arg5),
            campaign_id   : arg0,
            owner         : arg1,
            amount_total  : arg2,
            created_at_ms : arg4,
            updated_at_ms : arg4,
            refunded      : false,
            name          : 0x1::string::utf8(b"Andorise Donor NFT"),
            description   : 0x1::string::utf8(b"Thank you for supporting this campaign! This NFT represents your contribution and can be used for rewards and governance."),
            image_url     : 0x2::url::new_unsafe_from_bytes(arg3),
        }
    }

    public fun transfer<T0>(arg0: DonorPosition<T0>, arg1: address) {
        0x2::transfer::public_transfer<DonorPosition<T0>>(arg0, arg1);
    }

    public fun amount_total<T0>(arg0: &DonorPosition<T0>) : u64 {
        arg0.amount_total
    }

    public fun burn<T0>(arg0: DonorPosition<T0>) {
        let DonorPosition {
            id            : v0,
            campaign_id   : _,
            owner         : _,
            amount_total  : _,
            created_at_ms : _,
            updated_at_ms : _,
            refunded      : _,
            name          : _,
            description   : _,
            image_url     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun campaign_id<T0>(arg0: &DonorPosition<T0>) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun created_at_ms<T0>(arg0: &DonorPosition<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun description<T0>(arg0: &DonorPosition<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun id<T0>(arg0: &DonorPosition<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url<T0>(arg0: &DonorPosition<T0>) : 0x2::url::Url {
        arg0.image_url
    }

    public(friend) fun increase_amount<T0>(arg0: &mut DonorPosition<T0>, arg1: u64, arg2: u64) {
        arg0.amount_total = arg0.amount_total + arg1;
        arg0.updated_at_ms = arg2;
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<DonorPosition<0x2::sui::SUI>>(&v0, arg1);
        0x2::display::add<DonorPosition<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DonorPosition<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DonorPosition<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<DonorPosition<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://andorise.fund"));
        0x2::display::add<DonorPosition<0x2::sui::SUI>>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Andorise Platform"));
        0x2::display::update_version<DonorPosition<0x2::sui::SUI>>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DonorPosition<0x2::sui::SUI>>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_refunded<T0>(arg0: &DonorPosition<T0>) : bool {
        arg0.refunded
    }

    public(friend) fun mark_refunded<T0>(arg0: &mut DonorPosition<T0>, arg1: u64) {
        arg0.refunded = true;
        arg0.updated_at_ms = arg1;
    }

    public fun name<T0>(arg0: &DonorPosition<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun owner<T0>(arg0: &DonorPosition<T0>) : address {
        arg0.owner
    }

    public fun updated_at_ms<T0>(arg0: &DonorPosition<T0>) : u64 {
        arg0.updated_at_ms
    }

    public fun verify_campaign<T0>(arg0: &DonorPosition<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.campaign_id == arg1, 1);
    }

    public fun verify_not_refunded<T0>(arg0: &DonorPosition<T0>) {
        assert!(!arg0.refunded, 2);
    }

    public fun verify_ownership<T0>(arg0: &DonorPosition<T0>, arg1: address) {
        assert!(arg0.owner == arg1, 3);
    }

    // decompiled from Move bytecode v6
}


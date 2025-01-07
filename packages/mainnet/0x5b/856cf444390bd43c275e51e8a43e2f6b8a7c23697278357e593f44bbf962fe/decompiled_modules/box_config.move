module 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config {
    struct BoxConfig has store, key {
        id: 0x2::object::UID,
        phase: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        box_price: u64,
        open_time: u64,
        nonce_used: 0x2::vec_set::VecSet<u64>,
        claimed_coupon: 0x2::table::Table<address, u64>,
    }

    struct CreateBoxConfigEvent has copy, drop {
        box_config_id: 0x2::object::ID,
        phase: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        box_price: u64,
        open_time: u64,
    }

    struct ModifyBoxConfigEvent has copy, drop {
        box_config_id: 0x2::object::ID,
        phase: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        box_price: u64,
        open_time: u64,
    }

    public fun add_coupon_claim_record(arg0: &mut BoxConfig, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.claimed_coupon, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed_coupon, arg1) = arg2 + get_user_claim_record(arg0, arg1);
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed_coupon, arg1, arg2);
        };
    }

    public fun assert_box_same_phase(arg0: u8, arg1: &BoxConfig) {
        assert!(arg0 == arg1.phase, 1);
    }

    public fun assert_can_open_box(arg0: &BoxConfig, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.open_time, 2);
    }

    public fun assert_nft_same_phase(arg0: u8, arg1: &BoxConfig) {
        assert!(arg0 == arg1.phase, 1);
    }

    public fun assert_nonce_used(arg0: &mut BoxConfig, arg1: u64) {
        assert!(!0x2::vec_set::contains<u64>(&arg0.nonce_used, &arg1), 3);
        0x2::vec_set::insert<u64>(&mut arg0.nonce_used, arg1);
    }

    public entry fun create_box_config(arg0: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::Contract, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::assert_admin(arg0, arg7);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg4));
        let v1 = 0x2::object::new(arg7);
        let v2 = CreateBoxConfigEvent{
            box_config_id : 0x2::object::uid_to_inner(&v1),
            phase         : arg1,
            name          : arg2,
            description   : arg3,
            img_url       : v0,
            box_price     : arg5,
            open_time     : arg6,
        };
        0x2::event::emit<CreateBoxConfigEvent>(v2);
        let v3 = BoxConfig{
            id             : v1,
            phase          : arg1,
            name           : arg2,
            description    : arg3,
            img_url        : v0,
            box_price      : arg5,
            open_time      : arg6,
            nonce_used     : 0x2::vec_set::empty<u64>(),
            claimed_coupon : 0x2::table::new<address, u64>(arg7),
        };
        0x2::transfer::share_object<BoxConfig>(v3);
    }

    public fun get_box_description(arg0: &BoxConfig) : 0x1::string::String {
        arg0.description
    }

    public fun get_box_img_url(arg0: &BoxConfig) : 0x2::url::Url {
        arg0.img_url
    }

    public fun get_box_name(arg0: &BoxConfig) : 0x1::string::String {
        arg0.name
    }

    public fun get_box_phase(arg0: &BoxConfig) : u8 {
        arg0.phase
    }

    public fun get_box_price(arg0: &BoxConfig) : u64 {
        arg0.box_price
    }

    fun get_user_claim_record(arg0: &BoxConfig, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.claimed_coupon, arg1)
    }

    public entry fun modify_box_config(arg0: &mut BoxConfig, arg1: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::Contract, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::assert_admin(arg1, arg8);
        let v0 = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg5));
        arg0.phase = arg2;
        arg0.name = arg3;
        arg0.description = arg4;
        arg0.img_url = v0;
        arg0.box_price = arg6;
        arg0.open_time = arg7;
        let v1 = ModifyBoxConfigEvent{
            box_config_id : 0x2::object::uid_to_inner(&arg0.id),
            phase         : arg2,
            name          : arg3,
            description   : arg4,
            img_url       : v0,
            box_price     : arg6,
            open_time     : arg7,
        };
        0x2::event::emit<ModifyBoxConfigEvent>(v1);
    }

    public fun remove_coupon_claim_record(arg0: &mut BoxConfig, arg1: address) {
        0x2::table::remove<address, u64>(&mut arg0.claimed_coupon, arg1);
    }

    // decompiled from Move bytecode v6
}


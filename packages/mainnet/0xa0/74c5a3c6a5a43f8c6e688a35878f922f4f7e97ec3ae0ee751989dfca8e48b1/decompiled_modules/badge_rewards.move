module 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::badge_rewards {
    struct BadgeConfig has key {
        id: 0x2::object::UID,
        crowd_walrus_id: 0x2::object::ID,
        amount_thresholds_micro: vector<u64>,
        payment_thresholds: vector<u64>,
        image_uris: vector<0x1::string::String>,
    }

    struct DonorBadge has key {
        id: 0x2::object::UID,
        level: u8,
        owner: address,
        image_uri: 0x1::string::String,
        issued_at_ms: u64,
    }

    struct BadgeConfigUpdated has copy, drop {
        amount_thresholds_micro: vector<u64>,
        payment_thresholds: vector<u64>,
        image_uris: vector<0x1::string::String>,
        timestamp_ms: u64,
    }

    struct BadgeMinted has copy, drop {
        owner: address,
        level: u8,
        profile_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct BadgeDisplayUpdated has copy, drop {
        keys: vector<0x1::string::String>,
        deep_link_template: 0x1::string::String,
        timestamp_ms: u64,
    }

    public fun amount_thresholds_micro(arg0: &BadgeConfig) : &vector<u64> {
        &arg0.amount_thresholds_micro
    }

    fun apply_display_edits(arg0: &mut 0x2::display::Display<DonorBadge>, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v1 = clone_string(0x1::vector::borrow<0x1::string::String>(arg1, v0));
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<DonorBadge>(arg0), &v1)) {
                0x2::display::edit<DonorBadge>(arg0, v1, clone_string(0x1::vector::borrow<0x1::string::String>(arg2, v0)));
            } else {
                0x2::display::add<DonorBadge>(arg0, v1, clone_string(0x1::vector::borrow<0x1::string::String>(arg2, v0)));
            };
            v0 = v0 + 1;
        };
    }

    fun assert_non_empty_strings(arg0: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg0, v0)) > 0, 3);
            v0 = v0 + 1;
        };
    }

    fun assert_strictly_increasing(arg0: &vector<u64>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) > *0x1::vector::borrow<u64>(arg0, v0 - 1), 2);
            v0 = v0 + 1;
        };
    }

    fun assert_valid_level(arg0: u8) {
        assert!(arg0 != 0 && arg0 <= 5, 4);
    }

    public fun badge_config_updated_amount_thresholds(arg0: &BadgeConfigUpdated) : vector<u64> {
        clone_u64_vector(&arg0.amount_thresholds_micro)
    }

    public fun badge_config_updated_image_uris(arg0: &BadgeConfigUpdated) : vector<0x1::string::String> {
        clone_string_vector(&arg0.image_uris)
    }

    public fun badge_config_updated_payment_thresholds(arg0: &BadgeConfigUpdated) : vector<u64> {
        clone_u64_vector(&arg0.payment_thresholds)
    }

    public fun badge_config_updated_timestamp_ms(arg0: &BadgeConfigUpdated) : u64 {
        arg0.timestamp_ms
    }

    public fun badge_display_updated_deep_link_template(arg0: &BadgeDisplayUpdated) : 0x1::string::String {
        clone_string(&arg0.deep_link_template)
    }

    public fun badge_display_updated_keys(arg0: &BadgeDisplayUpdated) : vector<0x1::string::String> {
        clone_string_vector(&arg0.keys)
    }

    public fun badge_display_updated_timestamp_ms(arg0: &BadgeDisplayUpdated) : u64 {
        arg0.timestamp_ms
    }

    public fun badge_minted_level(arg0: &BadgeMinted) : u8 {
        arg0.level
    }

    public fun badge_minted_owner(arg0: &BadgeMinted) : address {
        arg0.owner
    }

    public fun badge_minted_profile_id(arg0: &BadgeMinted) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun badge_minted_timestamp_ms(arg0: &BadgeMinted) : u64 {
        arg0.timestamp_ms
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::substring(arg0, 0, 0x1::string::length(arg0))
    }

    fun clone_string_vector(arg0: &vector<0x1::string::String>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, clone_string(0x1::vector::borrow<0x1::string::String>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun clone_u64_vector(arg0: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun create_config(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : BadgeConfig {
        BadgeConfig{
            id                      : 0x2::object::new(arg1),
            crowd_walrus_id         : arg0,
            amount_thresholds_micro : 0x1::vector::empty<u64>(),
            payment_thresholds      : 0x1::vector::empty<u64>(),
            image_uris              : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun crowd_walrus_id(arg0: &BadgeConfig) : 0x2::object::ID {
        arg0.crowd_walrus_id
    }

    fun deep_link_template(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = clone_string(arg0);
        0x1::string::append_utf8(&mut v0, b"/profile/{owner}");
        v0
    }

    fun default_badge_deep_link_template() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://crowdwalrus.xyz");
        deep_link_template(&v0)
    }

    public fun image_uri(arg0: &DonorBadge) : &0x1::string::String {
        &arg0.image_uri
    }

    public fun image_uris(arg0: &BadgeConfig) : &vector<0x1::string::String> {
        &arg0.image_uris
    }

    public fun is_configured(arg0: &BadgeConfig) : bool {
        if (0x1::vector::length<u64>(amount_thresholds_micro(arg0)) == 5) {
            if (0x1::vector::length<u64>(payment_thresholds(arg0)) == 5) {
                0x1::vector::length<0x1::string::String>(image_uris(arg0)) == 5
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun issued_at_ms(arg0: &DonorBadge) : u64 {
        arg0.issued_at_ms
    }

    public fun level(arg0: &DonorBadge) : u8 {
        arg0.level
    }

    public fun level_count() : u64 {
        5
    }

    public(friend) fun maybe_award_badges(arg0: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::Profile, arg1: &BadgeConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        assert!(arg4 >= arg2, 5);
        assert!(arg5 >= arg3, 5);
        if (!is_configured(arg1)) {
            return 0x1::vector::empty<u8>()
        };
        let v0 = amount_thresholds_micro(arg1);
        let v1 = payment_thresholds(arg1);
        let v2 = image_uris(arg1);
        let v3 = 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::owner(arg0);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 5) {
            let v7 = (v6 as u8) + 1;
            if (!0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::has_badge_level(arg0, v7)) {
                let v8 = *0x1::vector::borrow<u64>(v0, v6);
                let v9 = *0x1::vector::borrow<u64>(v1, v6);
                let v10 = arg4 >= v8 && arg5 >= v9;
                let v11 = arg2 >= v8 && arg3 >= v9;
                if (v10 && !v11) {
                    mint_badge(v3, v7, 0x1::vector::borrow<0x1::string::String>(v2, v6), v4, arg7);
                    let v12 = BadgeMinted{
                        owner        : v3,
                        level        : v7,
                        profile_id   : 0x2::object::id<0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::Profile>(arg0),
                        timestamp_ms : v4,
                    };
                    0x2::event::emit<BadgeMinted>(v12);
                    0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::grant_badge_level(arg0, v7);
                    0x1::vector::push_back<u8>(&mut v5, v7);
                };
            };
            v6 = v6 + 1;
        };
        v5
    }

    public(friend) fun mint_badge(arg0: address, arg1: u8, arg2: &0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_level(arg1);
        let v0 = DonorBadge{
            id           : 0x2::object::new(arg4),
            level        : arg1,
            owner        : arg0,
            image_uri    : clone_string(arg2),
            issued_at_ms : arg3,
        };
        0x2::transfer::transfer<DonorBadge>(v0, arg0);
    }

    public fun owner(arg0: &DonorBadge) : address {
        arg0.owner
    }

    public fun payment_thresholds(arg0: &BadgeConfig) : &vector<u64> {
        &arg0.payment_thresholds
    }

    public(friend) fun remove_badge_display_internal(arg0: &mut 0x2::display::Display<DonorBadge>, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        remove_display_keys(arg0, &arg1);
        set_link_template(arg0, &arg2);
        0x2::display::update_version<DonorBadge>(arg0);
        let v0 = BadgeDisplayUpdated{
            keys               : clone_string_vector(&arg1),
            deep_link_template : deep_link_template(&arg2),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BadgeDisplayUpdated>(v0);
    }

    entry fun remove_badge_display_keys(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<DonorBadge>, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<DonorBadge>(arg0), 6);
        remove_badge_display_internal(arg1, arg2, arg3, arg4);
    }

    fun remove_display_keys(arg0: &mut 0x2::display::Display<DonorBadge>, arg1: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            0x2::display::remove<DonorBadge>(arg0, clone_string(0x1::vector::borrow<0x1::string::String>(arg1, v0)));
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_config(arg0: &mut BadgeConfig, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock) {
        validate_inputs(&arg1, &arg2, &arg3);
        arg0.amount_thresholds_micro = arg1;
        arg0.payment_thresholds = arg2;
        arg0.image_uris = arg3;
        let v0 = BadgeConfigUpdated{
            amount_thresholds_micro : clone_u64_vector(&arg1),
            payment_thresholds      : clone_u64_vector(&arg2),
            image_uris              : clone_string_vector(&arg3),
            timestamp_ms            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BadgeConfigUpdated>(v0);
    }

    fun set_link_template(arg0: &mut 0x2::display::Display<DonorBadge>, arg1: &0x1::string::String) {
        let v0 = 0x1::string::utf8(b"link");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<DonorBadge>(arg0), &v0)) {
            0x2::display::edit<DonorBadge>(arg0, v0, deep_link_template(arg1));
        } else {
            0x2::display::add<DonorBadge>(arg0, v0, deep_link_template(arg1));
        };
    }

    entry fun setup_badge_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Crowd Walrus Donor Badge Level {level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Rewarded to {owner} for reaching badge level {level}. Issued at {issued_at_ms} ms."));
        0x1::vector::push_back<0x1::string::String>(v3, default_badge_deep_link_template());
        let v4 = 0x2::display::new_with_fields<DonorBadge>(arg0, v0, v2, arg1);
        0x2::display::update_version<DonorBadge>(&mut v4);
        0x2::transfer::public_share_object<0x2::display::Display<DonorBadge>>(v4);
    }

    public(friend) fun share_config(arg0: BadgeConfig) {
        0x2::transfer::share_object<BadgeConfig>(arg0);
    }

    entry fun update_badge_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<DonorBadge>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<DonorBadge>(arg0), 6);
        update_badge_display_internal(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_badge_display_internal(arg0: &mut 0x2::display::Display<DonorBadge>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 7);
        apply_display_edits(arg0, &arg1, &arg2);
        set_link_template(arg0, &arg3);
        0x2::display::update_version<DonorBadge>(arg0);
        let v0 = BadgeDisplayUpdated{
            keys               : clone_string_vector(&arg1),
            deep_link_template : deep_link_template(&arg3),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BadgeDisplayUpdated>(v0);
    }

    fun validate_inputs(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<u64>(arg0) == 5, 1);
        assert!(0x1::vector::length<u64>(arg1) == 5, 1);
        assert!(0x1::vector::length<0x1::string::String>(arg2) == 5, 1);
        assert_strictly_increasing(arg0);
        assert_strictly_increasing(arg1);
        assert_non_empty_strings(arg2);
    }

    // decompiled from Move bytecode v6
}


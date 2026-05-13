module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form {
    struct Form has key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        schema: vector<u8>,
        site_object_id: 0x1::option::Option<address>,
        cover_blob_id: 0x1::option::Option<vector<u8>>,
        theme: vector<u8>,
        settings: FormSettings,
        stats: FormStats,
        closed: bool,
    }

    struct FormSettings has copy, drop, store {
        access_mode: u8,
        allowlist_id: 0x1::option::Option<address>,
        required_token_type: vector<u8>,
        required_token_amount: u64,
        submission_fee_mist: u64,
        max_submissions: u64,
        closes_at_ms: u64,
    }

    struct FormStats has copy, drop, store {
        submission_count: u64,
        total_revenue_mist: u64,
        last_submission_at_ms: u64,
    }

    public fun access_allowlist() : u8 {
        1
    }

    public fun access_mode(arg0: &FormSettings) : u8 {
        arg0.access_mode
    }

    public fun access_paid() : u8 {
        3
    }

    public fun access_public() : u8 {
        0
    }

    public fun access_token() : u8 {
        2
    }

    public fun allowlist_id(arg0: &FormSettings) : &0x1::option::Option<address> {
        &arg0.allowlist_id
    }

    fun assert_valid_access_mode(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 4);
    }

    public(friend) fun bump_stats(arg0: &mut Form, arg1: u64, arg2: u64) {
        arg0.stats.submission_count = arg0.stats.submission_count + 1;
        arg0.stats.total_revenue_mist = arg0.stats.total_revenue_mist + arg1;
        arg0.stats.last_submission_at_ms = arg2;
    }

    public fun close_form(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: &0x2::clock::Clock) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        arg0.closed = true;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_form_closed(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_form_closed(0x2::object::uid_to_address(&arg0.id), 0x2::clock::timestamp_ms(arg2)));
    }

    public fun closed(arg0: &Form) : bool {
        arg0.closed
    }

    public fun closes_at_ms(arg0: &FormSettings) : u64 {
        arg0.closes_at_ms
    }

    public fun cover_blob_id(arg0: &Form) : &0x1::option::Option<vector<u8>> {
        &arg0.cover_blob_id
    }

    public fun create_and_share(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: FormSettings, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_form(arg0, arg1, arg2, arg3, arg4, arg5);
        share(v0);
        0x2::transfer::public_transfer<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun create_form(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: FormSettings, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Form, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        assert!(0x1::vector::length<u8>(&arg1) <= 100000, 1);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg0)) <= 512, 2);
        assert!(0x1::vector::length<u8>(&arg2) <= 8192, 3);
        assert_valid_access_mode(arg3.access_mode);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = FormStats{
            submission_count      : 0,
            total_revenue_mist    : 0,
            last_submission_at_ms : 0,
        };
        let v4 = Form{
            id             : v1,
            owner          : v0,
            title          : arg0,
            schema         : arg1,
            site_object_id : 0x1::option::none<address>(),
            cover_blob_id  : 0x1::option::none<vector<u8>>(),
            theme          : arg2,
            settings       : arg3,
            stats          : v3,
            closed         : false,
        };
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_form_created(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_form_created(v2, v0, v4.title, 0x1::vector::length<u8>(&v4.schema), 0x2::clock::timestamp_ms(arg4)));
        (v4, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::new(v2, arg5))
    }

    public fun id_address(arg0: &Form) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun max_schema_bytes() : u64 {
        100000
    }

    public fun max_submissions(arg0: &FormSettings) : u64 {
        arg0.max_submissions
    }

    public(friend) fun mint_from_template(arg0: address, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: FormSettings, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Form, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        assert!(0x1::vector::length<u8>(&arg2) <= 100000, 1);
        assert_valid_access_mode(arg4.access_mode);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = FormStats{
            submission_count      : 0,
            total_revenue_mist    : 0,
            last_submission_at_ms : 0,
        };
        let v3 = Form{
            id             : v0,
            owner          : arg0,
            title          : arg1,
            schema         : arg2,
            site_object_id : 0x1::option::none<address>(),
            cover_blob_id  : 0x1::option::none<vector<u8>>(),
            theme          : arg3,
            settings       : arg4,
            stats          : v2,
            closed         : false,
        };
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_form_created(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_form_created(v1, arg0, v3.title, 0x1::vector::length<u8>(&v3.schema), arg5));
        (v3, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::new(v1, arg6))
    }

    public fun new_settings(arg0: u8, arg1: 0x1::option::Option<address>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : FormSettings {
        assert_valid_access_mode(arg0);
        FormSettings{
            access_mode           : arg0,
            allowlist_id          : arg1,
            required_token_type   : arg2,
            required_token_amount : arg3,
            submission_fee_mist   : arg4,
            max_submissions       : arg5,
            closes_at_ms          : arg6,
        }
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun required_token_amount(arg0: &FormSettings) : u64 {
        arg0.required_token_amount
    }

    public fun required_token_type(arg0: &FormSettings) : &vector<u8> {
        &arg0.required_token_type
    }

    public fun schema(arg0: &Form) : &vector<u8> {
        &arg0.schema
    }

    public fun set_cover_blob_id(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: vector<u8>) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        arg0.cover_blob_id = 0x1::option::some<vector<u8>>(arg2);
    }

    public fun set_site_object_id(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: address) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        arg0.site_object_id = 0x1::option::some<address>(arg2);
    }

    public fun set_site_object_id_obj<T0: key>(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: &T0) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        let v0 = 0x2::object::id<T0>(arg2);
        arg0.site_object_id = 0x1::option::some<address>(0x2::object::id_to_address(&v0));
    }

    public fun settings(arg0: &Form) : &FormSettings {
        &arg0.settings
    }

    public fun share(arg0: Form) {
        0x2::transfer::share_object<Form>(arg0);
    }

    public fun site_object_id(arg0: &Form) : &0x1::option::Option<address> {
        &arg0.site_object_id
    }

    public fun stats(arg0: &Form) : &FormStats {
        &arg0.stats
    }

    public fun submission_count(arg0: &FormStats) : u64 {
        arg0.submission_count
    }

    public fun submission_fee_mist(arg0: &FormSettings) : u64 {
        arg0.submission_fee_mist
    }

    public fun theme(arg0: &Form) : &vector<u8> {
        &arg0.theme
    }

    public fun title(arg0: &Form) : &0x1::string::String {
        &arg0.title
    }

    public fun total_revenue_mist(arg0: &FormStats) : u64 {
        arg0.total_revenue_mist
    }

    public fun update_schema(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: vector<u8>) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        assert!(0x1::vector::length<u8>(&arg2) <= 100000, 1);
        assert!(!arg0.closed, 5);
        arg0.schema = arg2;
    }

    public fun update_settings(arg0: &mut Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: FormSettings) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg1, 0x2::object::uid_to_address(&arg0.id));
        assert!(!arg0.closed, 5);
        assert_valid_access_mode(arg2.access_mode);
        arg0.settings = arg2;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_form_settings_updated(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_form_settings_updated(0x2::object::uid_to_address(&arg0.id), arg2.access_mode, arg2.max_submissions, arg2.closes_at_ms));
    }

    // decompiled from Move bytecode v6
}


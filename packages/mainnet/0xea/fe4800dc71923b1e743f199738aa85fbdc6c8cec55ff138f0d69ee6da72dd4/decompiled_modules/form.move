module 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form {
    struct Form has key {
        id: 0x2::object::UID,
        owner: address,
        admins: 0x2::vec_set::VecSet<address>,
        schema_blob_id: vector<u8>,
        created_at_ms: u64,
        updated_at_ms: u64,
        version: u64,
        status: u8,
        submissions_count: u64,
        require_wallet: bool,
        one_per_wallet: bool,
    }

    public fun id(arg0: &Form) : 0x2::object::ID {
        0x2::object::id<Form>(arg0)
    }

    public fun add_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 3);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::events::emit_admin_added(0x2::object::id<Form>(arg0), arg1);
    }

    public fun admins(arg0: &Form) : &0x2::vec_set::VecSet<address> {
        &arg0.admins
    }

    public fun assert_admin(arg0: &Form, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 2);
    }

    public fun assert_open(arg0: &Form) {
        assert!(arg0.status == 0, 6);
    }

    fun build_form(arg0: vector<u8>, arg1: bool, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Form {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, v0);
        let v3 = Form{
            id                : 0x2::object::new(arg4),
            owner             : v0,
            admins            : v2,
            schema_blob_id    : arg0,
            created_at_ms     : v1,
            updated_at_ms     : v1,
            version           : 1,
            status            : 0,
            submissions_count : 0,
            require_wallet    : arg1,
            one_per_wallet    : arg2,
        };
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::events::emit_form_created(0x2::object::id<Form>(&v3), v0, arg0);
        v3
    }

    public(friend) fun bump_submission_count(arg0: &mut Form) {
        arg0.submissions_count = arg0.submissions_count + 1;
    }

    public fun create(arg0: vector<u8>, arg1: bool, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Form>(build_form(arg0, arg1, arg2, arg3, arg4));
    }

    public fun create_returning(arg0: vector<u8>, arg1: bool, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Form {
        build_form(arg0, arg1, arg2, arg3, arg4)
    }

    public fun is_admin(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun one_per_wallet(arg0: &Form) : bool {
        arg0.one_per_wallet
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun remove_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 != arg0.owner, 5);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 4);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::events::emit_admin_removed(0x2::object::id<Form>(arg0), arg1);
    }

    public fun require_wallet(arg0: &Form) : bool {
        arg0.require_wallet
    }

    public fun schema_blob_id(arg0: &Form) : &vector<u8> {
        &arg0.schema_blob_id
    }

    public fun set_status(arg0: &mut Form, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 <= 2, 7);
        arg0.status = arg1;
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::events::emit_form_status_changed(0x2::object::id<Form>(arg0), arg1);
    }

    public fun share(arg0: Form) {
        0x2::transfer::share_object<Form>(arg0);
    }

    public fun status(arg0: &Form) : u8 {
        arg0.status
    }

    public fun status_archived() : u8 {
        2
    }

    public fun status_closed() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun submissions_count(arg0: &Form) : u64 {
        arg0.submissions_count
    }

    public fun update_schema(arg0: &mut Form, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.schema_blob_id = arg1;
        arg0.version = arg0.version + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::events::emit_form_updated(0x2::object::id<Form>(arg0), arg1, arg0.version);
    }

    public fun version(arg0: &Form) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}


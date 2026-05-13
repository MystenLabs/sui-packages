module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events {
    struct FormCreated has copy, drop {
        form_id: address,
        owner: address,
        title: 0x1::string::String,
        schema_len: u64,
        created_at_ms: u64,
    }

    struct FormSettingsUpdated has copy, drop {
        form_id: address,
        access_mode: u8,
        max_submissions: u64,
        closes_at_ms: u64,
    }

    struct FormClosed has copy, drop {
        form_id: address,
        closed_at_ms: u64,
    }

    struct SubmissionCreated has copy, drop {
        form_id: address,
        submission_id: address,
        submitter: address,
        body_len: u64,
        submitted_at_ms: u64,
    }

    struct AllowlistUpdated has copy, drop {
        allowlist_id: address,
        form_id: address,
        member: address,
        added: bool,
    }

    struct AllowlistCreated has copy, drop {
        allowlist_id: address,
        form_id: address,
        creator: address,
        created_at_ms: u64,
    }

    struct PaymentDeposited has copy, drop {
        form_id: address,
        submitter: address,
        amount_mist: u64,
    }

    struct PaymentWithdrawn has copy, drop {
        form_id: address,
        to: address,
        amount_mist: u64,
    }

    struct TemplatePublished has copy, drop {
        template_id: address,
        creator: address,
        title: 0x1::string::String,
        category: u8,
        created_at_ms: u64,
    }

    struct TemplateCloned has copy, drop {
        template_id: address,
        buyer: address,
        price_paid_mist: u64,
        royalty_paid_mist: u64,
        new_form_id: address,
    }

    struct PlatformWithdrawn has copy, drop {
        to: address,
        amount_mist: u64,
    }

    public(friend) fun emit_allowlist_created(arg0: AllowlistCreated) {
        0x2::event::emit<AllowlistCreated>(arg0);
    }

    public(friend) fun emit_allowlist_updated(arg0: AllowlistUpdated) {
        0x2::event::emit<AllowlistUpdated>(arg0);
    }

    public(friend) fun emit_form_closed(arg0: FormClosed) {
        0x2::event::emit<FormClosed>(arg0);
    }

    public(friend) fun emit_form_created(arg0: FormCreated) {
        0x2::event::emit<FormCreated>(arg0);
    }

    public(friend) fun emit_form_settings_updated(arg0: FormSettingsUpdated) {
        0x2::event::emit<FormSettingsUpdated>(arg0);
    }

    public(friend) fun emit_payment_deposited(arg0: PaymentDeposited) {
        0x2::event::emit<PaymentDeposited>(arg0);
    }

    public(friend) fun emit_payment_withdrawn(arg0: PaymentWithdrawn) {
        0x2::event::emit<PaymentWithdrawn>(arg0);
    }

    public(friend) fun emit_platform_withdrawn(arg0: PlatformWithdrawn) {
        0x2::event::emit<PlatformWithdrawn>(arg0);
    }

    public(friend) fun emit_submission_created(arg0: SubmissionCreated) {
        0x2::event::emit<SubmissionCreated>(arg0);
    }

    public(friend) fun emit_template_cloned(arg0: TemplateCloned) {
        0x2::event::emit<TemplateCloned>(arg0);
    }

    public(friend) fun emit_template_published(arg0: TemplatePublished) {
        0x2::event::emit<TemplatePublished>(arg0);
    }

    public(friend) fun new_allowlist_created(arg0: address, arg1: address, arg2: address, arg3: u64) : AllowlistCreated {
        AllowlistCreated{
            allowlist_id  : arg0,
            form_id       : arg1,
            creator       : arg2,
            created_at_ms : arg3,
        }
    }

    public(friend) fun new_allowlist_updated(arg0: address, arg1: address, arg2: address, arg3: bool) : AllowlistUpdated {
        AllowlistUpdated{
            allowlist_id : arg0,
            form_id      : arg1,
            member       : arg2,
            added        : arg3,
        }
    }

    public(friend) fun new_form_closed(arg0: address, arg1: u64) : FormClosed {
        FormClosed{
            form_id      : arg0,
            closed_at_ms : arg1,
        }
    }

    public(friend) fun new_form_created(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64) : FormCreated {
        FormCreated{
            form_id       : arg0,
            owner         : arg1,
            title         : arg2,
            schema_len    : arg3,
            created_at_ms : arg4,
        }
    }

    public(friend) fun new_form_settings_updated(arg0: address, arg1: u8, arg2: u64, arg3: u64) : FormSettingsUpdated {
        FormSettingsUpdated{
            form_id         : arg0,
            access_mode     : arg1,
            max_submissions : arg2,
            closes_at_ms    : arg3,
        }
    }

    public(friend) fun new_payment_deposited(arg0: address, arg1: address, arg2: u64) : PaymentDeposited {
        PaymentDeposited{
            form_id     : arg0,
            submitter   : arg1,
            amount_mist : arg2,
        }
    }

    public(friend) fun new_payment_withdrawn(arg0: address, arg1: address, arg2: u64) : PaymentWithdrawn {
        PaymentWithdrawn{
            form_id     : arg0,
            to          : arg1,
            amount_mist : arg2,
        }
    }

    public(friend) fun new_platform_withdrawn(arg0: address, arg1: u64) : PlatformWithdrawn {
        PlatformWithdrawn{
            to          : arg0,
            amount_mist : arg1,
        }
    }

    public(friend) fun new_submission_created(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64) : SubmissionCreated {
        SubmissionCreated{
            form_id         : arg0,
            submission_id   : arg1,
            submitter       : arg2,
            body_len        : arg3,
            submitted_at_ms : arg4,
        }
    }

    public(friend) fun new_template_cloned(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: address) : TemplateCloned {
        TemplateCloned{
            template_id       : arg0,
            buyer             : arg1,
            price_paid_mist   : arg2,
            royalty_paid_mist : arg3,
            new_form_id       : arg4,
        }
    }

    public(friend) fun new_template_published(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u64) : TemplatePublished {
        TemplatePublished{
            template_id   : arg0,
            creator       : arg1,
            title         : arg2,
            category      : arg3,
            created_at_ms : arg4,
        }
    }

    // decompiled from Move bytecode v6
}


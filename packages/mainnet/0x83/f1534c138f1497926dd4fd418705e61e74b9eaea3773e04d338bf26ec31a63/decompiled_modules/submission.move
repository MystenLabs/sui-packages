module 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::submission {
    struct Submission has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submitter: address,
        blob_id: 0x1::string::String,
        seal_envelope_id: 0x1::string::String,
        submitted_at_epoch: u64,
        revoked: bool,
    }

    struct AnnotationIndex has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        notes: 0x2::table::Table<0x2::object::ID, Annotation>,
    }

    struct Annotation has drop, store {
        note_blob_id: 0x1::string::String,
        priority: u8,
        status: u8,
        updated_at_epoch: u64,
    }

    public fun annotate(arg0: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::AdminAllowlist, arg1: &mut AnnotationIndex, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u8, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::is_member(arg0, 0x2::tx_context::sender(arg7)), 203);
        assert!(arg1.form_id == arg3, 202);
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::allowlist_form_id(arg0) == arg3, 202);
        if (0x2::table::contains<0x2::object::ID, Annotation>(&arg1.notes, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, Annotation>(&mut arg1.notes, arg2);
            v0.note_blob_id = arg4;
            v0.priority = arg5;
            v0.status = arg6;
            v0.updated_at_epoch = 0x2::tx_context::epoch(arg7);
        } else {
            let v1 = Annotation{
                note_blob_id     : arg4,
                priority         : arg5,
                status           : arg6,
                updated_at_epoch : 0x2::tx_context::epoch(arg7),
            };
            0x2::table::add<0x2::object::ID, Annotation>(&mut arg1.notes, arg2, v1);
        };
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_submission_annotated(arg2, arg3, arg4, arg5, arg6, 0x2::tx_context::epoch(arg7));
    }

    public fun blob_id(arg0: &Submission) : 0x1::string::String {
        arg0.blob_id
    }

    public fun create_annotation_index(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AnnotationIndex {
        AnnotationIndex{
            id      : 0x2::object::new(arg1),
            form_id : arg0,
            notes   : 0x2::table::new<0x2::object::ID, Annotation>(arg1),
        }
    }

    public fun form_id(arg0: &Submission) : 0x2::object::ID {
        arg0.form_id
    }

    public fun is_revoked(arg0: &Submission) : bool {
        arg0.revoked
    }

    public fun revoke(arg0: &mut Submission, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.submitter == 0x2::tx_context::sender(arg1), 200);
        assert!(!arg0.revoked, 201);
        arg0.revoked = true;
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_submission_revoked(0x2::object::id<Submission>(arg0), arg0.form_id, arg0.submitter, 0x2::tx_context::epoch(arg1));
    }

    public fun seal_envelope_id(arg0: &Submission) : 0x1::string::String {
        arg0.seal_envelope_id
    }

    public fun share_annotation_index(arg0: AnnotationIndex) {
        0x2::transfer::share_object<AnnotationIndex>(arg0);
    }

    public fun status_in_progress() : u8 {
        2
    }

    public fun status_new() : u8 {
        0
    }

    public fun status_resolved() : u8 {
        3
    }

    public fun status_triaged() : u8 {
        1
    }

    public fun status_wont_fix() : u8 {
        4
    }

    public fun submit(arg0: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::form_registry::FormRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Submission {
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::form_registry::assert_form_active(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Submission{
            id                 : 0x2::object::new(arg4),
            form_id            : arg1,
            submitter          : v0,
            blob_id            : arg2,
            seal_envelope_id   : arg3,
            submitted_at_epoch : 0x2::tx_context::epoch(arg4),
            revoked            : false,
        };
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_submission_created(0x2::object::id<Submission>(&v1), arg1, v0, arg2, arg3, 0x2::tx_context::epoch(arg4));
        v1
    }

    public fun submitted_at_epoch(arg0: &Submission) : u64 {
        arg0.submitted_at_epoch
    }

    public fun submitter(arg0: &Submission) : address {
        arg0.submitter
    }

    public fun transfer_to(arg0: Submission, arg1: address) {
        0x2::transfer::public_transfer<Submission>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}


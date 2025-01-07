module 0x94d577c16b90bf957baf31a906e48ee9653fd774c72e2f94840b15b4e85530b7::notebook {
    struct Notebook has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        created_at: u64,
        location: 0x1::string::String,
        notes: 0x2::object_table::ObjectTable<0x2::object::ID, Note>,
        is_featured: bool,
        is_managed: bool,
        is_monetizable: bool,
    }

    struct Note has store, key {
        id: 0x2::object::UID,
        notebook_id: 0x1::option::Option<0x2::object::ID>,
        title: 0x1::string::String,
        slug: 0x1::string::String,
        created_at: u64,
        published_at: u64,
        updated_at: u64,
        revisions: u64,
        location: 0x1::option::Option<0x1::string::String>,
        body: vector<0x1::string::String>,
        categories: vector<0x1::string::String>,
        tags: vector<0x1::string::String>,
        is_monetized: bool,
        tips: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NotebookAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ManageNotebookCap has key {
        id: 0x2::object::UID,
        notebook_id: 0x2::object::ID,
        role: u8,
    }

    struct NoteTipped has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_category_to_note(arg0: &mut Note, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!((0x1::vector::length<0x1::string::String>(&arg0.categories) as u8) < 5, 1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.categories, arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.revisions = arg0.revisions + 1;
    }

    public fun add_notebook_admin(arg0: &ManageNotebookCap, arg1: address, arg2: &Notebook, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.notebook_id == 0x2::object::id<Notebook>(arg2), 1);
        assert!(arg0.role == 1, 1);
        let v0 = ManageNotebookCap{
            id          : 0x2::object::new(arg3),
            notebook_id : 0x2::object::id<Notebook>(arg2),
            role        : 1,
        };
        0x2::transfer::transfer<ManageNotebookCap>(v0, arg1);
    }

    public fun add_notebook_member(arg0: &ManageNotebookCap, arg1: address, arg2: u8, arg3: &Notebook, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.notebook_id == 0x2::object::id<Notebook>(arg3), 1);
        assert!(arg0.role == 1, 1);
        assert!(arg2 <= 2 && arg2 <= 4, 1);
        let v0 = ManageNotebookCap{
            id          : 0x2::object::new(arg4),
            notebook_id : 0x2::object::id<Notebook>(arg3),
            role        : arg2,
        };
        0x2::transfer::transfer<ManageNotebookCap>(v0, arg1);
    }

    public fun add_tag_to_note(arg0: &mut Note, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!((0x1::vector::length<0x1::string::String>(&arg0.tags) as u8) < 10, 1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tags, arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.revisions = arg0.revisions + 1;
    }

    public fun create_note(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Note {
        Note{
            id           : 0x2::object::new(arg4),
            notebook_id  : 0x1::option::none<0x2::object::ID>(),
            title        : arg0,
            slug         : arg1,
            created_at   : 0x2::clock::timestamp_ms(arg3),
            published_at : 0,
            updated_at   : 0,
            revisions    : 0,
            location     : 0x1::option::none<0x1::string::String>(),
            body         : arg2,
            categories   : 0x1::vector::empty<0x1::string::String>(),
            tags         : 0x1::vector::empty<0x1::string::String>(),
            is_monetized : false,
            tips         : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun create_notebook(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Notebook{
            id             : 0x2::object::new(arg3),
            name           : arg0,
            created_at     : 0x2::clock::timestamp_ms(arg2),
            location       : arg1,
            notes          : 0x2::object_table::new<0x2::object::ID, Note>(arg3),
            is_featured    : false,
            is_managed     : true,
            is_monetizable : false,
        };
        let v1 = ManageNotebookCap{
            id          : 0x2::object::new(arg3),
            notebook_id : 0x2::object::id<Notebook>(&v0),
            role        : 1,
        };
        0x2::transfer::share_object<Notebook>(v0);
        0x2::transfer::transfer<ManageNotebookCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun edit_note_body(arg0: &mut Note, arg1: vector<0x1::string::String>, arg2: &0x2::clock::Clock) {
        arg0.body = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.revisions = arg0.revisions + 1;
    }

    public fun edit_note_slug(arg0: &mut Note, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        arg0.slug = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.revisions = arg0.revisions + 1;
    }

    public fun edit_note_title(arg0: &mut Note, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        arg0.title = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.revisions = arg0.revisions + 1;
    }

    public fun publish_note(arg0: &ManageNotebookCap, arg1: Note, arg2: &mut Notebook, arg3: &0x2::clock::Clock) {
        assert!(arg0.notebook_id == 0x2::object::id<Notebook>(arg2), 1);
        assert!(arg0.role <= 2, 1);
        arg1.published_at = 0x2::clock::timestamp_ms(arg3);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg3);
        0x2::object_table::add<0x2::object::ID, Note>(&mut arg2.notes, 0x2::object::id<Note>(&arg1), arg1);
    }

    public fun tip_note(arg0: &mut Note, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.tips, arg1);
        let v0 = NoteTipped{dummy_field: false};
        0x2::event::emit<NoteTipped>(v0);
    }

    // decompiled from Move bytecode v6
}


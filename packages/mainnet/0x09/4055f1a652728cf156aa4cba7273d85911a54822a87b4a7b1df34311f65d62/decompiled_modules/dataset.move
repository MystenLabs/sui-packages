module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::dataset {
    struct DatasetCreated has copy, drop {
        dataset_id: 0x2::object::ID,
    }

    struct DatasetBurnedEvent has copy, drop {
        dataset_id: 0x2::object::ID,
    }

    struct DATASET has drop {
        dummy_field: bool,
    }

    struct Dataset has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::option::Option<0x1::string::String>,
        tags: 0x1::option::Option<vector<0x1::string::String>>,
        data_type: 0x1::string::String,
        data_size: u64,
        data_count: u64,
        creator: 0x1::option::Option<0x1::string::String>,
        license: 0x1::string::String,
    }

    struct Data has store, key {
        id: 0x2::object::UID,
        path: 0x1::string::String,
        blob_id: 0x1::string::String,
        blob_hash: 0x1::string::String,
        data_type: 0x1::string::String,
        range: 0x1::option::Option<Range>,
    }

    struct Range has drop, store {
        start: 0x1::option::Option<u64>,
        end: 0x1::option::Option<u64>,
    }

    struct DataPath has copy, drop, store {
        path: 0x1::string::String,
    }

    public fun add_annotation(arg0: &mut Data, arg1: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::Annotation, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::AnnotationPath, 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::Annotation>(&mut arg0.id, 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::new_annotation_path(arg1, arg2), arg1);
    }

    public fun add_annotations(arg0: &mut Dataset, arg1: 0x1::string::String, arg2: vector<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::Annotation>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_data(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::Annotation>(&arg2)) {
            add_annotation(v0, *0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::annotation::Annotation>(&arg2, v1), arg3);
            v1 = v1 + 1;
        };
    }

    public fun add_data(arg0: &mut Dataset, arg1: Data) {
        0x2::dynamic_field::add<DataPath, Data>(&mut arg0.id, new_data_path(arg1.path), arg1);
    }

    public fun borrow_mut_data(arg0: &mut Dataset, arg1: 0x1::string::String) : &mut Data {
        0x2::dynamic_field::borrow_mut<DataPath, Data>(&mut arg0.id, new_data_path(arg1))
    }

    public fun burn(arg0: Dataset) {
        emit_dataset_burned(0x2::object::id<Dataset>(&arg0));
        let Dataset {
            id          : v0,
            name        : _,
            description : _,
            tags        : _,
            data_type   : _,
            data_size   : _,
            data_count  : _,
            creator     : _,
            license     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emit_dataset_burned(arg0: 0x2::object::ID) {
        let v0 = DatasetBurnedEvent{dataset_id: arg0};
        0x2::event::emit<DatasetBurnedEvent>(v0);
    }

    public fun emit_dataset_created(arg0: 0x2::object::ID) {
        let v0 = DatasetCreated{dataset_id: arg0};
        0x2::event::emit<DatasetCreated>(v0);
    }

    fun init(arg0: DATASET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DATASET>(arg0, arg1);
        let v1 = init_dataset_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Dataset>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_dataset_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Dataset> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tags"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"data_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"data_size"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"license"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tags}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{data_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{data_size}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{license}"));
        let v4 = 0x2::display::new_with_fields<Dataset>(arg0, v0, v2, arg1);
        0x2::display::update_version<Dataset>(&mut v4);
        v4
    }

    public fun move_data(arg0: &mut Dataset, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = remove_data(arg0, arg1);
        v0.path = arg2;
        add_data(arg0, v0);
    }

    public fun new_data(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<Range>, arg5: &mut 0x2::tx_context::TxContext) : Data {
        Data{
            id        : 0x2::object::new(arg5),
            path      : arg0,
            blob_id   : arg1,
            blob_hash : arg2,
            data_type : arg3,
            range     : arg4,
        }
    }

    fun new_data_path(arg0: 0x1::string::String) : DataPath {
        DataPath{path: arg0}
    }

    public fun new_dataset(arg0: 0x1::string::String, arg1: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::Metadata, arg2: &mut 0x2::tx_context::TxContext) : Dataset {
        let v0 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::license(&arg1);
        let v1 = Dataset{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            description : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::description(&arg1),
            tags        : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::tags(&arg1),
            data_type   : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::data_type(&arg1),
            data_size   : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::data_size(&arg1),
            data_count  : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::data_count(&arg1),
            creator     : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::creator(&arg1),
            license     : 0x1::option::get_with_default<0x1::string::String>(&v0, 0x1::string::utf8(b"OpenGraph License")),
        };
        emit_dataset_created(0x2::object::id<Dataset>(&v1));
        v1
    }

    public fun new_range(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : Range {
        let v0 = 0x1::option::is_some<u64>(&arg0);
        let v1 = 0x1::option::is_some<u64>(&arg1);
        assert!(v0 || v1, 0);
        if (v0 && v1) {
            assert!(*0x1::option::borrow<u64>(&arg1) > *0x1::option::borrow<u64>(&arg0), 1);
        };
        Range{
            start : arg0,
            end   : arg1,
        }
    }

    public fun new_range_option(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : 0x1::option::Option<Range> {
        if (0x1::option::is_none<u64>(&arg0) && 0x1::option::is_none<u64>(&arg1)) {
            return 0x1::option::none<Range>()
        };
        0x1::option::some<Range>(new_range(arg0, arg1))
    }

    public fun remove_data(arg0: &mut Dataset, arg1: 0x1::string::String) : Data {
        0x2::dynamic_field::remove<DataPath, Data>(&mut arg0.id, new_data_path(arg1))
    }

    public entry fun share_dataset(arg0: Dataset) {
        0x2::transfer::share_object<Dataset>(arg0);
    }

    public fun update_metadata(arg0: &mut Dataset, arg1: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::Metadata) {
        arg0.description = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::description(&arg1);
        arg0.data_type = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::data_type(&arg1);
        arg0.data_size = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::data_size(&arg1);
        arg0.creator = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata::creator(&arg1);
    }

    public fun update_name(arg0: &mut Dataset, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}


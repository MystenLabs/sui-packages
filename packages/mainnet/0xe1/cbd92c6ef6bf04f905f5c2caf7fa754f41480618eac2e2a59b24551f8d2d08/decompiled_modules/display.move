module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::display {
    struct ObjectDisplay has key {
        id: 0x2::object::UID,
        inner: 0x2::object_bag::ObjectBag,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun create(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_bag::new(arg1);
        let v1 = init_blob_display(&arg0, arg1);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>>(&mut v0, 0x1::type_name::get<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(), v1);
        let v2 = init_storage_display(&arg0, arg1);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>>(&mut v0, 0x1::type_name::get<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(), v2);
        let v3 = init_staked_wal_display(&arg0, arg1);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>>(&mut v0, 0x1::type_name::get<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(), v3);
        let v4 = PublisherKey{dummy_field: false};
        0x2::object_bag::add<PublisherKey, 0x2::package::Publisher>(&mut v0, v4, arg0);
        let v5 = ObjectDisplay{
            id    : 0x2::object::new(arg1),
            inner : v0,
        };
        0x2::transfer::share_object<ObjectDisplay>(v5);
    }

    fun init_blob_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob> {
        let v0 = 0x2::display::new<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(arg0, arg1);
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Walrus Blob ({size}b)"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Registered: {registered_epoch}; certified: {certified_epoch}; deletable: {deletable}"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://www.walrus.xyz/walrus-blob"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://walrus.xyz/"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(&mut v0);
        v0
    }

    fun init_staked_wal_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal> {
        let v0 = 0x2::display::new<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(arg0, arg1);
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Staked WAL ({principal} FROST)"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Staked for node: {node_id}, activates at: {activation_epoch}"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://www.walrus.xyz/walrus-stakedwal"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://walrus.xyz/"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staked_wal::StakedWal>(&mut v0);
        v0
    }

    fun init_storage_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage> {
        let v0 = 0x2::display::new<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(arg0, arg1);
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Walrus Storage Resource ({storage_size}b)"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Start: {start_epoch}; end: {end_epoch}"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://www.walrus.xyz/walrus-storage"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://walrus.xyz/"));
        0x2::display::add<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}


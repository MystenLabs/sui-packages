module 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::display {
    struct DISPLAY has drop {
        dummy_field: bool,
    }

    fun create_admin_cap_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap>(arg0, arg1, arg2);
        let v2 = v1;
        set_fields<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap>(v0, &v2, b"Waldrop System Control", x"526f6f74206361706162696c69747920666f72207468652057616c64726f702070726f746f636f6c2e20436f6e74726f6c732070726963696e672c20706c616e732c20616e642074726561737572792e20436f6c642073746f72616765206f6e6c7920e28094206e65766572207472616e7366657220746f206120686f742077616c6c65742e", b"https://app.waldrop.xyz/api/display/admin/{id}");
        v2
    }

    fun create_blob_store_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::BlobStore> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::BlobStore>(arg0, arg1, arg2);
        let v2 = v1;
        set_fields<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::BlobStore>(v0, &v2, b"Waldrop Vault", b"A decentralized storage vault holding {total_blobs} blobs on Walrus. Verifiable, programmable, and owned by you.", b"https://app.waldrop.xyz/api/display/store/{id}");
        v2
    }

    public fun create_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : (0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount>, 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription>, 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::BlobStore>, 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration::MigrationJob>, 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap>) {
        let v0 = create_user_account_display(arg0, arg1, arg2);
        let v1 = create_subscription_display(arg0, arg1, arg2);
        let v2 = create_blob_store_display(arg0, arg1, arg2);
        let v3 = create_migration_job_display(arg0, arg1, arg2);
        (v0, v1, v2, v3, create_admin_cap_display(arg0, arg1, arg2))
    }

    fun create_migration_job_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration::MigrationJob> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration::MigrationJob>(arg0, arg1, arg2);
        let v2 = v1;
        set_fields<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration::MigrationJob>(v0, &v2, b"Waldrop Migration - {source_type}", b"Moving {file_count} files from {source_type} to decentralized storage on Walrus. {files_processed} files processed so far.", b"https://app.waldrop.xyz/api/display/job/{id}");
        v2
    }

    fun create_subscription_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription>(arg0, arg1, arg2);
        let v2 = v1;
        set_fields<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription>(v0, &v2, b"Waldrop Subscription", b"Your active Waldrop plan. Expires epoch {expires_epoch}. Paid in {payment_coin_type}. Manage at app.waldrop.xyz/plans", b"https://app.waldrop.xyz/api/display/subscription/{id}");
        v2
    }

    fun create_user_account_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount>(arg0, arg1, arg2);
        let v2 = v1;
        set_fields<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount>(v0, &v2, b"Waldrop Account", b"Decentralized ETL on Sui - {total_blobs} datasets piped to Walrus.", b"https://app.waldrop.xyz/api/display/user/{id}");
        v2
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DISPLAY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun key_description() : 0x1::string::String {
        0x1::string::utf8(b"description")
    }

    fun key_image_url() : 0x1::string::String {
        0x1::string::utf8(b"image_url")
    }

    fun key_name() : 0x1::string::String {
        0x1::string::utf8(b"name")
    }

    fun key_project_url() : 0x1::string::String {
        0x1::string::utf8(b"project_url")
    }

    fun set_fields<T0: key>(arg0: 0x2::display_registry::Display<T0>, arg1: &0x2::display_registry::DisplayCap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        0x2::display_registry::set<T0>(&mut arg0, arg1, key_name(), 0x1::string::utf8(arg2));
        0x2::display_registry::set<T0>(&mut arg0, arg1, key_description(), 0x1::string::utf8(arg3));
        0x2::display_registry::set<T0>(&mut arg0, arg1, key_image_url(), 0x1::string::utf8(arg4));
        0x2::display_registry::set<T0>(&mut arg0, arg1, key_project_url(), 0x1::string::utf8(b"https://app.waldrop.xyz"));
        0x2::display_registry::share<T0>(arg0);
    }

    entry fun setup_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = create_display(arg0, arg1, arg2);
        let v5 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount>>(v0, v5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription>>(v1, v5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::BlobStore>>(v2, v5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration::MigrationJob>>(v3, v5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::AdminCap>>(v4, v5);
    }

    // decompiled from Move bytecode v7
}


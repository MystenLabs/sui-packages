module 0x8c3b42b443da70be8bbc8cc6c0bfc0d91965f8b406b93d13c08f92949a612361::receipt {
    struct RECEIPT has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReceiptHead has key {
        id: 0x2::object::UID,
        writer: address,
        wallet: address,
        action: vector<u8>,
        blob_id: vector<u8>,
        content_hash: vector<u8>,
        version: u64,
        updated_ms: u64,
        extensions: 0x2::bag::Bag,
    }

    struct HeadUpdated has copy, drop {
        head_id: address,
        wallet: address,
        action: vector<u8>,
        blob_id: vector<u8>,
        content_hash: vector<u8>,
        version: u64,
        updated_ms: u64,
    }

    public fun blob_id(arg0: &ReceiptHead) : &vector<u8> {
        &arg0.blob_id
    }

    public fun config_version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun content_hash(arg0: &ReceiptHead) : &vector<u8> {
        &arg0.content_hash
    }

    public entry fun create_head(arg0: &Config, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x1::vector::length<u8>(&arg2) <= 32, 3);
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 3);
        assert!(0x1::vector::length<u8>(&arg4) <= 128, 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = ReceiptHead{
            id           : 0x2::object::new(arg6),
            writer       : v1,
            wallet       : arg1,
            action       : arg2,
            blob_id      : arg3,
            content_hash : arg4,
            version      : 0,
            updated_ms   : v0,
            extensions   : 0x2::bag::new(arg6),
        };
        let v3 = HeadUpdated{
            head_id      : 0x2::object::id_address<ReceiptHead>(&v2),
            wallet       : arg1,
            action       : v2.action,
            blob_id      : v2.blob_id,
            content_hash : v2.content_hash,
            version      : 0,
            updated_ms   : v0,
        };
        0x2::event::emit<HeadUpdated>(v3);
        0x2::transfer::transfer<ReceiptHead>(v2, v1);
    }

    fun init(arg0: RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg0.version, 4);
        arg0.version = arg2;
    }

    public fun remove_extension<T0: store>(arg0: &Config, arg1: &mut ReceiptHead, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.version == 1, 2);
        assert!(arg1.writer == 0x2::tx_context::sender(arg3), 1);
        0x2::bag::remove<vector<u8>, T0>(&mut arg1.extensions, arg2)
    }

    public fun set_extension<T0: store>(arg0: &Config, arg1: &mut ReceiptHead, arg2: vector<u8>, arg3: T0, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg1.writer == 0x2::tx_context::sender(arg4), 1);
        0x2::bag::add<vector<u8>, T0>(&mut arg1.extensions, arg2, arg3);
    }

    public entry fun set_head(arg0: &Config, arg1: &mut ReceiptHead, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg1.writer == 0x2::tx_context::sender(arg5), 1);
        assert!(0x1::vector::length<u8>(&arg2) <= 128, 3);
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg1.blob_id = arg2;
        arg1.content_hash = arg3;
        arg1.version = arg1.version + 1;
        arg1.updated_ms = v0;
        let v1 = HeadUpdated{
            head_id      : 0x2::object::id_address<ReceiptHead>(arg1),
            wallet       : arg1.wallet,
            action       : arg1.action,
            blob_id      : arg1.blob_id,
            content_hash : arg1.content_hash,
            version      : arg1.version,
            updated_ms   : v0,
        };
        0x2::event::emit<HeadUpdated>(v1);
    }

    public fun version(arg0: &ReceiptHead) : u64 {
        arg0.version
    }

    public fun writer(arg0: &ReceiptHead) : address {
        arg0.writer
    }

    // decompiled from Move bytecode v7
}


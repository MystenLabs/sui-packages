module 0xe7fcb433f605c961dc670f2cdea11b0414c88e0e060929f27323fd52660a04f1::receipt_anchor {
    struct ReceiptAnchor has store, key {
        id: 0x2::object::UID,
        merkle_root: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        workspace_id: 0x1::string::String,
        receipt_count: u64,
        committed_at_ms: u64,
        sequence: u64,
    }

    struct AnchorRegistry has key {
        id: 0x2::object::UID,
        total_anchors: u64,
    }

    struct AnchorCommitted has copy, drop {
        merkle_root: 0x1::string::String,
        workspace_id: 0x1::string::String,
        receipt_count: u64,
        walrus_blob_id: 0x1::string::String,
        sequence: u64,
        committed_at_ms: u64,
    }

    public entry fun commit_anchor(arg0: &mut AnchorRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_anchors;
        arg0.total_anchors = arg0.total_anchors + 1;
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::string::utf8(arg1);
        let v3 = 0x1::string::utf8(arg2);
        let v4 = 0x1::string::utf8(arg3);
        let v5 = AnchorCommitted{
            merkle_root     : v2,
            workspace_id    : v4,
            receipt_count   : arg4,
            walrus_blob_id  : v3,
            sequence        : v0,
            committed_at_ms : v1,
        };
        0x2::event::emit<AnchorCommitted>(v5);
        let v6 = ReceiptAnchor{
            id              : 0x2::object::new(arg6),
            merkle_root     : v2,
            walrus_blob_id  : v3,
            workspace_id    : v4,
            receipt_count   : arg4,
            committed_at_ms : v1,
            sequence        : v0,
        };
        0x2::transfer::transfer<ReceiptAnchor>(v6, 0x2::tx_context::sender(arg6));
    }

    public fun committed_at_ms(arg0: &ReceiptAnchor) : u64 {
        arg0.committed_at_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnchorRegistry{
            id            : 0x2::object::new(arg0),
            total_anchors : 0,
        };
        0x2::transfer::share_object<AnchorRegistry>(v0);
    }

    public fun merkle_root(arg0: &ReceiptAnchor) : &0x1::string::String {
        &arg0.merkle_root
    }

    public fun receipt_count(arg0: &ReceiptAnchor) : u64 {
        arg0.receipt_count
    }

    public fun sequence(arg0: &ReceiptAnchor) : u64 {
        arg0.sequence
    }

    public fun total_anchors(arg0: &AnchorRegistry) : u64 {
        arg0.total_anchors
    }

    public fun walrus_blob_id(arg0: &ReceiptAnchor) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    public fun workspace_id(arg0: &ReceiptAnchor) : &0x1::string::String {
        &arg0.workspace_id
    }

    // decompiled from Move bytecode v7
}


module 0x882daca9e8a6aec24ad7f5552474fbd1174648fe4510fe029d29a718f20a59e1::anchor {
    struct AnchorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AttestationAnchored has copy, drop {
        digest: vector<u8>,
        gtin: 0x1::string::String,
        attester: address,
        timestamp_ms: u64,
    }

    public fun anchor(arg0: &AnchorAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AttestationAnchored{
            digest       : arg1,
            gtin         : 0x1::string::utf8(arg2),
            attester     : 0x2::tx_context::sender(arg4),
            timestamp_ms : arg3,
        };
        0x2::event::emit<AttestationAnchored>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnchorAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AnchorAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}


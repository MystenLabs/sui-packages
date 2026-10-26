module 0x70b5189985e476f8f2e6f014ed9e2e6aeee71f4cafb07b768c3a7c7467e0e793::audit {
    struct Audit has drop, store {
        description: 0x1::string::String,
        report_url: 0x1::string::String,
        report_hash: 0x1::option::Option<0x1::string::String>,
        published_at_ms: u64,
    }

    struct AuditAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun attest_audit(arg0: &AuditAdminCap, arg1: &0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::Registry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Audit{
            description     : arg3,
            report_url      : arg4,
            report_hash     : arg5,
            published_at_ms : arg6,
        };
        0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::attest<Audit>(arg1, 0x1::internal::permit<Audit>(), arg2, v0, arg7, arg8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuditAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AuditAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun register_audit_display(arg0: &0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::Registry, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link_hash"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"published_at"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Demo audit (no security assurance)"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DEMO ONLY - no security assurance. {data.description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{data.report_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{data.report_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/MystenLabs/attestations"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{data.published_at_ms:ts}"));
        0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::register_display<Audit>(arg0, arg1, 0x1::internal::permit<Audit>(), v0, v2, arg2);
    }

    public fun revoke_audit(arg0: &AuditAdminCap, arg1: &mut 0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::Registry, arg2: 0x2::object::ID, arg3: 0x2::transfer::Receiving<0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::Attestation<Audit>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf918b2fc17085f4e48021be94ee43f9cc4437256acfd085f1e3d1a54d11f6e7b::attestations::revoke<Audit>(arg1, 0x1::internal::permit<Audit>(), arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}


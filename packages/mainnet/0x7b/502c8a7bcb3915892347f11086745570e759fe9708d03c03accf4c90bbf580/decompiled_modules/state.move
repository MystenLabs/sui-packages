module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state {
    struct State has key {
        id: 0x2::object::UID,
        trusted_signers: vector<TrustedSignerInfo>,
        upgrade_cap: 0x2::package::UpgradeCap,
        governance: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::Governance,
    }

    struct CurrentCap has drop {
        dummy_field: bool,
    }

    struct TrustedSignerInfo has copy, drop, store {
        public_key: vector<u8>,
        expires_at: u64,
    }

    public(friend) fun authorize_upgrade(arg0: &mut State, arg1: &CurrentCap, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg2)
    }

    public(friend) fun commit_upgrade(arg0: &mut State, arg1: &CurrentCap, arg2: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg2);
    }

    public(friend) fun current_cap(arg0: &State) : CurrentCap {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::meta::version() == 0x2::package::version(&arg0.upgrade_cap), 13906834827178672133);
        CurrentCap{dummy_field: false}
    }

    public(friend) fun expires_at_ms(arg0: &TrustedSignerInfo) : u64 {
        arg0.expires_at * 1000
    }

    public(friend) fun public_key(arg0: &TrustedSignerInfo) : &vector<u8> {
        &arg0.public_key
    }

    public(friend) fun secp256k1_compressed_pubkey_len() : u64 {
        33
    }

    public(friend) fun share(arg0: 0x2::package::UpgradeCap, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::Governance, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::upgrade_package(&arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<State>(), 13906834419156910087);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::meta::version() == 0x2::package::version(&arg0), 13906834427746713605);
        let v1 = State{
            id              : 0x2::object::new(arg2),
            trusted_signers : 0x1::vector::empty<TrustedSignerInfo>(),
            upgrade_cap     : arg0,
            governance      : arg1,
        };
        0x2::transfer::share_object<State>(v1);
    }

    public(friend) fun trusted_signers(arg0: &State, arg1: &CurrentCap) : &vector<TrustedSignerInfo> {
        &arg0.trusted_signers
    }

    public(friend) fun unwrap_ptgm(arg0: &mut State, arg1: &CurrentCap, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::GovernanceHeader, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::Parser) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::new(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::process_incoming(&mut arg0.governance, arg2));
        (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::parse_header(&mut v0), v0)
    }

    public(friend) fun update_trusted_signer(arg0: &mut State, arg1: &CurrentCap, arg2: vector<u8>, arg3: u64) {
        assert!(0x1::vector::length<u8>(&arg2) == secp256k1_compressed_pubkey_len(), 13906834672559587329);
        let v0 = &arg0.trusted_signers;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<TrustedSignerInfo>(v0)) {
            if (public_key(0x1::vector::borrow<TrustedSignerInfo>(v0, v1)) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 8 */
                if (arg3 == 0) {
                    if (0x1::option::is_some<u64>(&v2)) {
                        0x1::vector::swap_remove<TrustedSignerInfo>(&mut arg0.trusted_signers, 0x1::option::extract<u64>(&mut v2));
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v2);
                        abort 13906834732689260547
                    };
                };
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::borrow_mut<TrustedSignerInfo>(&mut arg0.trusted_signers, 0x1::option::extract<u64>(&mut v2)).expires_at = arg3;
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    let v3 = TrustedSignerInfo{
                        public_key : arg2,
                        expires_at : arg3,
                    };
                    0x1::vector::push_back<TrustedSignerInfo>(&mut arg0.trusted_signers, v3);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    // decompiled from Move bytecode v6
}


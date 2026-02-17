module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance {
    struct Governance has copy, drop, store {
        chain_id: u16,
        address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        seen_sequence: u64,
    }

    struct GovernanceHeader has drop {
        action: u8,
    }

    public(friend) fun is_update_trusted_signer(arg0: &GovernanceHeader) : bool {
        arg0.action == 1
    }

    public(friend) fun is_upgrade_lazer_contract(arg0: &GovernanceHeader) : bool {
        arg0.action == 0
    }

    public(friend) fun new(arg0: u16, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : Governance {
        Governance{
            chain_id      : arg0,
            address       : arg1,
            seen_sequence : 0,
        }
    }

    public(friend) fun parse_header(arg0: &mut 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::Parser) : GovernanceHeader {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_bytes(arg0, 4) == b"PTGM", 13906834560890568707);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_u8(arg0) == 3, 13906834569480634373);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_u16_be(arg0) == 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::meta::receiver_chain_id(), 13906834582365798409);
        GovernanceHeader{action: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_u8(arg0)}
    }

    public(friend) fun process_incoming(arg0: &mut Governance, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : vector<u8> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        assert!(arg0.chain_id == v1, 13906834436336779271);
        assert!(arg0.address == v2, 13906834440632008715);
        assert!(arg0.seen_sequence < v0, 13906834444927107085);
        arg0.seen_sequence = v0;
        v3
    }

    // decompiled from Move bytecode v6
}


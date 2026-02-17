module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::actions {
    public fun commit_upgrade(arg0: &mut 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: 0x2::package::UpgradeReceipt) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::current_cap(arg0);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::commit_upgrade(arg0, &v0, arg1);
    }

    entry fun init_lazer(arg0: 0x2::package::UpgradeCap, arg1: u16, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::share(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::new(arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new_nonzero(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg2))), arg3);
    }

    public fun update_trusted_signer(arg0: &mut 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::current_cap(arg0);
        let (v1, v2) = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::unwrap_ptgm(arg0, &v0, arg1);
        let v3 = v2;
        let v4 = v1;
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::is_update_trusted_signer(&v4), 13906834449221419011);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::destroy_empty(v3);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::update_trusted_signer(arg0, &v0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_bytes(&mut v3, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::secp256k1_compressed_pubkey_len()), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_u64_be(&mut v3));
    }

    public fun upgrade(arg0: &mut 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : 0x2::package::UpgradeTicket {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::current_cap(arg0);
        let (v1, v2) = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::unwrap_ptgm(arg0, &v0, arg1);
        let v3 = v2;
        let v4 = v1;
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::governance::is_upgrade_lazer_contract(&v4), 13906834367616909313);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_u64_be(&mut v3) == 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::meta::version() + 1, 13906834380502073349);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::destroy_empty(v3);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::authorize_upgrade(arg0, &v0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser::take_bytes(&mut v3, 32))
    }

    // decompiled from Move bytecode v6
}


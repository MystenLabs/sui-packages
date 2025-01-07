module 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_metadata_by_address(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::add_metadata_by_address(arg2, arg3, 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::new_mint_metadata(arg4, arg5, arg6, arg7, arg8));
    }

    public entry fun add_metadata_by_id(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::add_metadata_by_id(arg2, arg3, 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::new_mint_metadata(arg4, arg5, arg6, arg7, arg8));
    }

    public entry fun setup_policy<T0: store + key>(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::mint::setup_policy<T0>(arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x9389fc0b53610f38292b5eaccab3a5cb4be4cd9a08ebb7598b990ee57550d535);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>(0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun reset_metadata_by_address(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::get_all_metadata_by_address(arg2, arg3);
    }

    public entry fun reset_metadata_by_id(arg0: &OperatorCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::get_metadata_by_id(arg2, arg3);
    }

    entry fun upgrade(arg0: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::VersionCap, arg1: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::upgrade(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


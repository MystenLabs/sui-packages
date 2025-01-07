module 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun setup_policy<T0: store + key>(arg0: &OperatorCap, arg1: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg1);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::mint::setup_policy<T0>(arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x9389fc0b53610f38292b5eaccab3a5cb4be4cd9a08ebb7598b990ee57550d535);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public entry fun mint_nft_to_custodian_by_address(arg0: &OperatorCap, arg1: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg2: &mut 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::Custodian, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg1);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::add_nft_by_address(arg2, arg3, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::mint_nft(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun mint_nft_to_custodian_by_id(arg0: &OperatorCap, arg1: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg2: &mut 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::Custodian, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg1);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::add_nft_by_id(arg2, arg3, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::mint_nft(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    entry fun upgrade(arg0: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::VersionCap, arg1: &mut 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::upgrade(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


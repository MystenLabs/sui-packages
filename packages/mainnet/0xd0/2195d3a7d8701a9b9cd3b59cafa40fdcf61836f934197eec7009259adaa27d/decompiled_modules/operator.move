module 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun setup_policy<T0: store + key>(arg0: &OperatorCap, arg1: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg1);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::mint::setup_policy<T0>(arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x5fe2415c93cfd6251e579dfbd4f609795a0c917f33c40e82aaba5aec698d8769);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::Pandorian>(0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public entry fun mint_nft_to_custodian_by_address(arg0: &OperatorCap, arg1: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: &mut 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::Custodian, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg1);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::add_nft_by_address(arg2, arg3, 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::mint_nft(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun mint_nft_to_custodian_by_id(arg0: &OperatorCap, arg1: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: &mut 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::Custodian, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg1);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::add_nft_by_id(arg2, arg3, 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::mint_nft(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun mint_nft_to_kiosk(arg0: &OperatorCap, arg1: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &0x2::transfer_policy::TransferPolicy<0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::Pandorian>, arg9: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg9);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::lock<0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::Pandorian>(&mut v3, &v2, arg8, 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg9));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg9));
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    entry fun upgrade(arg0: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::VersionCap, arg1: &mut 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::upgrade(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


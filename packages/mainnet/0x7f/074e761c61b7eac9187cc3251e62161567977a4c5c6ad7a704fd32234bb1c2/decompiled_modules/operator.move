module 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun setup_policy<T0: store + key>(arg0: &OperatorCap, arg1: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::assert_current_version(arg1);
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::mint::setup_policy<T0>(arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x5fe2415c93cfd6251e579dfbd4f609795a0c917f33c40e82aaba5aec698d8769);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::Pandorian>(0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public entry fun mint_nft_to_custodian_by_address(arg0: &OperatorCap, arg1: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: &mut 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::custodian::Custodian, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::assert_current_version(arg1);
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::custodian::add_nft_by_address(arg2, arg3, 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::new_pandorian_store(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun mint_nft_to_custodian_by_id(arg0: &OperatorCap, arg1: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: &mut 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::custodian::Custodian, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::assert_current_version(arg1);
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::custodian::add_nft_by_id(arg2, arg3, 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::new_pandorian_store(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun mint_nft_to_kiosk(arg0: &OperatorCap, arg1: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &0x2::transfer_policy::TransferPolicy<0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::Pandorian>, arg9: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::assert_current_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg9);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg9);
        0x2::kiosk::lock<0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::Pandorian>(&mut v2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg8, 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg9));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    entry fun upgrade(arg0: &0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::VersionCap, arg1: &mut 0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x7f074e761c61b7eac9187cc3251e62161567977a4c5c6ad7a704fd32234bb1c2::version::upgrade(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


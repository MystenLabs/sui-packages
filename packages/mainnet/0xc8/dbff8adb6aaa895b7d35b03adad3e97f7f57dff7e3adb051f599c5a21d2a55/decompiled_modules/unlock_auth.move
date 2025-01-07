module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::unlock_auth {
    struct UNLOCKAUTH has drop {
        dummy_field: bool,
    }

    struct UnlockAuth has store, key {
        id: 0x2::object::UID,
    }

    struct WrapperPolicy<phantom T0> has store, key {
        id: 0x2::object::UID,
        transferpolicy: 0x2::transfer_policy::TransferPolicy<T0>,
        transferpolicycap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    struct WrapperPolicyKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct WrapperAirdropExtCap has copy, drop, store {
        dummy_field: bool,
    }

    fun uid_mut(arg0: &mut UnlockAuth) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun add_aidrop_ext_cap(arg0: &mut UnlockAuth, arg1: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WrapperAirdropExtCap{dummy_field: false};
        0x2::dynamic_field::add<WrapperAirdropExtCap, 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::AirdropExtCap>(uid_mut(arg0), v0, 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::create_airdrop_ext_cap(arg1, arg2));
    }

    public fun add_new_policy<T0: store + key>(arg0: &mut UnlockAuth, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<UnlockAuth>(arg1), 1);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg1, arg2);
        let v2 = WrapperPolicy<T0>{
            id                : 0x2::object::new(arg2),
            transferpolicy    : v0,
            transferpolicycap : v1,
        };
        let v3 = WrapperPolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<WrapperPolicyKey<T0>, WrapperPolicy<T0>>(uid_mut(arg0), v3, v2);
    }

    fun borrow_airdrop_ext_cap(arg0: &UnlockAuth) : &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::AirdropExtCap {
        let v0 = WrapperAirdropExtCap{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<WrapperAirdropExtCap, 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::AirdropExtCap>(uid(arg0), v0), 0);
        let v1 = WrapperAirdropExtCap{dummy_field: false};
        0x2::dynamic_field::borrow<WrapperAirdropExtCap, 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::AirdropExtCap>(uid(arg0), v1)
    }

    fun borrow_auth_policy<T0: store + key>(arg0: &UnlockAuth) : &0x2::transfer_policy::TransferPolicy<T0> {
        let v0 = WrapperPolicyKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<WrapperPolicyKey<T0>, WrapperPolicy<T0>>(uid(arg0), v0), 0);
        let v1 = WrapperPolicyKey<T0>{dummy_field: false};
        borrow_transfer_policy<T0>(0x2::dynamic_field::borrow<WrapperPolicyKey<T0>, WrapperPolicy<T0>>(uid(arg0), v1))
    }

    fun borrow_transfer_policy<T0>(arg0: &WrapperPolicy<T0>) : &0x2::transfer_policy::TransferPolicy<T0> {
        &arg0.transferpolicy
    }

    public fun create_new_auth(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<UnlockAuth>(arg0), 1);
        let v0 = UnlockAuth{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<UnlockAuth>(v0);
    }

    public fun export_cyberpill(arg0: &UnlockAuth, arg1: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill, arg2: &mut 0x2::kiosk::Kiosk) {
        0x2::dynamic_field::add<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::uid_mut(&mut arg1), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock(), true);
        0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::lock<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill>(borrow_airdrop_ext_cap(arg0), arg2, arg1, borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill>(arg0));
    }

    public fun export_equipment(arg0: &UnlockAuth, arg1: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment, arg2: &mut 0x2::kiosk::Kiosk) {
        0x2::dynamic_field::add<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::uid_mut(&mut arg1), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock(), true);
        0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::lock<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment>(borrow_airdrop_ext_cap(arg0), arg2, arg1, borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment>(arg0));
    }

    public fun export_merch(arg0: &UnlockAuth, arg1: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch, arg2: &mut 0x2::kiosk::Kiosk) {
        0x2::dynamic_field::add<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::uid_mut(&mut arg1), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock(), true);
        0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::lock<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch>(borrow_airdrop_ext_cap(arg0), arg2, arg1, borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch>(arg0));
    }

    public fun export_panzerdog(arg0: &UnlockAuth, arg1: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog, arg2: &mut 0x2::kiosk::Kiosk) {
        0x2::dynamic_field::add<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid_mut(&mut arg1), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock(), true);
        0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::lock<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(borrow_airdrop_ext_cap(arg0), arg2, arg1, borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(arg0));
    }

    public fun export_panzerpart(arg0: &UnlockAuth, arg1: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart, arg2: &mut 0x2::kiosk::Kiosk) {
        0x2::dynamic_field::add<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::uid_mut(&mut arg1), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock(), true);
        0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext::lock<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart>(borrow_airdrop_ext_cap(arg0), arg2, arg1, borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart>(arg0));
    }

    public fun import_cyberpill(arg0: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill, arg1: 0x2::transfer_policy::TransferRequest<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        0x2::dynamic_field::remove<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::uid_mut(&mut arg0), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock());
        internal_import_process<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills::Cyberpill>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun import_equipment(arg0: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment, arg1: 0x2::transfer_policy::TransferRequest<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        0x2::dynamic_field::remove<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::uid_mut(&mut arg0), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock());
        internal_import_process<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::equipment::Equipment>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun import_merch(arg0: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch, arg1: 0x2::transfer_policy::TransferRequest<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        0x2::dynamic_field::remove<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::uid_mut(&mut arg0), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock());
        internal_import_process<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch::Merch>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun import_panzerdog(arg0: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog, arg1: 0x2::transfer_policy::TransferRequest<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(0x2::object::borrow_id<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(&arg0)));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(0x2::object::borrow_id<UnlockAuth>(arg2)));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::borrow_salt(arg4)));
        let v1 = 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::borrow_pub_key(arg4);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &v1, &v0, arg6), 2);
        0x2::dynamic_field::remove<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::uid_mut(&mut arg0), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock());
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(borrow_auth_policy<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(arg2), arg1);
        0x2::transfer::public_transfer<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::Panzerdog>(arg0, arg3);
    }

    public fun import_panzerpart(arg0: 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart, arg1: 0x2::transfer_policy::TransferRequest<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        0x2::dynamic_field::remove<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::ItemOutOfGame, bool>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::uid_mut(&mut arg0), 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::lock());
        internal_import_process<0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts::PanzerPart>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun internal_import_process<T0: store + key>(arg0: T0, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: &UnlockAuth, arg3: address, arg4: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::Signer, arg5: vector<u8>, arg6: u8) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(0x2::object::borrow_id<T0>(&arg0)));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(0x2::object::borrow_id<UnlockAuth>(arg2)));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::borrow_salt(arg4)));
        let v1 = 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::signer::borrow_pub_key(arg4);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &v1, &v0, arg6), 2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(borrow_auth_policy<T0>(arg2), arg1);
        0x2::transfer::public_transfer<T0>(arg0, arg3);
    }

    fun uid(arg0: &UnlockAuth) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}


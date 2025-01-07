module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item {
    public(friend) fun equip<T0: copy + drop + store, T1: drop, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T2>, arg6: T1, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<T0>(arg0, arg1), 1);
        0x2::kiosk::list<T2>(arg3, arg4, arg2, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T2>(arg3, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<T2, T1>(arg6, arg5, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T2>(arg5, v2);
        0x2::dynamic_object_field::add<T0, T2>(arg0, arg1, v0);
    }

    public(friend) fun init_state<T0: drop, T1: drop, T2: store + key>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://animalabs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Anima Labs"));
        let v4 = 0x2::package::claim<T0>(arg0, arg3);
        let v5 = 0x2::display::new_with_fields<T2>(&v4, v0, v2, arg3);
        0x2::display::update_version<T2>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<T2>>(v5, 0x2::tx_context::sender(arg3));
        let (v6, v7) = 0x2::transfer_policy::new<T2>(&v4, arg3);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T2>(&mut v9, &v8, 100, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<T2>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<T2>(&mut v9, &v8);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T2>>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T2>>(v8, 0x2::tx_context::sender(arg3));
        let (v10, v11) = 0x2::transfer_policy::new<T2>(&v4, arg3);
        let v12 = v11;
        let v13 = v10;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<T2, T1>(&mut v13, &v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T2>>(v13);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T2>>(v12, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun unequip<T0: copy + drop + store, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T1>) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_<T0>(arg0, arg1), 2);
        let v0 = 0x2::dynamic_object_field::remove<T0, T1>(arg0, arg1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 3);
        0x2::kiosk::lock<T1>(arg2, arg3, arg4, v0);
        0x2::object::id<T1>(&v0)
    }

    // decompiled from Move bytecode v6
}


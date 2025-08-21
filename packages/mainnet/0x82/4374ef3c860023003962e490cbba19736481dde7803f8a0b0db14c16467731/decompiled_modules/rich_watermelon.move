module 0x824374ef3c860023003962e490cbba19736481dde7803f8a0b0db14c16467731::rich_watermelon {
    struct RICH_WATERMELON has drop {
        dummy_field: bool,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        name_1: 0x1::string::String,
        name_2: 0x1::string::String,
        amount_1: vector<u64>,
        amount_2: vector<u64>,
        balance_bag: 0x2::bag::Bag,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun create_nft_with_verification<T0, T1>(arg0: &mut Store, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(!0x1::vector::is_empty<u64>(&arg0.amount_1), 6);
        let v0 = 0x1::vector::pop_back<u64>(&mut arg0.amount_1);
        let v1 = 0x1::vector::pop_back<u64>(&mut arg0.amount_2);
        0x1::vector::push_back<0x1::string::String>(&mut arg4, arg0.name_1);
        0x1::vector::push_back<0x1::string::String>(&mut arg4, arg0.name_2);
        0x1::vector::push_back<0x1::string::String>(&mut arg5, 0x1::u64::to_string(v0));
        0x1::vector::push_back<0x1::string::String>(&mut arg5, 0x1::u64::to_string(v1));
        let v2 = Nft{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            media_url   : arg3,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5),
        };
        0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::set_verification_nft_id(arg6, 0x2::object::id<Nft>(&v2));
        let v3 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut v2.id, v3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, 1), v0), arg7));
        let v4 = BalanceKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::add<BalanceKey<T1>, 0x2::coin::Coin<T1>>(&mut v2.id, v4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.balance_bag, 2), v1), arg7));
        v2
    }

    fun init(arg0: RICH_WATERMELON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RICH_WATERMELON>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Rich WaterMelon"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Rich WaterMelon"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"walrus://vWqntYPXYPyKY-goys8b95Retm7bKuq-CpQBeKVLy04"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 500, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        let v6 = Store{
            id          : 0x2::object::new(arg1),
            version     : 1,
            admin       : 0x2::tx_context::sender(arg1),
            name_1      : 0x1::string::utf8(b"Balance_Coin_1"),
            name_2      : 0x1::string::utf8(b"Balance_Coin_2"),
            amount_1    : 0x1::vector::empty<u64>(),
            amount_2    : 0x1::vector::empty<u64>(),
            balance_bag : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<Store>(v6);
    }

    public fun offload<T0, T1>(arg0: &mut Store, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        verify_admin(arg0, arg1);
        verify_version(arg0);
        while (!0x1::vector::is_empty<u64>(&arg0.amount_1)) {
            0x1::vector::pop_back<u64>(&mut arg0.amount_1);
            0x1::vector::pop_back<u64>(&mut arg0.amount_2);
        };
        (0x2::coin::from_balance<T0>(0x2::bag::remove<u64, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, 1), arg1), 0x2::coin::from_balance<T1>(0x2::bag::remove<u64, 0x2::balance::Balance<T1>>(&mut arg0.balance_bag, 2), arg1))
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        verify_version(arg0);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun update_nft_with_verification(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::get_verification_nft_id(arg6) == arg0, 1);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
    }

    public fun upload<T0, T1>(arg0: &mut Store, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg7);
        verify_version(arg0);
        arg0.name_1 = arg1;
        arg0.name_2 = arg2;
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 3);
        let v0 = 0;
        let v1 = 0;
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v3 = 0x1::vector::pop_back<u64>(&mut arg4);
            0x1::vector::push_back<u64>(&mut arg0.amount_1, v2);
            0x1::vector::push_back<u64>(&mut arg0.amount_2, v3);
            v0 = v0 + v2;
            v1 = v1 + v3;
        };
        assert!(v0 == 0x2::coin::value<T0>(&arg5), 4);
        assert!(v1 == 0x2::coin::value<T1>(&arg6), 5);
        let v4 = if (0x2::bag::contains<u64>(&arg0.balance_bag, 1)) {
            0x2::bag::remove<u64, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, 1)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = v4;
        let v6 = if (0x2::bag::contains<u64>(&arg0.balance_bag, 2)) {
            0x2::bag::remove<u64, 0x2::balance::Balance<T1>>(&mut arg0.balance_bag, 2)
        } else {
            0x2::balance::zero<T1>()
        };
        let v7 = v6;
        0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(arg5));
        0x2::balance::join<T1>(&mut v7, 0x2::coin::into_balance<T1>(arg6));
        0x2::bag::add<u64, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, 1, v5);
        0x2::bag::add<u64, 0x2::balance::Balance<T1>>(&mut arg0.balance_bag, 2, v7);
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 2);
    }

    public fun withdraw_balance<T0, T1>(arg0: &Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg2, arg3, arg1);
        let v1 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&v0.id, v1), 7);
        let v2 = BalanceKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BalanceKey<T1>, 0x2::coin::Coin<T1>>(&v0.id, v2), 7);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.attributes, &arg0.name_1);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.attributes, &arg0.name_2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, arg0.name_1, 0x1::string::utf8(b"0"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, arg0.name_2, 0x1::string::utf8(b"0"));
        let v7 = BalanceKey<T0>{dummy_field: false};
        let v8 = BalanceKey<T1>{dummy_field: false};
        (0x2::dynamic_object_field::remove<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut v0.id, v7), 0x2::dynamic_object_field::remove<BalanceKey<T1>, 0x2::coin::Coin<T1>>(&mut v0.id, v8))
    }

    // decompiled from Move bytecode v6
}


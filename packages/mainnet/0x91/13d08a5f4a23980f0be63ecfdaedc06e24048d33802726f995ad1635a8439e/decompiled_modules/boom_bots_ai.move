module 0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai {
    struct BOOM_BOTS_AI has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun assert_slot(arg0: vector<u8>) {
        assert!(arg0 == b"weapon" || arg0 == b"armour", 11);
    }

    public fun attributes(arg0: &Nft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun clear_attribute(arg0: &mut Nft, arg1: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1);
        };
    }

    public fun create_nft_with_mutation_request(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : (Nft, 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::NftMutationRequest<Nft>) {
        let v0 = Nft{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        (v0, 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::create_nft_mutation_request<Nft>(0, 0x2::object::id<Nft>(&v0), arg0, arg1, arg2, arg3, arg4, 2))
    }

    public fun create_nft_with_verification(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        abort 1
    }

    public fun equip<T0: store + key>(arg0: &mut Nft, arg1: vector<u8>, arg2: 0x1::string::String, arg3: T0) {
        assert_slot(arg1);
        assert!(!0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1), 10);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg0.id, arg1, arg3);
        set_attribute(arg0, slot_attr_key(arg1), arg2);
    }

    public fun equip_in_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x1::string::String, arg5: T0) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg0, arg1, arg2);
        equip<T0>(v0, arg3, arg4, arg5);
    }

    public fun equipped_id<T0: store + key>(arg0: &Nft, arg1: vector<u8>) : 0x2::object::ID {
        0x2::object::id<T0>(0x2::dynamic_object_field::borrow<vector<u8>, T0>(&arg0.id, arg1))
    }

    public fun has_equipped(arg0: &Nft, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    fun init(arg0: BOOM_BOTS_AI, arg1: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun media_url(arg0: &Nft) : 0x1::string::String {
        arg0.media_url
    }

    public fun mint_edition_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &0x2::clock::Clock, arg3: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::kiosk::Kiosk, arg19: &0x2::kiosk::KioskOwnerCap, arg20: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_nft(arg0: &0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun mint_order(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::clock::Clock, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun name(arg0: &Nft) : 0x1::string::String {
        arg0.name
    }

    fun set_attribute(arg0: &mut Nft, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, arg1, arg2);
        };
    }

    fun slot_attr_key(arg0: vector<u8>) : 0x1::string::String {
        if (arg0 == b"weapon") {
            0x1::string::utf8(b"WEAPON")
        } else {
            0x1::string::utf8(b"ARMOUR")
        }
    }

    public fun unequip<T0: store + key>(arg0: &mut Nft, arg1: vector<u8>) : T0 {
        assert_slot(arg1);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1), 12);
        clear_attribute(arg0, slot_attr_key(arg1));
        0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, arg1)
    }

    public fun unequip_in_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(unequip<T0>(v0, arg3), 0x2::tx_context::sender(arg4));
    }

    public fun update_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun update_nft_with_mutation_request(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap) : 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::NftMutationRequest<Nft> {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg6, arg7, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
        0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::create_nft_mutation_request<Nft>(1, arg0, arg1, arg2, arg3, arg4, arg5, 2)
    }

    public fun update_nft_with_verification(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap) {
        abort 1
    }

    // decompiled from Move bytecode v7
}


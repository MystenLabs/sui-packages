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

    struct CoreApplied has copy, drop {
        bot_id: 0x2::object::ID,
        core_id: 0x2::object::ID,
        serial: u64,
        armour: u64,
        speed: u64,
        agility: u64,
        cores: u64,
    }

    struct CoreVoucher has key {
        id: 0x2::object::UID,
        bot_id: 0x2::object::ID,
        core_id: 0x2::object::ID,
        serial: u64,
    }

    struct CoreVoucherIssued has copy, drop {
        voucher_id: 0x2::object::ID,
        bot_id: 0x2::object::ID,
        serial: u64,
        recipient: address,
    }

    fun apply_core(arg0: &mut Nft, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = attr_u64_or_zero(arg0, b"PRIME CORES");
        assert!(v0 < 2, 20);
        let v1 = bump(arg0, b"ARMOUR");
        let v2 = bump(arg0, b"SPEED");
        let v3 = bump(arg0, b"AGILITY");
        let v4 = v0 + 1;
        set_attribute(arg0, 0x1::string::utf8(b"PRIME CORES"), 0x1::u64::to_string(v4));
        let v5 = CoreApplied{
            bot_id  : 0x2::object::id<Nft>(arg0),
            core_id : arg1,
            serial  : arg2,
            armour  : v1,
            speed   : v2,
            agility : v3,
            cores   : v4,
        };
        0x2::event::emit<CoreApplied>(v5);
    }

    public fun apply_core_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::UpgradeReceipt) {
        let (v0, v1, v2, _) = 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::consume_upgrade_receipt(arg3);
        assert!(v2 == arg2, 21);
        let v4 = 0x2::kiosk::borrow_mut<Nft>(arg0, arg1, arg2);
        apply_core(v4, v0, v1);
    }

    public fun apply_core_owned(arg0: &mut Nft, arg1: 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::UpgradeReceipt) {
        let (v0, v1, v2, _) = 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::consume_upgrade_receipt(arg1);
        assert!(v2 == 0x2::object::id<Nft>(arg0), 21);
        apply_core(arg0, v0, v1);
    }

    public fun apply_core_voucher_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: CoreVoucher) {
        let CoreVoucher {
            id      : v0,
            bot_id  : v1,
            core_id : v2,
            serial  : v3,
        } = arg2;
        0x2::object::delete(v0);
        let v4 = 0x2::kiosk::borrow_mut<Nft>(arg0, arg1, v1);
        apply_core(v4, v2, v3);
    }

    public fun apply_core_voucher_owned(arg0: &mut Nft, arg1: CoreVoucher) {
        let CoreVoucher {
            id      : v0,
            bot_id  : v1,
            core_id : v2,
            serial  : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::id<Nft>(arg0), 21);
        apply_core(arg0, v2, v3);
    }

    fun assert_slot(arg0: vector<u8>) {
        assert!(arg0 == b"weapon" || arg0 == b"armour", 11);
    }

    fun attr_u64(arg0: &Nft, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0), 23);
        parse_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
    }

    fun attr_u64_or_zero(arg0: &Nft, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            parse_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0))
        } else {
            0
        }
    }

    public fun attributes(arg0: &Nft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun bump(arg0: &mut Nft, arg1: vector<u8>) : u64 {
        let v0 = attr_u64(arg0, arg1) + 1;
        set_attribute(arg0, 0x1::string::utf8(arg1), 0x1::u64::to_string(v0));
        v0
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

    public fun issue_core_voucher(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Nft>(arg0), 22);
        let v0 = CoreVoucher{
            id      : 0x2::object::new(arg5),
            bot_id  : arg1,
            core_id : arg2,
            serial  : arg3,
        };
        let v1 = CoreVoucherIssued{
            voucher_id : 0x2::object::id<CoreVoucher>(&v0),
            bot_id     : arg1,
            serial     : arg3,
            recipient  : arg4,
        };
        0x2::event::emit<CoreVoucherIssued>(v1);
        0x2::transfer::transfer<CoreVoucher>(v0, arg4);
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

    fun parse_u64(arg0: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 > 0, 24);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v2);
            assert!(v4 >= 48 && v4 <= 57, 24);
            let v5 = v3 * 10;
            v3 = v5 + ((v4 - 48) as u64);
            v2 = v2 + 1;
        };
        v3
    }

    public fun prime_cores(arg0: &Nft) : u64 {
        attr_u64_or_zero(arg0, b"PRIME CORES")
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


module 0xec098cbd29043599a3f48357b3cfd2960b35723ff996848820fce56c626b571f::equipment {
    struct EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct EquipmentCatalog has key {
        id: 0x2::object::UID,
        version: u64,
        types: 0x2::table::Table<0x2::object::ID, EquipmentType>,
    }

    struct EquipmentType has store {
        equipment_id: u64,
        weapon_type: 0x1::string::String,
        is_support: bool,
        damage: u64,
        hit_chance_bps: u64,
        critical_chance_bps: u64,
        consumption_rate: u64,
        dura_ammo: u64,
        number_of_hits: u64,
        mastery_required: u64,
        cooldown_factor: u64,
    }

    public fun create_type(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<EQUIPMENT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<EQUIPMENT>, arg2: &mut EquipmentCatalog, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: 0x1::string::String, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg2);
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<EQUIPMENT>(arg0, arg1, arg3, arg4, arg5, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg6, arg18);
        let v1 = EquipmentType{
            equipment_id        : arg7,
            weapon_type         : arg8,
            is_support          : arg9,
            damage              : arg10,
            hit_chance_bps      : arg11,
            critical_chance_bps : arg12,
            consumption_rate    : arg13,
            dura_ammo           : arg14,
            number_of_hits      : arg15,
            mastery_required    : arg16,
            cooldown_factor     : arg17,
        };
        0x2::table::add<0x2::object::ID, EquipmentType>(&mut arg2.types, v0, v1);
        v0
    }

    fun assert_version(arg0: &EquipmentCatalog) {
        assert!(arg0.version == 1, 13906834509350830081);
    }

    public fun consumption_rate(arg0: &EquipmentType) : u64 {
        arg0.consumption_rate
    }

    public fun cooldown_factor(arg0: &EquipmentType) : u64 {
        arg0.cooldown_factor
    }

    public fun critical_chance_bps(arg0: &EquipmentType) : u64 {
        arg0.critical_chance_bps
    }

    public fun damage(arg0: &EquipmentType) : u64 {
        arg0.damage
    }

    public fun dura_ammo(arg0: &EquipmentType) : u64 {
        arg0.dura_ammo
    }

    public fun equipment_id(arg0: &EquipmentType) : u64 {
        arg0.equipment_id
    }

    public fun equipment_type(arg0: &EquipmentCatalog, arg1: 0x2::object::ID) : &EquipmentType {
        0x2::table::borrow<0x2::object::ID, EquipmentType>(&arg0.types, arg1)
    }

    public fun has_equipment_type(arg0: &EquipmentCatalog, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, EquipmentType>(&arg0.types, arg1)
    }

    public fun hit_chance_bps(arg0: &EquipmentType) : u64 {
        arg0.hit_chance_bps
    }

    fun init(arg0: EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<EQUIPMENT>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<EQUIPMENT>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<EQUIPMENT>(&arg0, arg1);
        let v1 = EquipmentCatalog{
            id      : 0x2::object::new(arg1),
            version : 1,
            types   : 0x2::table::new<0x2::object::ID, EquipmentType>(arg1),
        };
        0x2::transfer::share_object<EquipmentCatalog>(v1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<EQUIPMENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<EQUIPMENT>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<EQUIPMENT>(&v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::BurnerCap<EQUIPMENT>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_burner<EQUIPMENT>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_support(arg0: &EquipmentType) : bool {
        arg0.is_support
    }

    public fun mastery_required(arg0: &EquipmentType) : u64 {
        arg0.mastery_required
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<EQUIPMENT>, arg1: &mut EquipmentCatalog) {
        assert!(arg1.version < 1, 13906834535120764931);
        arg1.version = 1;
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<EQUIPMENT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<EQUIPMENT>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<EQUIPMENT>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<EQUIPMENT>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<EQUIPMENT>(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    public fun number_of_hits(arg0: &EquipmentType) : u64 {
        arg0.number_of_hits
    }

    public fun version(arg0: &EquipmentCatalog) : u64 {
        arg0.version
    }

    public fun weapon_type(arg0: &EquipmentType) : 0x1::string::String {
        arg0.weapon_type
    }

    // decompiled from Move bytecode v7
}


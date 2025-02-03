module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SlotNumberTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<u8, 0x2::object::ID>,
    }

    struct SlotNumberTableCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct Slot has key {
        id: 0x2::object::UID,
        slot_number: u8,
        version: u64,
        schema_version: u64,
        admin_cap: 0x2::object::ID,
        genesis_timestamp: u64,
        slot_max_amount: u64,
        minted_amount: u64,
        round: u64,
        qualified_round: u64,
        qualified_inscription_id: 0x2::object::ID,
        qualified_hash: vector<u8>,
        qualified_timestamp: u64,
        qualified_difference: u64,
        candidate_inscription_id: 0x2::object::ID,
        candidate_hash: vector<u8>,
        candidate_inscriber: address,
        candidate_timestamp: u64,
        candidate_amount: u64,
        candidate_nonce: u128,
        candidate_difference: u64,
        candidate_content: 0x1::string::String,
    }

    struct SlotCreated has copy, drop {
        id: 0x1::option::Option<0x2::object::ID>,
        slot_number: u8,
        genesis_timestamp: u64,
        slot_max_amount: u64,
    }

    struct CandidateInscriptionPutUpV2 has copy, drop {
        id: 0x2::object::ID,
        slot_number: u8,
        version: u64,
        candidate_inscription_id: 0x2::object::ID,
        round: u64,
        candidate_hash: vector<u8>,
        candidate_inscriber: address,
        candidate_timestamp: u64,
        candidate_amount: u64,
        candidate_nonce: u128,
        candidate_difference: u64,
        candidate_content: 0x1::string::String,
        successful: bool,
    }

    struct CandidateInscriptionPutUp has copy, drop {
        id: 0x2::object::ID,
        slot_number: u8,
        version: u64,
        candidate_inscription_id: 0x2::object::ID,
        round: u64,
        candidate_hash: vector<u8>,
        candidate_inscriber: address,
        candidate_timestamp: u64,
        candidate_amount: u64,
        candidate_nonce: u128,
        candidate_difference: u64,
        candidate_content: 0x1::string::String,
    }

    struct SlotAdvanced has copy, drop {
        id: 0x2::object::ID,
        slot_number: u8,
        version: u64,
        round: u64,
    }

    public fun id(arg0: &Slot) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun freeze_object(arg0: Slot) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::freeze_object<Slot>(arg0);
    }

    public(friend) fun share_object(arg0: Slot) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::share_object<Slot>(arg0);
    }

    public fun admin_cap(arg0: &Slot) : 0x2::object::ID {
        arg0.admin_cap
    }

    public fun assert_schema_version(arg0: &Slot) {
        assert!(arg0.schema_version == 0, 2);
    }

    public(friend) fun asset_slot_number_not_exists(arg0: u8, arg1: &SlotNumberTable) {
        assert!(!0x2::table::contains<u8, 0x2::object::ID>(&arg1.table, arg0), 101);
    }

    fun asset_slot_number_not_exists_then_add(arg0: u8, arg1: &mut SlotNumberTable, arg2: 0x2::object::ID) {
        asset_slot_number_not_exists(arg0, arg1);
        0x2::table::add<u8, 0x2::object::ID>(&mut arg1.table, arg0, arg2);
    }

    public fun asssert_schema_version(arg0: &Slot) {
        assert_schema_version(arg0);
    }

    public fun candidate_amount(arg0: &Slot) : u64 {
        arg0.candidate_amount
    }

    public fun candidate_content(arg0: &Slot) : 0x1::string::String {
        arg0.candidate_content
    }

    public fun candidate_difference(arg0: &Slot) : u64 {
        arg0.candidate_difference
    }

    public fun candidate_hash(arg0: &Slot) : vector<u8> {
        arg0.candidate_hash
    }

    public fun candidate_inscriber(arg0: &Slot) : address {
        arg0.candidate_inscriber
    }

    public fun candidate_inscription_id(arg0: &Slot) : 0x2::object::ID {
        arg0.candidate_inscription_id
    }

    public fun candidate_inscription_put_up_candidate_amount(arg0: &CandidateInscriptionPutUp) : u64 {
        arg0.candidate_amount
    }

    public fun candidate_inscription_put_up_candidate_content(arg0: &CandidateInscriptionPutUp) : 0x1::string::String {
        arg0.candidate_content
    }

    public fun candidate_inscription_put_up_candidate_difference(arg0: &CandidateInscriptionPutUp) : u64 {
        arg0.candidate_difference
    }

    public fun candidate_inscription_put_up_candidate_hash(arg0: &CandidateInscriptionPutUp) : vector<u8> {
        arg0.candidate_hash
    }

    public fun candidate_inscription_put_up_candidate_inscriber(arg0: &CandidateInscriptionPutUp) : address {
        arg0.candidate_inscriber
    }

    public fun candidate_inscription_put_up_candidate_inscription_id(arg0: &CandidateInscriptionPutUp) : 0x2::object::ID {
        arg0.candidate_inscription_id
    }

    public fun candidate_inscription_put_up_candidate_nonce(arg0: &CandidateInscriptionPutUp) : u128 {
        arg0.candidate_nonce
    }

    public fun candidate_inscription_put_up_candidate_timestamp(arg0: &CandidateInscriptionPutUp) : u64 {
        arg0.candidate_timestamp
    }

    public fun candidate_inscription_put_up_id(arg0: &CandidateInscriptionPutUp) : 0x2::object::ID {
        arg0.id
    }

    public fun candidate_inscription_put_up_round(arg0: &CandidateInscriptionPutUp) : u64 {
        arg0.round
    }

    public fun candidate_inscription_put_up_slot_number(arg0: &CandidateInscriptionPutUp) : u8 {
        arg0.slot_number
    }

    public fun candidate_inscription_put_up_v2_candidate_amount(arg0: &CandidateInscriptionPutUpV2) : u64 {
        arg0.candidate_amount
    }

    public fun candidate_inscription_put_up_v2_candidate_content(arg0: &CandidateInscriptionPutUpV2) : 0x1::string::String {
        arg0.candidate_content
    }

    public fun candidate_inscription_put_up_v2_candidate_difference(arg0: &CandidateInscriptionPutUpV2) : u64 {
        arg0.candidate_difference
    }

    public fun candidate_inscription_put_up_v2_candidate_hash(arg0: &CandidateInscriptionPutUpV2) : vector<u8> {
        arg0.candidate_hash
    }

    public fun candidate_inscription_put_up_v2_candidate_inscriber(arg0: &CandidateInscriptionPutUpV2) : address {
        arg0.candidate_inscriber
    }

    public fun candidate_inscription_put_up_v2_candidate_inscription_id(arg0: &CandidateInscriptionPutUpV2) : 0x2::object::ID {
        arg0.candidate_inscription_id
    }

    public fun candidate_inscription_put_up_v2_candidate_nonce(arg0: &CandidateInscriptionPutUpV2) : u128 {
        arg0.candidate_nonce
    }

    public fun candidate_inscription_put_up_v2_candidate_timestamp(arg0: &CandidateInscriptionPutUpV2) : u64 {
        arg0.candidate_timestamp
    }

    public fun candidate_inscription_put_up_v2_id(arg0: &CandidateInscriptionPutUpV2) : 0x2::object::ID {
        arg0.id
    }

    public fun candidate_inscription_put_up_v2_round(arg0: &CandidateInscriptionPutUpV2) : u64 {
        arg0.round
    }

    public fun candidate_inscription_put_up_v2_slot_number(arg0: &CandidateInscriptionPutUpV2) : u8 {
        arg0.slot_number
    }

    public fun candidate_inscription_put_up_v2_successful(arg0: &CandidateInscriptionPutUpV2) : bool {
        arg0.successful
    }

    public fun candidate_nonce(arg0: &Slot) : u128 {
        arg0.candidate_nonce
    }

    public fun candidate_timestamp(arg0: &Slot) : u64 {
        arg0.candidate_timestamp
    }

    public(friend) fun create_slot(arg0: u8, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: address, arg10: u64, arg11: u64, arg12: u128, arg13: u64, arg14: 0x1::string::String, arg15: &mut SlotNumberTable, arg16: &mut 0x2::tx_context::TxContext) : Slot {
        let v0 = new_slot(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg16);
        asset_slot_number_not_exists_then_add(arg0, arg15, 0x2::object::uid_to_inner(&v0.id));
        v0
    }

    public(friend) fun drop_slot(arg0: Slot) {
        let Slot {
            id                       : v0,
            slot_number              : _,
            version                  : _,
            schema_version           : _,
            admin_cap                : _,
            genesis_timestamp        : _,
            slot_max_amount          : _,
            minted_amount            : _,
            round                    : _,
            qualified_round          : _,
            qualified_inscription_id : _,
            qualified_hash           : _,
            qualified_timestamp      : _,
            qualified_difference     : _,
            candidate_inscription_id : _,
            candidate_hash           : _,
            candidate_inscriber      : _,
            candidate_timestamp      : _,
            candidate_amount         : _,
            candidate_nonce          : _,
            candidate_difference     : _,
            candidate_content        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun emit_candidate_inscription_put_up(arg0: CandidateInscriptionPutUp) {
        0x2::event::emit<CandidateInscriptionPutUp>(arg0);
    }

    public(friend) fun emit_candidate_inscription_put_up_v2(arg0: CandidateInscriptionPutUpV2) {
        0x2::event::emit<CandidateInscriptionPutUpV2>(arg0);
    }

    public(friend) fun emit_slot_advanced(arg0: SlotAdvanced) {
        0x2::event::emit<SlotAdvanced>(arg0);
    }

    public(friend) fun emit_slot_created(arg0: SlotCreated) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.id), 107);
        0x2::event::emit<SlotCreated>(arg0);
    }

    public fun genesis_timestamp(arg0: &Slot) : u64 {
        arg0.genesis_timestamp
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotNumberTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<u8, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SlotNumberTable>(v0);
        let v1 = SlotNumberTableCreated{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<SlotNumberTableCreated>(v1);
    }

    entry fun migrate(arg0: &mut Slot, arg1: &AdminCap) {
        assert!(arg0.admin_cap == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.schema_version < 0, 1);
        arg0.schema_version = 0;
    }

    public fun minted_amount(arg0: &Slot) : u64 {
        arg0.minted_amount
    }

    public(friend) fun new_candidate_inscription_put_up(arg0: &Slot, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: 0x1::string::String) : CandidateInscriptionPutUp {
        CandidateInscriptionPutUp{
            id                       : id(arg0),
            slot_number              : slot_number(arg0),
            version                  : version(arg0),
            candidate_inscription_id : arg1,
            round                    : arg2,
            candidate_hash           : arg3,
            candidate_inscriber      : arg4,
            candidate_timestamp      : arg5,
            candidate_amount         : arg6,
            candidate_nonce          : arg7,
            candidate_difference     : arg8,
            candidate_content        : arg9,
        }
    }

    public(friend) fun new_candidate_inscription_put_up_v2(arg0: &Slot, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: 0x1::string::String, arg10: bool) : CandidateInscriptionPutUpV2 {
        CandidateInscriptionPutUpV2{
            id                       : id(arg0),
            slot_number              : slot_number(arg0),
            version                  : version(arg0),
            candidate_inscription_id : arg1,
            round                    : arg2,
            candidate_hash           : arg3,
            candidate_inscriber      : arg4,
            candidate_timestamp      : arg5,
            candidate_amount         : arg6,
            candidate_nonce          : arg7,
            candidate_difference     : arg8,
            candidate_content        : arg9,
            successful               : arg10,
        }
    }

    fun new_slot(arg0: u8, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: address, arg10: u64, arg11: u64, arg12: u128, arg13: u64, arg14: 0x1::string::String, arg15: &mut 0x2::tx_context::TxContext) : Slot {
        assert!(0x1::string::length(&arg14) <= 1000, 102);
        let v0 = AdminCap{id: 0x2::object::new(arg15)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg15));
        Slot{
            id                       : 0x2::object::new(arg15),
            slot_number              : arg0,
            version                  : 0,
            schema_version           : 0,
            admin_cap                : 0x2::object::id<AdminCap>(&v0),
            genesis_timestamp        : arg1,
            slot_max_amount          : arg2,
            minted_amount            : 0,
            round                    : 0,
            qualified_round          : 0,
            qualified_inscription_id : arg3,
            qualified_hash           : arg4,
            qualified_timestamp      : arg5,
            qualified_difference     : arg6,
            candidate_inscription_id : arg7,
            candidate_hash           : arg8,
            candidate_inscriber      : arg9,
            candidate_timestamp      : arg10,
            candidate_amount         : arg11,
            candidate_nonce          : arg12,
            candidate_difference     : arg13,
            candidate_content        : arg14,
        }
    }

    public(friend) fun new_slot_advanced(arg0: &Slot, arg1: u64) : SlotAdvanced {
        SlotAdvanced{
            id          : id(arg0),
            slot_number : slot_number(arg0),
            version     : version(arg0),
            round       : arg1,
        }
    }

    public(friend) fun new_slot_created(arg0: u8, arg1: u64, arg2: u64) : SlotCreated {
        SlotCreated{
            id                : 0x1::option::none<0x2::object::ID>(),
            slot_number       : arg0,
            genesis_timestamp : arg1,
            slot_max_amount   : arg2,
        }
    }

    public fun qualified_difference(arg0: &Slot) : u64 {
        arg0.qualified_difference
    }

    public fun qualified_hash(arg0: &Slot) : vector<u8> {
        arg0.qualified_hash
    }

    public fun qualified_inscription_id(arg0: &Slot) : 0x2::object::ID {
        arg0.qualified_inscription_id
    }

    public fun qualified_round(arg0: &Slot) : u64 {
        arg0.qualified_round
    }

    public fun qualified_timestamp(arg0: &Slot) : u64 {
        arg0.qualified_timestamp
    }

    public fun round(arg0: &Slot) : u64 {
        arg0.round
    }

    public(friend) fun set_candidate_amount(arg0: &mut Slot, arg1: u64) {
        arg0.candidate_amount = arg1;
    }

    public(friend) fun set_candidate_content(arg0: &mut Slot, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 1000, 102);
        arg0.candidate_content = arg1;
    }

    public(friend) fun set_candidate_difference(arg0: &mut Slot, arg1: u64) {
        arg0.candidate_difference = arg1;
    }

    public(friend) fun set_candidate_hash(arg0: &mut Slot, arg1: vector<u8>) {
        arg0.candidate_hash = arg1;
    }

    public(friend) fun set_candidate_inscriber(arg0: &mut Slot, arg1: address) {
        arg0.candidate_inscriber = arg1;
    }

    public(friend) fun set_candidate_inscription_id(arg0: &mut Slot, arg1: 0x2::object::ID) {
        arg0.candidate_inscription_id = arg1;
    }

    public(friend) fun set_candidate_nonce(arg0: &mut Slot, arg1: u128) {
        arg0.candidate_nonce = arg1;
    }

    public(friend) fun set_candidate_timestamp(arg0: &mut Slot, arg1: u64) {
        arg0.candidate_timestamp = arg1;
    }

    public(friend) fun set_genesis_timestamp(arg0: &mut Slot, arg1: u64) {
        arg0.genesis_timestamp = arg1;
    }

    public(friend) fun set_minted_amount(arg0: &mut Slot, arg1: u64) {
        arg0.minted_amount = arg1;
    }

    public(friend) fun set_qualified_difference(arg0: &mut Slot, arg1: u64) {
        arg0.qualified_difference = arg1;
    }

    public(friend) fun set_qualified_hash(arg0: &mut Slot, arg1: vector<u8>) {
        arg0.qualified_hash = arg1;
    }

    public(friend) fun set_qualified_inscription_id(arg0: &mut Slot, arg1: 0x2::object::ID) {
        arg0.qualified_inscription_id = arg1;
    }

    public(friend) fun set_qualified_round(arg0: &mut Slot, arg1: u64) {
        arg0.qualified_round = arg1;
    }

    public(friend) fun set_qualified_timestamp(arg0: &mut Slot, arg1: u64) {
        arg0.qualified_timestamp = arg1;
    }

    public(friend) fun set_round(arg0: &mut Slot, arg1: u64) {
        arg0.round = arg1;
    }

    public(friend) fun set_slot_created_id(arg0: &mut SlotCreated, arg1: 0x2::object::ID) {
        arg0.id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_slot_max_amount(arg0: &mut Slot, arg1: u64) {
        arg0.slot_max_amount = arg1;
    }

    public fun slot_advanced_id(arg0: &SlotAdvanced) : 0x2::object::ID {
        arg0.id
    }

    public fun slot_advanced_round(arg0: &SlotAdvanced) : u64 {
        arg0.round
    }

    public fun slot_advanced_slot_number(arg0: &SlotAdvanced) : u8 {
        arg0.slot_number
    }

    public fun slot_created_genesis_timestamp(arg0: &SlotCreated) : u64 {
        arg0.genesis_timestamp
    }

    public fun slot_created_id(arg0: &SlotCreated) : 0x1::option::Option<0x2::object::ID> {
        arg0.id
    }

    public fun slot_created_slot_max_amount(arg0: &SlotCreated) : u64 {
        arg0.slot_max_amount
    }

    public fun slot_created_slot_number(arg0: &SlotCreated) : u8 {
        arg0.slot_number
    }

    public fun slot_max_amount(arg0: &Slot) : u64 {
        arg0.slot_max_amount
    }

    public fun slot_number(arg0: &Slot) : u8 {
        arg0.slot_number
    }

    public(friend) fun transfer_object(arg0: Slot, arg1: address) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::transfer<Slot>(arg0, arg1);
    }

    public(friend) fun update_object_version(arg0: &mut Slot) {
        arg0.version = arg0.version + 1;
    }

    public(friend) fun update_version_and_freeze_object(arg0: Slot) {
        let v0 = &mut arg0;
        update_object_version(v0);
        0x2::transfer::freeze_object<Slot>(arg0);
    }

    public(friend) fun update_version_and_transfer_object(arg0: Slot, arg1: address) {
        let v0 = &mut arg0;
        update_object_version(v0);
        0x2::transfer::transfer<Slot>(arg0, arg1);
    }

    public fun version(arg0: &Slot) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}


module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription {
    struct Inscription has store, key {
        id: 0x2::object::UID,
        version: u64,
        hash: vector<u8>,
        slot_number: u8,
        round: u64,
        inscriber: address,
        timestamp: u64,
        amount: u64,
        nonce: u128,
        content: 0x1::string::String,
    }

    struct InscriptionMinted has copy, drop {
        id: 0x1::option::Option<0x2::object::ID>,
        slot_number: u8,
        round: u64,
        amount: u64,
        nonce: u128,
        content: 0x1::string::String,
        inscriber: address,
        timestamp: u64,
        hash: vector<u8>,
    }

    struct InscriptionDeleted has copy, drop {
        id: 0x2::object::ID,
        version: u64,
    }

    public(friend) fun freeze_object(arg0: Inscription) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::freeze_object<Inscription>(arg0);
    }

    public(friend) fun share_object(arg0: Inscription) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::share_object<Inscription>(arg0);
    }

    public fun amount(arg0: &Inscription) : u64 {
        arg0.amount
    }

    public fun content(arg0: &Inscription) : 0x1::string::String {
        arg0.content
    }

    public(friend) fun drop_inscription(arg0: Inscription) {
        let Inscription {
            id          : v0,
            version     : _,
            hash        : _,
            slot_number : _,
            round       : _,
            inscriber   : _,
            timestamp   : _,
            amount      : _,
            nonce       : _,
            content     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun emit_inscription_deleted(arg0: InscriptionDeleted) {
        0x2::event::emit<InscriptionDeleted>(arg0);
    }

    public(friend) fun emit_inscription_minted(arg0: InscriptionMinted) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.id), 107);
        0x2::event::emit<InscriptionMinted>(arg0);
    }

    public fun hash(arg0: &Inscription) : vector<u8> {
        arg0.hash
    }

    public fun id(arg0: &Inscription) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun inscriber(arg0: &Inscription) : address {
        arg0.inscriber
    }

    public fun inscription_deleted_id(arg0: &InscriptionDeleted) : 0x2::object::ID {
        arg0.id
    }

    public fun inscription_minted_amount(arg0: &InscriptionMinted) : u64 {
        arg0.amount
    }

    public fun inscription_minted_content(arg0: &InscriptionMinted) : 0x1::string::String {
        arg0.content
    }

    public fun inscription_minted_hash(arg0: &InscriptionMinted) : vector<u8> {
        arg0.hash
    }

    public fun inscription_minted_id(arg0: &InscriptionMinted) : 0x1::option::Option<0x2::object::ID> {
        arg0.id
    }

    public fun inscription_minted_inscriber(arg0: &InscriptionMinted) : address {
        arg0.inscriber
    }

    public fun inscription_minted_nonce(arg0: &InscriptionMinted) : u128 {
        arg0.nonce
    }

    public fun inscription_minted_round(arg0: &InscriptionMinted) : u64 {
        arg0.round
    }

    public fun inscription_minted_slot_number(arg0: &InscriptionMinted) : u8 {
        arg0.slot_number
    }

    public fun inscription_minted_timestamp(arg0: &InscriptionMinted) : u64 {
        arg0.timestamp
    }

    public(friend) fun new_inscription(arg0: vector<u8>, arg1: u8, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u128, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : Inscription {
        assert!(0x1::string::length(&arg7) <= 1000, 102);
        Inscription{
            id          : 0x2::object::new(arg8),
            version     : 0,
            hash        : arg0,
            slot_number : arg1,
            round       : arg2,
            inscriber   : arg3,
            timestamp   : arg4,
            amount      : arg5,
            nonce       : arg6,
            content     : arg7,
        }
    }

    public(friend) fun new_inscription_deleted(arg0: &Inscription) : InscriptionDeleted {
        InscriptionDeleted{
            id      : id(arg0),
            version : version(arg0),
        }
    }

    public(friend) fun new_inscription_minted(arg0: u8, arg1: u64, arg2: u64, arg3: u128, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: vector<u8>) : InscriptionMinted {
        InscriptionMinted{
            id          : 0x1::option::none<0x2::object::ID>(),
            slot_number : arg0,
            round       : arg1,
            amount      : arg2,
            nonce       : arg3,
            content     : arg4,
            inscriber   : arg5,
            timestamp   : arg6,
            hash        : arg7,
        }
    }

    public fun nonce(arg0: &Inscription) : u128 {
        arg0.nonce
    }

    public fun round(arg0: &Inscription) : u64 {
        arg0.round
    }

    public(friend) fun set_amount(arg0: &mut Inscription, arg1: u64) {
        arg0.amount = arg1;
    }

    public(friend) fun set_content(arg0: &mut Inscription, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 1000, 102);
        arg0.content = arg1;
    }

    public(friend) fun set_hash(arg0: &mut Inscription, arg1: vector<u8>) {
        arg0.hash = arg1;
    }

    public(friend) fun set_inscriber(arg0: &mut Inscription, arg1: address) {
        arg0.inscriber = arg1;
    }

    public(friend) fun set_inscription_minted_id(arg0: &mut InscriptionMinted, arg1: 0x2::object::ID) {
        arg0.id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_nonce(arg0: &mut Inscription, arg1: u128) {
        arg0.nonce = arg1;
    }

    public(friend) fun set_round(arg0: &mut Inscription, arg1: u64) {
        arg0.round = arg1;
    }

    public(friend) fun set_slot_number(arg0: &mut Inscription, arg1: u8) {
        arg0.slot_number = arg1;
    }

    public(friend) fun set_timestamp(arg0: &mut Inscription, arg1: u64) {
        arg0.timestamp = arg1;
    }

    public fun slot_number(arg0: &Inscription) : u8 {
        arg0.slot_number
    }

    public fun timestamp(arg0: &Inscription) : u64 {
        arg0.timestamp
    }

    public(friend) fun transfer_object(arg0: Inscription, arg1: address) {
        assert!(arg0.version == 0, 103);
        0x2::transfer::transfer<Inscription>(arg0, arg1);
    }

    fun update_object_version(arg0: &mut Inscription) {
        arg0.version = arg0.version + 1;
    }

    public(friend) fun update_version_and_freeze_object(arg0: Inscription) {
        let v0 = &mut arg0;
        update_object_version(v0);
        0x2::transfer::freeze_object<Inscription>(arg0);
    }

    public(friend) fun update_version_and_transfer_object(arg0: Inscription, arg1: address) {
        let v0 = &mut arg0;
        update_object_version(v0);
        0x2::transfer::transfer<Inscription>(arg0, arg1);
    }

    public fun version(arg0: &Inscription) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}


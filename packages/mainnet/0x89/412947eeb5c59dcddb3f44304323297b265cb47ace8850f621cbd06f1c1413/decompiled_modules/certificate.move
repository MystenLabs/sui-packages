module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate {
    struct Certificate has store, key {
        id: 0x2::object::UID,
        inscription_id: 0x2::object::ID,
        inscription_hash: vector<u8>,
        slot_number: u8,
        round: u64,
        inscriber: address,
        inscription_timestamp: u64,
        amount: u64,
        inscription_nonce: u128,
        inscription_content: 0x1::string::String,
    }

    struct CertificateIssued has copy, drop {
        id: 0x1::option::Option<0x2::object::ID>,
        inscription_id: 0x2::object::ID,
        inscription_hash: vector<u8>,
        slot_number: u8,
        round: u64,
        inscriber: address,
        inscription_timestamp: u64,
        amount: u64,
        inscription_nonce: u128,
        inscription_content: 0x1::string::String,
    }

    public(friend) fun freeze_object(arg0: Certificate) {
        0x2::transfer::freeze_object<Certificate>(arg0);
    }

    public(friend) fun share_object(arg0: Certificate) {
        0x2::transfer::share_object<Certificate>(arg0);
    }

    public fun amount(arg0: &Certificate) : u64 {
        arg0.amount
    }

    public fun certificate_issued_amount(arg0: &CertificateIssued) : u64 {
        arg0.amount
    }

    public fun certificate_issued_id(arg0: &CertificateIssued) : 0x1::option::Option<0x2::object::ID> {
        arg0.id
    }

    public fun certificate_issued_inscriber(arg0: &CertificateIssued) : address {
        arg0.inscriber
    }

    public fun certificate_issued_inscription_content(arg0: &CertificateIssued) : 0x1::string::String {
        arg0.inscription_content
    }

    public fun certificate_issued_inscription_hash(arg0: &CertificateIssued) : vector<u8> {
        arg0.inscription_hash
    }

    public fun certificate_issued_inscription_id(arg0: &CertificateIssued) : 0x2::object::ID {
        arg0.inscription_id
    }

    public fun certificate_issued_inscription_nonce(arg0: &CertificateIssued) : u128 {
        arg0.inscription_nonce
    }

    public fun certificate_issued_inscription_timestamp(arg0: &CertificateIssued) : u64 {
        arg0.inscription_timestamp
    }

    public fun certificate_issued_round(arg0: &CertificateIssued) : u64 {
        arg0.round
    }

    public fun certificate_issued_slot_number(arg0: &CertificateIssued) : u8 {
        arg0.slot_number
    }

    public(friend) fun drop_certificate(arg0: Certificate) {
        let Certificate {
            id                    : v0,
            inscription_id        : _,
            inscription_hash      : _,
            slot_number           : _,
            round                 : _,
            inscriber             : _,
            inscription_timestamp : _,
            amount                : _,
            inscription_nonce     : _,
            inscription_content   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun emit_certificate_issued(arg0: CertificateIssued) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.id), 107);
        0x2::event::emit<CertificateIssued>(arg0);
    }

    public fun id(arg0: &Certificate) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun inscriber(arg0: &Certificate) : address {
        arg0.inscriber
    }

    public fun inscription_content(arg0: &Certificate) : 0x1::string::String {
        arg0.inscription_content
    }

    public fun inscription_hash(arg0: &Certificate) : vector<u8> {
        arg0.inscription_hash
    }

    public fun inscription_id(arg0: &Certificate) : 0x2::object::ID {
        arg0.inscription_id
    }

    public fun inscription_nonce(arg0: &Certificate) : u128 {
        arg0.inscription_nonce
    }

    public fun inscription_timestamp(arg0: &Certificate) : u64 {
        arg0.inscription_timestamp
    }

    public(friend) fun new_certificate(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Certificate {
        assert!(0x1::string::length(&arg8) <= 1000, 102);
        Certificate{
            id                    : 0x2::object::new(arg9),
            inscription_id        : arg0,
            inscription_hash      : arg1,
            slot_number           : arg2,
            round                 : arg3,
            inscriber             : arg4,
            inscription_timestamp : arg5,
            amount                : arg6,
            inscription_nonce     : arg7,
            inscription_content   : arg8,
        }
    }

    public(friend) fun new_certificate_issued(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String) : CertificateIssued {
        CertificateIssued{
            id                    : 0x1::option::none<0x2::object::ID>(),
            inscription_id        : arg0,
            inscription_hash      : arg1,
            slot_number           : arg2,
            round                 : arg3,
            inscriber             : arg4,
            inscription_timestamp : arg5,
            amount                : arg6,
            inscription_nonce     : arg7,
            inscription_content   : arg8,
        }
    }

    public fun round(arg0: &Certificate) : u64 {
        arg0.round
    }

    public(friend) fun set_amount(arg0: &mut Certificate, arg1: u64) {
        arg0.amount = arg1;
    }

    public(friend) fun set_certificate_issued_id(arg0: &mut CertificateIssued, arg1: 0x2::object::ID) {
        arg0.id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_inscriber(arg0: &mut Certificate, arg1: address) {
        arg0.inscriber = arg1;
    }

    public(friend) fun set_inscription_content(arg0: &mut Certificate, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 1000, 102);
        arg0.inscription_content = arg1;
    }

    public(friend) fun set_inscription_hash(arg0: &mut Certificate, arg1: vector<u8>) {
        arg0.inscription_hash = arg1;
    }

    public(friend) fun set_inscription_id(arg0: &mut Certificate, arg1: 0x2::object::ID) {
        arg0.inscription_id = arg1;
    }

    public(friend) fun set_inscription_nonce(arg0: &mut Certificate, arg1: u128) {
        arg0.inscription_nonce = arg1;
    }

    public(friend) fun set_inscription_timestamp(arg0: &mut Certificate, arg1: u64) {
        arg0.inscription_timestamp = arg1;
    }

    public(friend) fun set_round(arg0: &mut Certificate, arg1: u64) {
        arg0.round = arg1;
    }

    public(friend) fun set_slot_number(arg0: &mut Certificate, arg1: u8) {
        arg0.slot_number = arg1;
    }

    public fun slot_number(arg0: &Certificate) : u8 {
        arg0.slot_number
    }

    public(friend) fun transfer_object(arg0: Certificate, arg1: address) {
        0x2::transfer::transfer<Certificate>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


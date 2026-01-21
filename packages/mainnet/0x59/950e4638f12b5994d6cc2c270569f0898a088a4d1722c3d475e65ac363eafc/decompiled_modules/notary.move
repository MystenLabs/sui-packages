module 0x28646b319cce050df680326445885aaae070d5a27f22bab903f6efbebace9bf::notary {
    struct Certificate has store, key {
        id: 0x2::object::UID,
        doc_hash: 0x1::string::String,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        doc_type: 0x1::string::String,
        description: 0x1::string::String,
        timestamp: u64,
        notarizer: address,
    }

    struct DocumentNotarized has copy, drop {
        certificate_id: 0x2::object::ID,
        doc_hash: 0x1::string::String,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        timestamp: u64,
        notarizer: address,
    }

    public fun blob_id(arg0: &Certificate) : &0x1::string::String {
        &arg0.blob_id
    }

    public fun description(arg0: &Certificate) : &0x1::string::String {
        &arg0.description
    }

    public fun doc_hash(arg0: &Certificate) : &0x1::string::String {
        &arg0.doc_hash
    }

    public fun doc_type(arg0: &Certificate) : &0x1::string::String {
        &arg0.doc_type
    }

    public fun name(arg0: &Certificate) : &0x1::string::String {
        &arg0.name
    }

    public entry fun notarize(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Certificate{
            id          : 0x2::object::new(arg6),
            doc_hash    : arg0,
            blob_id     : arg1,
            name        : arg2,
            doc_type    : arg3,
            description : arg4,
            timestamp   : v1,
            notarizer   : v0,
        };
        let v3 = DocumentNotarized{
            certificate_id : 0x2::object::id<Certificate>(&v2),
            doc_hash       : v2.doc_hash,
            blob_id        : v2.blob_id,
            name           : v2.name,
            timestamp      : v1,
            notarizer      : v0,
        };
        0x2::event::emit<DocumentNotarized>(v3);
        0x2::transfer::public_transfer<Certificate>(v2, v0);
    }

    public entry fun notarize_with_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        notarize(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun notarizer(arg0: &Certificate) : address {
        arg0.notarizer
    }

    public fun timestamp(arg0: &Certificate) : u64 {
        arg0.timestamp
    }

    public fun verify_hash(arg0: &Certificate, arg1: &0x1::string::String) : bool {
        &arg0.doc_hash == arg1
    }

    // decompiled from Move bytecode v6
}


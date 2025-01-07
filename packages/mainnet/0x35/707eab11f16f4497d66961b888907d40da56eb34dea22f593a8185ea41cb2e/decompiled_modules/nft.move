module 0x35707eab11f16f4497d66961b888907d40da56eb34dea22f593a8185ea41cb2e::nft {
    struct CertificateNFT has store, key {
        id: 0x2::object::UID,
        to: 0x1::string::String,
        registry: 0x1::string::String,
        project: 0x1::string::String,
        reference: 0x1::string::String,
        date: 0x1::string::String,
        offset: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFT has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        to: 0x1::string::String,
        registry: 0x1::string::String,
        project: 0x1::string::String,
        reference: 0x1::string::String,
        date: 0x1::string::String,
        offset: 0x1::string::String,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: &Admin, arg1: CertificateNFT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CertificateNFT>(arg1, arg2);
    }

    public fun url(arg0: &CertificateNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: &Admin, arg1: CertificateNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let CertificateNFT {
            id        : v0,
            to        : _,
            registry  : _,
            project   : _,
            reference : _,
            date      : _,
            offset    : _,
            url       : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_certificate(arg0: &Admin, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = CertificateNFT{
            id        : 0x2::object::new(arg8),
            to        : 0x1::string::utf8(arg1),
            registry  : 0x1::string::utf8(arg2),
            project   : 0x1::string::utf8(arg3),
            reference : 0x1::string::utf8(arg4),
            date      : 0x1::string::utf8(arg5),
            offset    : 0x1::string::utf8(arg6),
            url       : 0x2::url::new_unsafe_from_bytes(arg7),
        };
        let v2 = NFT{
            object_id : 0x2::object::id<CertificateNFT>(&v1),
            creator   : v0,
            to        : v1.to,
            registry  : v1.registry,
            project   : v1.project,
            reference : v1.reference,
            date      : v1.date,
            offset    : v1.offset,
        };
        0x2::event::emit<NFT>(v2);
        0x2::transfer::public_transfer<CertificateNFT>(v1, v0);
    }

    public fun project(arg0: &CertificateNFT) : &0x1::string::String {
        &arg0.project
    }

    public fun reference(arg0: &CertificateNFT) : &0x1::string::String {
        &arg0.reference
    }

    public fun registry(arg0: &CertificateNFT) : &0x1::string::String {
        &arg0.registry
    }

    public fun to(arg0: &CertificateNFT) : &0x1::string::String {
        &arg0.to
    }

    public fun update_date(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.date = 0x1::string::utf8(arg2);
    }

    public fun update_offset(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.offset = 0x1::string::utf8(arg2);
    }

    public fun update_project(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.project = 0x1::string::utf8(arg2);
    }

    public fun update_reference(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reference = 0x1::string::utf8(arg2);
    }

    public fun update_registry(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.registry = 0x1::string::utf8(arg2);
    }

    public fun update_to(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.to = 0x1::string::utf8(arg2);
    }

    public fun update_url(arg0: &Admin, arg1: &mut CertificateNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}


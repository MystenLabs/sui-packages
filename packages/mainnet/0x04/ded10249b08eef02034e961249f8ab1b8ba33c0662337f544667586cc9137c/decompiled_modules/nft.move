module 0x4ded10249b08eef02034e961249f8ab1b8ba33c0662337f544667586cc9137c::nft {
    struct OffestNFT has store, key {
        id: 0x2::object::UID,
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
        registry: 0x1::string::String,
        project: 0x1::string::String,
        reference: 0x1::string::String,
        date: 0x1::string::String,
        offset: 0x1::string::String,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: &Admin, arg1: OffestNFT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<OffestNFT>(arg1, arg2);
    }

    public fun url(arg0: &OffestNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: &Admin, arg1: OffestNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let OffestNFT {
            id        : v0,
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

    public fun new_offset(arg0: &Admin, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = OffestNFT{
            id        : 0x2::object::new(arg7),
            registry  : 0x1::string::utf8(arg1),
            project   : 0x1::string::utf8(arg2),
            reference : 0x1::string::utf8(arg3),
            date      : 0x1::string::utf8(arg4),
            offset    : 0x1::string::utf8(arg5),
            url       : 0x2::url::new_unsafe_from_bytes(arg6),
        };
        let v2 = NFT{
            object_id : 0x2::object::id<OffestNFT>(&v1),
            creator   : v0,
            registry  : v1.registry,
            project   : v1.project,
            reference : v1.reference,
            date      : v1.date,
            offset    : v1.offset,
        };
        0x2::event::emit<NFT>(v2);
        0x2::transfer::public_transfer<OffestNFT>(v1, v0);
    }

    public fun project(arg0: &OffestNFT) : &0x1::string::String {
        &arg0.project
    }

    public fun reference(arg0: &OffestNFT) : &0x1::string::String {
        &arg0.reference
    }

    public fun registry(arg0: &OffestNFT) : &0x1::string::String {
        &arg0.registry
    }

    public fun update_date(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.date = 0x1::string::utf8(arg2);
    }

    public fun update_offset(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.offset = 0x1::string::utf8(arg2);
    }

    public fun update_project(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.project = 0x1::string::utf8(arg2);
    }

    public fun update_reference(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reference = 0x1::string::utf8(arg2);
    }

    public fun update_registry(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.registry = 0x1::string::utf8(arg2);
    }

    public fun update_url(arg0: &Admin, arg1: &mut OffestNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}


module 0x3ec07ff990e6125ee8a2e3464067e0ca3ed953496b35df5b06ffe5905b337d3e::user_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PrintNetNFT has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        provenance_metadata: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &PrintNetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: PrintNetNFT) {
        let PrintNetNFT {
            id                  : v0,
            owner               : _,
            name                : _,
            description         : _,
            url                 : _,
            provenance_metadata : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PrintNetNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PrintNetNFT{
            id                  : 0x2::object::new(arg6),
            owner               : arg5,
            name                : 0x1::string::utf8(arg1),
            description         : 0x1::string::utf8(arg2),
            url                 : 0x2::url::new_unsafe_from_bytes(arg3),
            provenance_metadata : 0x1::string::utf8(arg4),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg6),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<PrintNetNFT>(v0, arg5);
    }

    public fun name(arg0: &PrintNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun owner(arg0: &PrintNetNFT) : address {
        arg0.owner
    }

    public fun provenance_metadata(arg0: &PrintNetNFT) : &0x1::string::String {
        &arg0.provenance_metadata
    }

    // decompiled from Move bytecode v6
}


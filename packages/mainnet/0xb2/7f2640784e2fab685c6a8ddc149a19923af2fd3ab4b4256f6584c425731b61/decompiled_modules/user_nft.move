module 0xb27f2640784e2fab685c6a8ddc149a19923af2fd3ab4b4256f6584c425731b61::user_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
        value: u64,
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
        let v0 = AdminCap{
            id    : 0x2::object::new(arg0),
            value : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, u64_to_string(arg0.value));
        let v1 = PrintNetNFT{
            id                  : 0x2::object::new(arg6),
            owner               : arg5,
            name                : v0,
            description         : 0x1::string::utf8(arg2),
            url                 : 0x2::url::new_unsafe_from_bytes(arg3),
            provenance_metadata : 0x1::string::utf8(arg4),
        };
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : 0x2::tx_context::sender(arg6),
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<PrintNetNFT>(v1, arg5);
        arg0.value = arg0.value + 1;
    }

    public fun name(arg0: &PrintNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun nftSupply(arg0: &AdminCap) : u64 {
        arg0.value
    }

    public fun owner(arg0: &PrintNetNFT) : address {
        arg0.owner
    }

    public fun provenance_metadata(arg0: &PrintNetNFT) : &0x1::string::String {
        &arg0.provenance_metadata
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}


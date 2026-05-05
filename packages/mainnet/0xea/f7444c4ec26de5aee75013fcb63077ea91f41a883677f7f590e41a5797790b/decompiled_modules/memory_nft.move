module 0xeaf7444c4ec26de5aee75013fcb63077ea91f41a883677f7f590e41a5797790b::memory_nft {
    struct MEMORY_NFT has drop {
        dummy_field: bool,
    }

    struct MemoryNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        glb_url: 0x1::string::String,
        creator: address,
        edition: u64,
        timestamp: u64,
    }

    public fun description(arg0: &MemoryNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun edition(arg0: &MemoryNFT) : u64 {
        arg0.edition
    }

    public fun glb_url(arg0: &MemoryNFT) : &0x1::string::String {
        &arg0.glb_url
    }

    public fun image_url(arg0: &MemoryNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: MEMORY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MEMORY_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MemoryNFT>(&v0, arg1);
        0x2::display::add<MemoryNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MemoryNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MemoryNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MemoryNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Mario Jones Syndicate"));
        0x2::display::add<MemoryNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://mariojones.xyz"));
        0x2::display::update_version<MemoryNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MemoryNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryNFT{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            glb_url     : arg3,
            creator     : 0x2::tx_context::sender(arg6),
            edition     : arg4,
            timestamp   : 0x2::tx_context::epoch(arg6),
        };
        0x2::transfer::public_transfer<MemoryNFT>(v0, arg5);
    }

    public fun name(arg0: &MemoryNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}


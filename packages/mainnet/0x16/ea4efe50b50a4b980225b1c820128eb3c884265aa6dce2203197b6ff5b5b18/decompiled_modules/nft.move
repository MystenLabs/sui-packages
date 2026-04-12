module 0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft {
    struct MegaTowerNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        last_nonce: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun attributes(arg0: &MegaTowerNFT) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun description(arg0: &MegaTowerNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun id(arg0: &MegaTowerNFT) : &0x2::object::UID {
        &arg0.id
    }

    public fun image_url(arg0: &MegaTowerNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MegaTowerNFT>(&v0, arg1);
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::constants::project_url()));
        0x2::display::add<MegaTowerNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::constants::creator()));
        0x2::display::update_version<MegaTowerNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MegaTowerNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun last_nonce(arg0: &MegaTowerNFT) : u64 {
        arg0.last_nonce
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : MegaTowerNFT {
        MegaTowerNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            attributes  : arg3,
            last_nonce  : 0,
        }
    }

    public fun name(arg0: &MegaTowerNFT) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun set_last_nonce(arg0: &mut MegaTowerNFT, arg1: u64) {
        arg0.last_nonce = arg1;
    }

    public(friend) fun update_attributes(arg0: &mut MegaTowerNFT, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        arg0.attributes = arg1;
    }

    public(friend) fun update_image_url(arg0: &mut MegaTowerNFT, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    // decompiled from Move bytecode v7
}


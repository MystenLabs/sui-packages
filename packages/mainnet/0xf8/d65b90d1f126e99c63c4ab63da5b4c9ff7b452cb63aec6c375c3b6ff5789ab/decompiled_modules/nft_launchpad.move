module 0x998ee80bcf5aec9c302abc54b2be28a178572360eae32085d385a0db2fa8164e::nft_launchpad {
    struct AINft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        metadata_blob_id: 0x1::string::String,
        style: 0x1::string::String,
        resolution: 0x1::string::String,
        prompt: 0x1::string::String,
        creator: address,
    }

    struct NFT_LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        image_blob_id: 0x1::string::String,
        metadata_blob_id: 0x1::string::String,
    }

    public entry fun batch_mint(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            mint_nft(*0x1::vector::borrow<0x1::string::String>(&arg0, v0), *0x1::vector::borrow<0x1::string::String>(&arg1, v0), *0x1::vector::borrow<0x1::string::String>(&arg2, v0), *0x1::vector::borrow<0x1::string::String>(&arg3, v0), *0x1::vector::borrow<0x1::string::String>(&arg4, v0), *0x1::vector::borrow<0x1::string::String>(&arg5, v0), *0x1::vector::borrow<0x1::string::String>(&arg6, v0), *0x1::vector::borrow<address>(&arg7, v0), arg8);
            v0 = v0 + 1;
        };
    }

    public entry fun burn(arg0: AINft, arg1: &mut 0x2::tx_context::TxContext) {
        let AINft {
            id               : v0,
            name             : _,
            description      : _,
            image_blob_id    : _,
            metadata_blob_id : _,
            style            : _,
            resolution       : _,
            prompt           : _,
            creator          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &AINft) : address {
        arg0.creator
    }

    public fun description(arg0: &AINft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_blob_id(arg0: &AINft) : &0x1::string::String {
        &arg0.image_blob_id
    }

    fun init(arg0: NFT_LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_LAUNCHPAD>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"style"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"resolution"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{style}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{resolution}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suigen.app"));
        let v5 = 0x2::display::new_with_fields<AINft>(&v0, v1, v3, arg1);
        0x2::display::update_version<AINft>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AINft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun metadata_blob_id(arg0: &AINft) : &0x1::string::String {
        &arg0.metadata_blob_id
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = AINft{
            id               : 0x2::object::new(arg8),
            name             : arg0,
            description      : arg1,
            image_blob_id    : arg2,
            metadata_blob_id : arg3,
            style            : arg4,
            resolution       : arg5,
            prompt           : arg6,
            creator          : 0x2::tx_context::sender(arg8),
        };
        let v1 = NFTMinted{
            nft_id           : 0x2::object::uid_to_inner(&v0.id),
            name             : v0.name,
            creator          : v0.creator,
            image_blob_id    : v0.image_blob_id,
            metadata_blob_id : v0.metadata_blob_id,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<AINft>(v0, arg7);
    }

    public fun name(arg0: &AINft) : &0x1::string::String {
        &arg0.name
    }

    public fun prompt(arg0: &AINft) : &0x1::string::String {
        &arg0.prompt
    }

    public fun resolution(arg0: &AINft) : &0x1::string::String {
        &arg0.resolution
    }

    public fun style(arg0: &AINft) : &0x1::string::String {
        &arg0.style
    }

    public entry fun update_description(arg0: &mut AINft, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
    }

    // decompiled from Move bytecode v6
}


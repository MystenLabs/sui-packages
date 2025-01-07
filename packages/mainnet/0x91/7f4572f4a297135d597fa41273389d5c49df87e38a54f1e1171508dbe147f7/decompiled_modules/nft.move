module 0x5823cad42a132d52accea7b1413e8c911d9d63167f55dcd01774eaadee4d1ade::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct AtlanNFT has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &AtlanNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public entry fun burn(arg0: AtlanNFT) {
        let AtlanNFT {
            id          : v0,
            index       : _,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &AtlanNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description} - Minted by Atlansui"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://atlansui.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AtlanNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AtlanNFT>(&mut v5);
        let v6 = Collection{
            id      : 0x2::object::new(arg1),
            counter : 0,
        };
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v7);
        0x2::transfer::public_transfer<0x2::display::Display<AtlanNFT>>(v5, v7);
        0x2::transfer::public_share_object<Collection>(v6);
    }

    public entry fun mint(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AtlanNFT{
            id          : 0x2::object::new(arg4),
            index       : arg0.counter,
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        arg0.counter = arg0.counter + 1;
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::transfer<AtlanNFT>(v0, v1);
    }

    public fun name(arg0: &AtlanNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut AtlanNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}


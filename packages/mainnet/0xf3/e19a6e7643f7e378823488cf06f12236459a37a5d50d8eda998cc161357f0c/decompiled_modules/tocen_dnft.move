module 0xf3e19a6e7643f7e378823488cf06f12236459a37a5d50d8eda998cc161357f0c::tocen_dnft {
    struct DynamicNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        sum_nft: u64,
        timestamp_mint: u64,
    }

    public entry fun transfer(arg0: DynamicNFT, arg1: address) {
        0x2::transfer::transfer<DynamicNFT>(arg0, arg1);
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InfoCollection{
            id              : 0x2::object::new(arg0),
            name_nft        : 0x1::string::utf8(0xf3e19a6e7643f7e378823488cf06f12236459a37a5d50d8eda998cc161357f0c::config::get_name_dnft()),
            description_nft : 0x1::string::utf8(0xf3e19a6e7643f7e378823488cf06f12236459a37a5d50d8eda998cc161357f0c::config::get_description_dnft()),
            ourl            : 0x1::string::utf8(0xf3e19a6e7643f7e378823488cf06f12236459a37a5d50d8eda998cc161357f0c::config::get_url()),
            sum_nft         : 0,
            timestamp_mint  : 0,
        };
        0x2::transfer::share_object<InfoCollection>(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DynamicNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg2),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg1),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::transfer<DynamicNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}


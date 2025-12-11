module 0x25bffef941168af0c96a8e934a3eca8986d2fe38cab832c817de87873e486f65::nft_module {
    struct Metadata has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MiloNFT has store, key {
        id: 0x2::object::UID,
        metadata: Metadata,
        creator: address,
        blob_id: 0x1::string::String,
    }

    public fun get_blob_id(arg0: &MiloNFT) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_creator(arg0: &MiloNFT) : address {
        arg0.creator
    }

    public fun get_description(arg0: &MiloNFT) : 0x1::string::String {
        arg0.metadata.description
    }

    public fun get_name(arg0: &MiloNFT) : 0x1::string::String {
        arg0.metadata.name
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Metadata{
            name        : arg0,
            description : arg1,
        };
        let v1 = MiloNFT{
            id       : 0x2::object::new(arg3),
            metadata : v0,
            creator  : 0x2::tx_context::sender(arg3),
            blob_id  : arg2,
        };
        0x2::transfer::transfer<MiloNFT>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun transfer_nft(arg0: MiloNFT, arg1: address) {
        0x2::transfer::transfer<MiloNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


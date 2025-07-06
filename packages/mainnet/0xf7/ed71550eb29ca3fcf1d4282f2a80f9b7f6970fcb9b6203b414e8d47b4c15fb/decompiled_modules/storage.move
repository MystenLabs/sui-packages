module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::storage {
    struct NFTImageReference has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        image_url: 0x1::string::String,
        owner: address,
    }

    struct NFTImageStoredEvent has copy, drop {
        nft_id: 0x2::object::ID,
        image_url: 0x1::string::String,
        owner: address,
    }

    public entry fun create_and_transfer_nft_image_reference(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = store_nft_image_reference(arg0, arg1, arg2);
        0x2::transfer::transfer<NFTImageReference>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_image_url(arg0: &NFTImageReference) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_nft_id(arg0: &NFTImageReference) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_owner(arg0: &NFTImageReference) : address {
        arg0.owner
    }

    public fun is_valid_url(arg0: 0x1::string::String) : bool {
        true
    }

    public fun store_nft_image_reference(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : NFTImageReference {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = NFTImageReference{
            id        : 0x2::object::new(arg2),
            nft_id    : arg0,
            image_url : arg1,
            owner     : v0,
        };
        let v2 = NFTImageStoredEvent{
            nft_id    : arg0,
            image_url : arg1,
            owner     : v0,
        };
        0x2::event::emit<NFTImageStoredEvent>(v2);
        v1
    }

    public fun transfer_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

